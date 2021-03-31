//
//  FavouriteLeagueViewController.swift
//  SportApp
//
//  Created by mac on 3/28/21.
//

import UIKit
import CoreData
class FavouriteLeagueViewController: UIViewController {
    let dispatchGroup = DispatchGroup()
    let lequeDetailsUrl :URLS = .lequeDetailsUrl
    var data = [LeaguesDetailsIDModel]()
    @IBOutlet weak var tableView: UITableView!
    var leguesCoreData = [LegueCoreData](){
        didSet{
            //            self.serviceCall()
        }
    }
    func sortData() {
        leguesCoreData.sort(by: {(id1, id2) -> Bool in
            if let idleague1 = id1.iD, let idleague2 = id2.iD {
                return idleague1 < idleague2
            }
            return false
        })
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "LegueTableViewCell", bundle: .main), forCellReuseIdentifier: "LegueTableViewCell")
        self.title = "Favourite Leagues"
        tableView.tableFooterView = UIView(frame: .zero)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getCoreDate()
        self.sortData()
        self.tableView.reloadData()
    }
    
    func getCoreDate() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mangedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LegueCoreData")
        do {
            try  leguesCoreData = (mangedContext.fetch(fetchRequest) as? [LegueCoreData])!
            tableView.reloadData()
        } catch let error as NSError {
            print(error)
        }
    }
    func askForQuit(_ completion:@escaping (_ canQuit: Bool) -> Void) {
        let alert = UIAlertController(title: "Warning!", message: "Check Your Connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            completion(true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            completion(false)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func quit() {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        sleep(2)
        exit(2)
    }
    func serviceCall(){
        data.removeAll()
        for  i in (0..<self.leguesCoreData.count){
            self.dispatchGroup.enter()
            guard APIClient.instance.checkInternet() else {
                self.askForQuit { (canQuit) in
                    if canQuit {
                        self.quit()
                    }
                }
                return
            }
            APIClient.instance.getData(url: self.lequeDetailsUrl.rawValue,id : self.leguesCoreData[i].iD! ) { (sport: legueIDModel?, error) in
                print(sport)
                if error != nil {
                    print(error!)
                }else{
                    guard let LequeDetails = sport else { return  }
                    self.data .append(LequeDetails.leagues![0])
                }
                self.dispatchGroup.leave()
            }
        }
        self.dispatchGroup.notify(queue: .main) {
            self.sortData()
            self.tableView.reloadData()
        }
    }
}

extension FavouriteLeagueViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leguesCoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LegueTableViewCell", for: indexPath) as! LegueTableViewCell
        cell.selectionStyle = .none
        if leguesCoreData.count>indexPath.row{
            cell.nameLabel.text = leguesCoreData[indexPath.row].legueName
            cell.legueImageView.imageUrl = leguesCoreData[indexPath.row].image ?? ""
            cell.youtubeButton.addTarget(self, action: #selector(oneTapped(_:)), for: .touchUpInside)
            cell.youtubeButton.tag = indexPath.row
        }
        return cell
    }
    @objc func oneTapped(_ sender: UIButton) {
        let newViewController =  self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        guard APIClient.instance.checkInternet() else {
            self.askForQuit { (canQuit) in
                if canQuit {
                    self.quit()
                }
            }
            return
        }
        let index = sender.tag
        if leguesCoreData[index].youtubeLink == ""{
            let alert = UIAlertController(title: "Warning!", message: "No Youtube channel for \(leguesCoreData[index].legueName ?? "")", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                return
            }))
            
            self.present(alert, animated: true, completion: nil)
        }else{
            newViewController.link = leguesCoreData[index].youtubeLink
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seque" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! LeagueDetailsViewController
                controller.legueId = (leguesCoreData[indexPath.row].iD as? String)!
                controller.leagueName = (leguesCoreData[indexPath.row].legueName as? String)!
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let legue =  self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        guard APIClient.instance.checkInternet() else {
            self.askForQuit { (canQuit) in
                if canQuit {
                    self.quit()
                }
            }
            return
        }
        legue.legueId = (leguesCoreData[indexPath.row].iD as? String)!
        self.performSegue(withIdentifier: "seque", sender: self)
        
        
    }
    
    
}
