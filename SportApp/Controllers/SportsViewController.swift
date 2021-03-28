//
//  SportsViewController.swift
//  SportApp
//
//  Created by mac on 3/24/21.
//

import UIKit

class SportsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
  //  let sportsNameUrl = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
    let sportsNameUrl : URLS = .sportsNameUrl
    var sportsArr = [SportDetailsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "SportCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "SportCollectionViewCell")
        self.serviceCall()
    }
    
    func serviceCall(){
        APIClient.instance.getData(url: self.sportsNameUrl.rawValue ) { (sport: SportModel?, error) in
            if let error = error {
                print(error)
            }else{
                guard let datasports = sport else { return  }
                self.sportsArr = (datasports.sports)!
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }
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
        cell.sportImageView.imageUrl = sportsArr[indexPath.row].strSportThumb!
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let legue =  self.storyboard?.instantiateViewController(withIdentifier: "LeagueViewController") as! LeagueViewController
        
        legue.sportName = sportsArr[indexPath.row].strSport
        self.navigationController?.pushViewController(legue, animated: true)
    }
    
}
