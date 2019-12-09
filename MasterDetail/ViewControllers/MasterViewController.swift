//
//  MasterViewController.swift
//  MasterDetail
//
//  Created by Baljeet Singh Raghav on 08/12/19.
//  Copyright © 2019 Baljeet Singh Raghav. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MasterViewController: UITableViewController, NVActivityIndicatorViewable {
    @IBOutlet var objViewModel: ViewModel_MainVC!
    var modelSelected:DataModel?
    var detailViewController: DetailViewController? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        updateUI()
        
   
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
            
            startAnimating()
            objViewModel.methodParsingCallBack {
                DispatchQueue.main.async {
                    self.stopAnimating()
                    self.tableView.reloadData()
                }
                
            }
            
            
        }
        
        
    }
    func updateUI() {
        //LEFT
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "side"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(clickSideMenuLeft(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        
        //Right
        let button2: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button2.setImage(UIImage(named: "3-dot-icon"), for: UIControl.State.normal)
        button2.addTarget(self, action: #selector(clickSideMenuRight(_:)), for: .touchUpInside)
        button2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton2 = UIBarButtonItem(customView: button2)
        self.navigationItem.rightBarButtonItem = barButton2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    @objc
    func clickSideMenuLeft(_ sender: Any) {
      
        //Code for left menu
    }
    
    @objc
    func clickSideMenuRight(_ sender: Any) {
      //Code for right menu
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.detailItem = modelSelected
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
   
    // MARK: - Table View Delegates and Data Source Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let dataModel =  objViewModel.didSelectRow(indexpath: indexPath)
        modelSelected = dataModel
        performSegue(withIdentifier: "showDetails", sender: nil)
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objViewModel.numberOfRowsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomTableViewCell
        
        if cell == nil {
            
            cell = CustomTableViewCell.init(style: .default, reuseIdentifier: "CustomCell")
        }
        objViewModel.configureCell(cell: cell!, indexpath: indexPath)
        
        return cell!
        
    }
    
    
}

