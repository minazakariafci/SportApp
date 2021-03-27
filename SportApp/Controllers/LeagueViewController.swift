//
//  LeagueViewController.swift
//  SportApp
//
//  Created by mac on 3/24/21.
//

import UIKit

class LeagueViewController: UIViewController {
    var sportName : String?
    
    @IBOutlet weak var tableView: UITableView!
    let legueNameUrl = "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php"
    let lequeDetailsUrl = "https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id="
    var data = [LegueDetailsModel](){
        didSet{
            for  i in (0..<self.data.count){
                self.dispatchGroup.enter()
                APIClient.instance.getData(url: self.lequeDetailsUrl,id : self.data[i].idLeague!) { (sport: legueIDModel?, error) in
                    print(sport!)
                    if error != nil {
                        print(error!)
                    }else{
                        guard let LequeDetailsFareed = sport else { return  }
                        self.dataLegueDetails .append(LequeDetailsFareed.leagues![0])
                        //                            let legues = self.dataLegueDetails[i]
                        //                            self.YoutubeChannels.append(legues[i].strYoutube!)
                        self.badgesImages?.append(self.dataLegueDetails[i].strBadge!)
                        self.tableView.reloadData()
                        print(self.dataLegueDetails.count)
                        print(self.badgesImages?.count)
                    }
                }
                self.dispatchGroup.leave()
            }
        }
    }
    var dataLegueDetails = [LeaguesDetailsIDModel]()
    var YoutubeChannels : [String] = []
    var badgesImages : [String]?
    var limit = 20
    
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "LegueTableViewCell", bundle: .main), forCellReuseIdentifier: "LegueTableViewCell")
        self.serviceCall()
        self.tableView.reloadData()
    }
    
    func serviceCall(){
        APIClient.instance.getData(url: self.legueNameUrl) { (sport: LegueModel?, error) in
            if let error = error {
                print(error)
            }else{
                guard let datasports = sport else { return  }
                self.data = (datasports.leagues?.filter({ (data) -> Bool in
                    data.strSport == self.sportName
                }))!
                
            }
            self.tableView.reloadData()
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
        cell.nameLabel.text = data[indexPath.row].strLeague
        if dataLegueDetails.count>indexPath.row{
            cell.legueImageView.imageUrl = dataLegueDetails[indexPath.row].strBadge!
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seque" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! LeagueDetailsViewController
                controller.legueId = data[indexPath.row].idLeague
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let legue =  self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        legue.legueId = data[indexPath.row].idLeague
        self.performSegue(withIdentifier: "seque", sender: self)

        
    }
    
}
