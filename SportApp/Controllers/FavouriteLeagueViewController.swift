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
    var dataLegueDetails = [LeaguesDetailsIDModel]()
    @IBOutlet weak var tableView: UITableView!
    var leguesCoreData = [LegueCoreData](){
        didSet{
            for  i in (0..<self.leguesCoreData.count){
                self.dispatchGroup.enter()
                APIClient.instance.getData(url: self.lequeDetailsUrl.rawValue,id : self.leguesCoreData[i].iD! ) { (sport: legueIDModel?, error) in
                    print(sport!)
                    if error != nil {
                        print(error!)
                    }else{
                        guard let LequeDetailsFareed = sport else { return  }
                        
                        self.dataLegueDetails .append(LequeDetailsFareed.leagues![0])
                       
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
    func sortData() {
        dataLegueDetails.sort(by: {(id1, id2) -> Bool in
            if let idleague1 = id1.idLeague, let idleague2 = id2.idLeague {
                return idleague1 < idleague2
            }
            return false
        })
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.getCoreDate()
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "LegueTableViewCell", bundle: .main), forCellReuseIdentifier: "LegueTableViewCell")
        self.getCoreDate()
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

}

extension FavouriteLeagueViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leguesCoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LegueTableViewCell", for: indexPath) as! LegueTableViewCell
        if dataLegueDetails.count>indexPath.row{
            cell.nameLabel.text = dataLegueDetails[indexPath.row].strLeague
            cell.legueImageView.imageUrl = dataLegueDetails[indexPath.row].strBadge!
            cell.youtubeButton.addTarget(self, action: #selector(oneTapped(_:)), for: .touchUpInside)
            cell.youtubeButton.tag = indexPath.row
        }
        return cell
    }
    @objc func oneTapped(_ sender: UIButton) {
            let newViewController =  self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let index = sender.tag
        newViewController.youtubeChannels = dataLegueDetails[index].strYoutube
            self.navigationController?.pushViewController(newViewController, animated: true)
            }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seque" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! LeagueDetailsViewController
                controller.legueId = leguesCoreData[indexPath.row].iD as? String
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let legue =  self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        legue.legueId = leguesCoreData[indexPath.row].iD as? String
        self.performSegue(withIdentifier: "seque", sender: self)

        
    }

    
}
