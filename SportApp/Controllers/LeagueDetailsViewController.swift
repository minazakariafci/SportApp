//
//  LeagueDetailsViewController.swift
//  SportApp
//
//  Created by mac on 3/24/21.
//

import UIKit
import CoreData
class LeagueDetailsViewController: UIViewController {
    
    @IBOutlet weak var teamCollectionView: UICollectionView!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    var legueId : String = ""
    var teamDetails = [Teams]()
    var leguesCoreData = [LegueCoreData]()
    var leagueImage : String = ""
    var leagueName : String = ""
    var youtubeLink : String = ""
    
    var eventDetails =  [Events](){
        didSet{
            APIClient.instance.getData(url: self.teamDetailsUrl.rawValue, id : legueId ) { (sport: TeamModel?, error) in
                if let error = error {
                    print(error)
                }else{
                    guard let datasports = sport else { return  }
                    self.teamDetails = (datasports.teams)!
                    DispatchQueue.main.async {
                        self.teamCollectionView.reloadData()
                    }
                }
                
            }
        }
    }
    var teamDetailsUrl : URLS = .teamDeatilsUrl
    var url : URLS = .eventDetailsUrl
    var favouriteButton: UIBarButtonItem{
        let favouriteButton = UIBarButtonItem(image: UIImage(named: "heart (1)"), landscapeImagePhone: nil, style: .done, target: self, action: #selector(favourite))
        favouriteButton.tintColor = .red
        return favouriteButton
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "EventCollectionViewCell")
        self.resultCollectionView.register(UINib(nibName: "ResultCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ResultCollectionViewCell")
        self.teamCollectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TeamCollectionViewCell")
        self.getCoreDate()
        self.serviceCall()
        self.navigationItem.rightBarButtonItem = self.favouriteButton
        self.configure()
        self.title = leagueName
        self.eventCollectionView.reloadData()
        self.resultCollectionView.reloadData()
        self.teamCollectionView.reloadData()
    }
    func getCoreDate() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mangedContext = appDelegate.persistentContainer.viewContext
         let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LegueCoreData")
        do {
            try  leguesCoreData = (mangedContext.fetch(fetchRequest) as? [LegueCoreData])!
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    @objc private func favourite(){
        if let item = self.navigationItem.rightBarButtonItem{
            if item.image == UIImage(named: "heart (1)"){
                item.image = UIImage(named: "heart (2)")
                self.SaveFavouriteLegue()
            }
            else if item.image == UIImage(named: "heart (2)"){
             item.image = UIImage(named: "heart (1)")
//                self.DeleteFavouriteLegue()
                self.deleteRecords()
            }
        }
    }
    func configure(){
        if let item = self.navigationItem.rightBarButtonItem{
        if leguesCoreData.count > 0{
        for  i in (0..<self.leguesCoreData.count){
            if  legueId == leguesCoreData[i].iD{
                item.image = UIImage(named: "heart (2)")
            }
        }
            
        }else{
            item.image = UIImage(named: "heart (1)")
        }
        }
    }

    func SaveFavouriteLegue(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mangedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "LegueCoreData", in: mangedContext)
        let legueCoreData = NSManagedObject(entity: entity!, insertInto: mangedContext)
        
        legueCoreData.setValue(legueId, forKey: "iD")
        legueCoreData.setValue(leagueName, forKey: "legueName")
        legueCoreData.setValue(leagueImage, forKey: "image")
        legueCoreData.setValue(youtubeLink, forKey: "youtubeLink")
        do {
            try mangedContext.save()
            print(legueCoreData)
            print("Done")
        } catch let error as NSError {
            print(error)
        }
        appDelegate.saveContext()
    }

    func deleteRecords() -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mangedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LegueCoreData")
        let Predicate = NSPredicate(format: "iD==\(String(describing: legueId))")
         let result = try? mangedContext.fetch(fetchRequest)
        _ = result as! [LegueCoreData]
        fetchRequest.predicate = Predicate
        let objects = try! mangedContext.fetch(fetchRequest)
        for obj in objects {
            mangedContext.delete(obj as! NSManagedObject)
        }
        do {
            try mangedContext.save()
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }

    func serviceCall(){
        APIClient.instance.getData(url: self.url.rawValue ,id : legueId) { (sport: EventModel?, error) in
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
            return teamDetails.count
            
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
            cell.teamImageView.imageUrl = teamDetails[indexPath.row].strTeamBadge!
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
            DispatchQueue.main.async {
                cell.teamImageView.maskCircle()
            }
          
            return cell
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seque" {
            if let indexPath = self.teamCollectionView.indexPathsForSelectedItems?.first {
                let controller = segue.destination as! TeamDetailsViewController
                controller.teamId = teamDetails[indexPath.row].idTeam!
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 2:
        let legue =  self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
        self.performSegue(withIdentifier: "seque", sender: self)
        default:
            return
        }
    }
    
}
