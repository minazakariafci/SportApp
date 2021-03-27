//
//  LeagueDetailsViewController.swift
//  SportApp
//
//  Created by mac on 3/24/21.
//

import UIKit

class LeagueDetailsViewController: UIViewController {
    
    @IBOutlet weak var teamCollectionView: UICollectionView!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    var legueId : String?
    var eventDetails =  [Events]()
    let eventDetailsUrl = "https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id="
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "EventCollectionViewCell")
        self.resultCollectionView.register(UINib(nibName: "ResultCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ResultCollectionViewCell")
        self.teamCollectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TeamCollectionViewCell")
        self.serviceCall()
        self.eventCollectionView.reloadData()
        self.resultCollectionView.reloadData()
        self.teamCollectionView.reloadData()
    }
    
    func serviceCall(){
        APIClient.instance.getData(url: self.eventDetailsUrl,id : legueId!) { (sport: EventModel?, error) in
            if let error = error {
                print(error)
            }else{
                guard let datasports = sport else { return  }
                self.eventDetails = (datasports.events)!
                DispatchQueue.main.async {
                    self.eventCollectionView.reloadData()
                    self.resultCollectionView.reloadData()
                    self.teamCollectionView.reloadData()
                }
            }
            
        }
    }
}
extension LeagueDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: ((collectionView.frame.width) - 2.5), height: collectionView.frame.height)
        case 1:
            return CGSize(width: (collectionView.frame.width) - 2.5 , height: 200)
        case 2:
            return CGSize(width: (collectionView.frame.width/3) - 2.5 , height: 200)
        default:
            return CGSize(width: ((collectionView.frame.width/3) - 2.5), height: 200)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return eventDetails.count
        case 1:
            return eventDetails.count
        case 2:
            return 15
            
        default:
            return 15
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
            cell.eventLabel.text = eventDetails[indexPath.row].strEvent
            cell.dateLabel.text = eventDetails[indexPath.row].dateEvent! + " AT " + eventDetails[indexPath.row].strTime!
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as! ResultCollectionViewCell
            cell.homeTeamLabel.text = eventDetails[indexPath.row].strHomeTeam
            cell.homeScoreLabel.text = eventDetails[indexPath.row].intHomeScore
            cell.awayTeamLabel.text = eventDetails[indexPath.row].strAwayTeam
            cell.awayScoreLabel.text = eventDetails[indexPath.row].intAwayScore
            cell.dateLabel.text = eventDetails[indexPath.row].dateEvent! + " AT " + eventDetails[indexPath.row].strTime!
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
            DispatchQueue.main.async {
                cell.teamImageView.maskCircle()
            }
          
            return cell
            
        }
    }
}
