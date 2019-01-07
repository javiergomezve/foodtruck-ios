//
//  MainVC.swift
//  FoodTruck
//
//  Created by Javier Gomez on 1/5/19.
//  Copyright © 2019 Javier Gomez. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataService = DataService.instance
    var authService = AuthService.instance
    
    var loginVC: LogInVC?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        dataService.delegate = self
        dataService.getAllFoodTrucks()
    }
    
    @IBAction func addButonTapped(_ sender: Any) {
        if AuthService.instance.isAuthenticated == true {
            performSegue(withIdentifier: "showAddTruckVC", sender: self)
        } else {
            showLogInVC()
        }
    }
    
    func showLogInVC() {
        loginVC = LogInVC()
        loginVC?.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(loginVC!, animated: true, completion: nil)
    }
}

extension MainVC: DataServiceDelegate {
    func trucksLoaded() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    func reviewsLoaded() {}
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.foodTrucks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "foodTruckCell", for: indexPath) as? FoodTruckCell {
            cell.configureCell(truck: dataService.foodTrucks[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
