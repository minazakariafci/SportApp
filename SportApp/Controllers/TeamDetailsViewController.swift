//
//  TeamDetailsViewController.swift
//  SportApp
//
//  Created by mac on 3/29/21.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    var teamId  = ""
    let TeamDetailsIDUrl :URLS = .TeamDetailsIDUrl
    var data = [TeamsDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        teamImageView.maskCircle()
        self.serviceCall()
        // Do any additional setup after loading the view.
    }
    
    func serviceCall(){
        APIClient.instance.getData(url: self.TeamDetailsIDUrl.rawValue ,id : teamId) { (sport: TeamIDModel?, error) in
            if let error = error {
                print(error)
            }else{
                guard let datasports = sport else { return  }
                self.data = (datasports.teams)!
                DispatchQueue.main.async {
                    self.teamImageView.imageUrl = self.data[0].strTeamBadge!
                    self.descriptionLabel.text = self.data[0].strDescriptionEN
                    self.teamLabel.text = self.data[0].strTeam
                }
            }
            
        }
    }

    @IBAction func facebookButton(_ sender: UIButton) {
        let newViewController =  self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        newViewController.link = data[0].strFacebook
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @IBAction func youtubeButton(_ sender: UIButton) {
        let newViewController =  self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        newViewController.link = data[0].strYoutube
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @IBAction func unstgramButton(_ sender: UIButton) {
        let newViewController =  self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        newViewController.link = data[0].strInstagram
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @IBAction func twiteerButton(_ sender: UIButton) {
        let newViewController =  self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
         newViewController.link = data[0].strTwitter
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
