//
//  DataModel.swift
//  Xebia_Test_BaljeetSingh
//
//  Created by Baljeet Singh Raghav on 08/12/19.
//  Copyright © 2019 Baljeet Singh Raghav. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    
    var title: String?
    var byline: String?
    var published_date: String?
    var imageURL: String?
    var abstract: String?
    init(dictionary: [String:Any]) {
        
        //https://static01.nyt.com/images/2016/06/19/watching/pulp-fiction-watching-recommendation/pulp-fiction-watching-recommendation-thumbStandard.jpg
        title =  dictionary["title"] as? String
        byline =  dictionary["byline"] as? String
        published_date =  dictionary["published_date"] as? String
        abstract = dictionary["abstract"] as? String
        if let mediaDict = dictionary["media"] as? NSArray {
            
            if let dict = mediaDict.object(at: 0) as? NSDictionary{
                if let mediaArr = dict.object(forKey:"media-metadata") as? NSArray{
                    if let imageUrl = (mediaArr.object(at: 0) as? NSDictionary)?.object(forKey: "url") as? String{
                      imageURL = imageUrl
                    }
                    
                }
                
            }
        }
      //  imageURL =  dictionary["title"] as? String
        
    }
    
    static func dataFromResult(_ result:[[String: Any]]) ->[DataModel]{
        var temp = [DataModel]()
        for i in result{
            temp.append(DataModel(dictionary: i))
        }
        return temp
    }
    
}
