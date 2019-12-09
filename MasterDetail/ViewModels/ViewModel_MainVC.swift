//
//  ModelClass.swift
//  MVVMExample
//
//  Created by Sanjeev Kumar Gautam on 9/20/19.
//  Copyright © 2019 teastallstudio. All rights reserved.
//

import UIKit
import Kingfisher

class ViewModel_MainVC: NSObject {
var articalListModel: [DataModel]?
   
@IBOutlet var objModelClassParse: ModelClass_Parsing!
    
    
    func methodParsingCallBack(completion:@escaping ()->()) {
  
        objModelClassParse.methodParsing { (parsArray) in
            
            let array = parsArray as [[String: Any]]
            self.articalListModel = DataModel.dataFromResult(array)
                 completion()
            
        }
    }
    func numberOfRowsInSection(section: Int) -> Int {
        if let arrCount = self.articalListModel{
            return arrCount.count
        }
        return 0
    }
    func didSelectRow(indexpath: IndexPath)-> DataModel {
        var model: DataModel!
        
        if let arrModel = self.articalListModel{
           model = arrModel[indexpath.row]
        }
         return model
      
    }
   func configureCell(cell: CustomTableViewCell, indexpath: IndexPath) {
    
    if let singleModelData = self.articalListModel {
        
         let objModel = singleModelData[indexpath.row]
        if let byTitle = objModel.title{
            cell.lblTitleArticle.text = byTitle
        }
        
        if let byline = objModel.byline{
            cell.lbl_Byline.text = byline
        }
            if let pubdate = objModel.published_date{
                cell.strDatePublish.text = pubdate
            }
        
        if let imgUrl = objModel.imageURL{
            let url = URL(string: imgUrl)
           
            let resource = ImageResource(downloadURL: url!)
            
            KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    cell.imagevProfile.image = value.image
                  
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
        
    }
    
}
    
}
