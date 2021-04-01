//
//  SportsViewController.swift
//  SportApp
//
//  Created by mac on 3/24/21.
//

import UIKit
import JGProgressHUD
class SportsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let sportsNameUrl : URLS = .sportsNameUrl
    var sportsArr = [SportDetailsModel]()
    let hud = JGProgressHUD()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sports"
        self.collectionView.register(UINib(nibName: "SportCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SportCollectionViewCell")
//        self.serviceCall()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.serviceCall()
    }
    func serviceCall(){
        guard APIClient.instance.checkInternet() else {
            self.askForQuit { (canQuit) in
                 if canQuit {
                     self.quit()
                    
                 }
            }
            return
        }
        APIClient.instance.getData(url: self.sportsNameUrl.rawValue ) { (sport: SportModel?, error) in
            if let error = error {
                print(error)
            }else{
                self.hud.show(in: self.view)
                guard let datasports = sport else { return  }
                self.sportsArr = (datasports.sports)!
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            self.hud.dismiss()
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
    
    
}


extension SportsViewController : UICollectionViewDelegate , UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: ((collectionView.frame.width/2) - 2.5), height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCollectionViewCell", for: indexPath) as! SportCollectionViewCell
        cell.nameLabel.text = sportsArr[indexPath.row].strSport
        cell.sportImageView.imageUrl = sportsArr[indexPath.row].strSportThumb ?? ""
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let legue =  self.storyboard?.instantiateViewController(withIdentifier: "LeagueViewController") as! LeagueViewController
        guard APIClient.instance.checkInternet() else {
            self.askForQuit { (canQuit) in
                if canQuit {
                    self.quit()
                }
            }
            return
        }
        legue.sportName = sportsArr[indexPath.row].strSport
        self.navigationController?.pushViewController(legue, animated: true)
    }
    
}
