//
//  ModelClass.swift
//  MVVMExample
//
//  Created by Sanjeev Kumar Gautam on 9/20/19.
//  Copyright © 2019 teastallstudio. All rights reserved.
//
protocol DidSelectRowProtocal: class {
    func passingModelObject(indexpath: IndexPath, model :DataModel)
}
import UIKit
import Kingfisher
/*
 
 var carListModel: [CarListModel]?
 
 */
class ViewModel_MainVC: NSObject {
var articalListModel: [DataModel]?
    weak var delegate: DidSelectRowProtocal?
    
@IBOutlet var objModelClassParse: ModelClass_Parsing!
    
    
    func methodParsingCallBack(completion:@escaping ()->()) {
  
        objModelClassParse.methodParsing { (moves) in
            
            let array = moves as [[String: Any]]
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
    func didSelectRow(indexpath: IndexPath) {
        
        if let arrModel = self.articalListModel{
             let model = arrModel[indexpath.row]
              delegate?.passingModelObject(indexpath: indexpath, model: model)
            
        }
      
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
        
    
    
    func downloadImage(`with` urlString : String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                print("Image: \(value.image). Got from: \(value.cacheType)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    
    func mergeTextAndImge(strByLine:String, strDate: String) -> NSMutableAttributedString {
        
        let fullString = NSMutableAttributedString(string: strByLine)
        
        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: "calander.png")
        
        // wrap the attachment in its own attributed string so we can append it
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        // add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: strDate))
        
       return fullString
        
    }
    

    
}
