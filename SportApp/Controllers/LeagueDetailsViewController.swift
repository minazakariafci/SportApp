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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "EventCollectionViewCell")
        self.resultCollectionView.register(UINib(nibName: "ResultCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ResultCollectionViewCell")
        self.teamCollectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TeamCollectionViewCell")
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
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
            return 10
        case 1:
            return 7
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
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCollectionViewCell", for: indexPath) as! ResultCollectionViewCell
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
