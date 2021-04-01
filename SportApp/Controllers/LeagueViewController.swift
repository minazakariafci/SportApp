//
//  LeagueViewController.swift
//  SportApp
//
//  Created by mac on 3/24/21.
//

import UIKit
import JGProgressHUD
class LeagueViewController: UIViewController {
    var sportName : String?
    
    @IBOutlet weak var tableView: UITableView!
    let legueNameurl : URLS = .legueNameUrl
    let lequeDetailsUrl :URLS = .lequeDetailsUrl
    let hud = JGProgressHUD()
    var image : String = ""
    var data = [LegueDetailsModel](){
        didSet{
            self.getLegueDetails()
        }
    }
    func getLegueDetails(){
        self.hud.show(in: self.view)
        for  i in (0..<self.data.count){
            self.dispatchGroup.enter()
            APIClient.instance.getData(url: self.lequeDetailsUrl.rawValue,id : self.data[i].idLeague ?? "") { (sport: legueIDModel?, error) in
                print(sport)
                if error != nil {
                    print(error!)
                }else{
                    guard let LequeDetails = sport else { return  }
                    self.dataLegueDetails .append(LequeDetails.leagues![0])
                    print(self.dataLegueDetails.count)
                }
                self.dispatchGroup.leave()
            }
        }
        self.dispatchGroup.notify(queue: .main) {
            self.sortData()
            self.hud.dismiss()
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
    
    var dataLegueDetails = [LeaguesDetailsIDModel]()
    var YoutubeChannels : [String] = []
    var limit = 20
    
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "LegueTableViewCell", bundle: .main), forCellReuseIdentifier: "LegueTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
        self.title = "Leagues"
        self.serviceCall()
    }
    
    
    func serviceCall(){
        APIClient.instance.getData(url: self.legueNameurl.rawValue) { (sport: LegueModel?, error) in
            if let error = error {
                print(error)
            }else{
                guard let datasports = sport else { return  }
                self.hud.show(in: self.view)
                self.data = (datasports.leagues?.filter({ (data) -> Bool in
                    data.strSport == self.sportName
                }))!
                
            }
            self.tableView.reloadData()
            self.hud.dismiss()
            print(self.dataLegueDetails)
        }
    }
    
}

extension LeagueViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LegueTableViewCell", for: indexPath) as! LegueTableViewCell
        cell.selectionStyle = .none
        if dataLegueDetails.count>indexPath.row{
            cell.nameLabel.text = dataLegueDetails[indexPath.row].strLeague
            cell.legueImageView.imageUrl = dataLegueDetails[indexPath.row].strBadge ?? ""
            
            cell.youtubeButton.addTarget(self, action: #selector(oneTapped(_:)), for: .touchUpInside)
            cell.youtubeButton.tag = indexPath.row
            
        }
        
        return cell
    }
    @objc func oneTapped(_ sender: UIButton) {
        let newViewController =  self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let index = sender.tag
        if dataLegueDetails[index].strYoutube == ""{
            let alert = UIAlertController(title: "Warning!", message: "No Youtube channel for \(dataLegueDetails[index].strLeague ?? "")", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                return
            }))
            
            self.present(alert, animated: true, completion: nil)
        }else{
            newViewController.link = dataLegueDetails[index].strYoutube ?? ""
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seque" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! LeagueDetailsViewController
                controller.legueId = data[indexPath.row].idLeague ?? ""
                controller.leagueImage = dataLegueDetails[indexPath.row].strBadge ?? ""
                controller.leagueName = data[indexPath.row].strLeague ?? ""
                controller.youtubeLink = dataLegueDetails[indexPath.row].strYoutube ??  ""
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let legue =  self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        let cell = tableView.dequeueReusableCell(withIdentifier: "LegueTableViewCell", for: indexPath) as! LegueTableViewCell
        legue.legueId = data[indexPath.row].idLeague ?? ""
        self.performSegue(withIdentifier: "seque", sender: self)
        
        
    }
    
}
