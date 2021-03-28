//
//  FavouriteLeagueViewController.swift
//  SportApp
//
//  Created by mac on 3/28/21.
//

import UIKit
import CoreData
class FavouriteLeagueViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var leguesCoreData : [LegueCoreData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "LegueTableViewCell", bundle: .main), forCellReuseIdentifier: "LegueTableViewCell")
    }
    func getCoreDate() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieCoreDate")
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let mangedContext = appDelegate.persistentContainer.viewContext
            try  leguesCoreData = (mangedContext.fetch(fetchRequest) as? [String])!
            tableView.reloadData()
        } catch let error as NSError {
            print(error)
        }
       
    }

}

extension FavouriteLeagueViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
