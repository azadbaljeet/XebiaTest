//
//  MasterViewController.swift
//  MasterDetail
//
//  Created by Baljeet Singh Raghav on 08/12/19.
//  Copyright © 2019 Baljeet Singh Raghav. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MasterViewController: UITableViewController, NVActivityIndicatorViewable, DidSelectRowProtocal {
    @IBOutlet var objViewModel: ViewModel_MainVC!
    var modelSelected:DataModel?
    var detailViewController: DetailViewController? = nil
   


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     //   navigationItem.leftBarButtonItem = editButtonItem

//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
        
      //  self.tableView.register(UINib.init(nibName: "", bundle: nil), forCellReuseIdentifier: "customCell")
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
            
            startAnimating()
            objViewModel.delegate = self
            objViewModel.methodParsingCallBack {
                DispatchQueue.main.async {
                    self.stopAnimating()
                     self.tableView.reloadData()
                }
               
            }
                
            
            }
            
            
        }
    

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

//    @objc
//    func insertNewObject(_ sender: Any) {
//        objects.insert(NSDate(), at: 0)
//        let indexPath = IndexPath(row: 0, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
//    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
         //   if tableView.indexPathForSelectedRow != nil {
               // let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = modelSelected
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
          //  }
        }
    }

    func passingModelObject(indexpath: IndexPath, model :DataModel){
     
        modelSelected = model
        performSegue(withIdentifier: "showDetails", sender: nil)
      
    }
    
    // MARK: - Table View

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        objViewModel.didSelectRow(indexpath: indexPath)
        
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

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

  


}

