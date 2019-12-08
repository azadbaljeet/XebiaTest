//
//  DetailViewController.swift
//  MasterDetail
//
//  Created by Baljeet Singh Raghav on 08/12/19.
//  Copyright © 2019 Baljeet Singh Raghav. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var modelSelected:DataModel?

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.abstract
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: DataModel? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

