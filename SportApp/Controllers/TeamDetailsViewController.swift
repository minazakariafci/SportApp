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
    var teamName = ""
    let TeamDetailsIDUrl :URLS = .TeamDetailsIDUrl
    var data = [TeamsDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamImageView.maskCircle()
        self.serviceCall()
        self.title = teamName
        // Do any additional setup after loading the view.
    }
    
    func serviceCall(){
        APIClient.instance.getData(url: self.TeamDetailsIDUrl.rawValue ,id : teamId) { (sport: TeamIDModel?, error) in
            if let error = error {
                print(error)
            }else{
                guard let datasports = sport else { return  }
                if let teamDetails = (datasports.teams){
                    self.data = teamDetails
                    }
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
        if data[0].strFacebook == ""{
            let alert = UIAlertController(title: "Warning!", message: "Not Facebook for \(data[0].strTeam ?? "")", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                return
            }))
           self.present(alert, animated: true, completion: nil)
        }else{
        newViewController.link = data[0].strFacebook
        self.navigationController?.pushViewController(newViewController, animated: true)
        }
        }
    @IBAction func youtubeButton(_ sender: UIButton) {
        let newViewController =  self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        if data[0].strYoutube == ""{
            let alert = UIAlertController(title: "Warning!", message: "No Youtube channel for \(data[0].strTeam ?? "")", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                return
            }))
           self.present(alert, animated: true, completion: nil)
        }else{
        newViewController.link = data[0].strYoutube
        self.navigationController?.pushViewController(newViewController, animated: true)
        }
        }
    @IBAction func instgramButton(_ sender: UIButton) {
        let newViewController =  self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        if data[0].strInstagram == ""{
            let alert = UIAlertController(title: "Warning!", message: "Not Instagram for \(data[0].strTeam ?? "")", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                return
            }))
           self.present(alert, animated: true, completion: nil)
        }else{
        newViewController.link = data[0].strInstagram
        self.navigationController?.pushViewController(newViewController, animated: true)
        }
        }
    @IBAction func twiteerButton(_ sender: UIButton) {
        let newViewController =  self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        if data[0].strTwitter == ""{
            let alert = UIAlertController(title: "Warning!", message: "Not Twitter for \(data[0].strTeam ?? "")", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                return
            }))
           self.present(alert, animated: true, completion: nil)
        }else{
         newViewController.link = data[0].strTwitter
        self.navigationController?.pushViewController(newViewController, animated: true)
        }
        }
}
