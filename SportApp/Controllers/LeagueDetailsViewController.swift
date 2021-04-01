//
//  LeagueDetailsViewController.swift
//  SportApp
//
//  Created by mac on 3/24/21.
//

import UIKit
import CoreData
import JGProgressHUD
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
    var homeTeamDetails = [TeamsDetails]()
    var awayTeamDetails = [TeamsDetails]()
    let dispatchGroup = DispatchGroup()
    let hud = JGProgressHUD()
    var eventDetails =  [Events](){
        didSet{
            self.getTeamDetails()
        }
    }
    let TeamDetailsIDUrl :URLS = .TeamDetailsIDUrl
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
        self.getAllTeams()
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
                self.hud.show(in: self.view)
                guard let datasports = sport else { return  }
                if let events = (datasports.events){
                    self.eventDetails = events
                }
                
                DispatchQueue.main.async {
                    self.eventCollectionView.reloadData()
                    self.resultCollectionView.reloadData()
                    self.teamCollectionView.reloadData()
                    self.hud.dismiss()
                    
                }
            }
            
        }
    }
    func getAllTeams(){
        APIClient.instance.getData(url: self.teamDetailsUrl.rawValue, id : legueId ) { (sport: TeamModel?, error) in
            if let error = error {
                print(error)
            }else{
                self.hud.show(in: self.view)
                guard let datasports = sport else { return  }
                if let teams = (datasports.teams){
                    self.teamDetails = teams
                }
                
                DispatchQueue.main.async {
                    self.teamCollectionView.reloadData()
                    self.hud.dismiss()
                    
                }
            }
            
        }
    }
    func getTeamDetails(){
        self.hud.show(in: self.view)
        for  i in (0..<self.eventDetails.count){
            self.dispatchGroup.enter()
            APIClient.instance.getData(url: self.TeamDetailsIDUrl.rawValue ,id : eventDetails[i].idHomeTeam ?? "") { (sport: TeamIDModel?, error) in
                if let error = error {
                    print(error)
                }else{
                    guard let teamDetails = sport else { return  }
                    self.homeTeamDetails .append(teamDetails.teams![0])
                    self.eventCollectionView.reloadData()
                }
                self.dispatchGroup.leave()
            }
        }
        
        for  i in (0..<self.eventDetails.count){
            self.dispatchGroup.enter()
            APIClient.instance.getData(url: self.TeamDetailsIDUrl.rawValue ,id : eventDetails[i].idAwayTeam ?? "") { (sport: TeamIDModel?, error) in
                if let error = error {
                    print(error)
                }else{
                    guard let teamDetails = sport else { return  }
                    self.awayTeamDetails .append(teamDetails.teams![0])
                    self.eventCollectionView.reloadData()
                }
                self.dispatchGroup.leave()
            }
        }
        self.dispatchGroup.notify(queue: .main) {
            self.resultCollectionView.reloadData()
            self.eventCollectionView.reloadData()
            self.hud.dismiss()
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
            if homeTeamDetails.count>indexPath.row{
                if awayTeamDetails.count > indexPath.row{
                    for  i in (0..<self.homeTeamDetails.count){
                        if eventDetails[indexPath.row].idHomeTeam ?? "" == homeTeamDetails[i].idTeam{
                            cell.homeImageView.imageUrl = homeTeamDetails[i].strTeamBadge ?? ""
                        }
                        
                    }
                    for  i in (0..<self.awayTeamDetails.count){
                        if eventDetails[indexPath.row].idAwayTeam ?? "" == awayTeamDetails[i].idTeam{
                            cell.awayImageView.imageUrl = awayTeamDetails[i].strTeamBadge ?? ""
                        }
                        
                    }
                    
                    
                }
                
                cell.homaLabel.text = eventDetails[indexPath.row].strHomeTeam
                cell.awayLabel.text = eventDetails[indexPath.row].strAwayTeam
                cell.dateLabel.text = eventDetails[indexPath.row].dateEvent! + " AT " + eventDetails[indexPath.row].strTime!
                cell.vsLabel.text = "VS"
                
            }
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as! ResultCollectionViewCell
            if homeTeamDetails.count>indexPath.row{
                if awayTeamDetails.count > indexPath.row{
                    for  i in (0..<self.homeTeamDetails.count){
                        if eventDetails[indexPath.row].idHomeTeam ?? "" == homeTeamDetails[i].idTeam{
                            cell.homeImageView.imageUrl = homeTeamDetails[i].strTeamBadge ?? ""
                        }
                        
                    }
                    for  i in (0..<self.awayTeamDetails.count){
                        if eventDetails[indexPath.row].idAwayTeam ?? "" == awayTeamDetails[i].idTeam{
                            cell.awayImageView.imageUrl = awayTeamDetails[i].strTeamBadge ?? ""
                        }
                        
                    }
                    cell.homeLabel.text = eventDetails[indexPath.row].strHomeTeam
                    cell.awayLabel.text = eventDetails[indexPath.row].strAwayTeam
                    cell.dateLabel.text = eventDetails[indexPath.row].dateEvent! + " AT " + eventDetails[indexPath.row].strTime!
                    cell.homeResultLabel.text = eventDetails[indexPath.row].intHomeScore
                    cell.awayResultLabel.text = eventDetails[indexPath.row].intAwayScore
                    cell.vsLabel.text = "VS"
                }}
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
            cell.teamImageView.imageUrl = teamDetails[indexPath.row].strTeamBadge ?? ""
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
                controller.teamId = teamDetails[indexPath.row].idTeam ?? ""
                controller.teamName = teamDetails[indexPath.row].strTeam ?? ""
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
