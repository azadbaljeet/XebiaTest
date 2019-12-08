//
//  ModelClass_Parsing.swift
//  MVVMExample
//
//  Created by Sanjeev Kumar Gautam on 9/23/19.
//  Copyright © 2019 teastallstudio. All rights reserved.
//

import UIKit

class ModelClass_Parsing: NSObject {

    
    func methodParsing(completion:@escaping (_ myresult: [[String: Any]]) ->()) {
        
     //   DispatchQueue.global(qos: .background).async {
            ////OWUzAfybDccAxRkGUkyEBoutxdzrXaFH  -----Key
            guard let url = URL(string:"https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json?api-key=OWUzAfybDccAxRkGUkyEBoutxdzrXaFH") else{ return}
       // var req = URLRequest(url: url)
       // let param: [String, Any] = [];
        
        
        
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let dataResponse = data,
                    error == nil else {
                        print(error?.localizedDescription ?? "Response Error")
                        return }
                do{
                    //here dataResponse received from a network request
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                        dataResponse, options: []) as? NSDictionary
                    
                    if let dict = jsonResponse as NSDictionary?{
                        
                        if let strStatus = dict.object(forKey: "status") as? String {
                            if strStatus == "ERROR" {
                                return
                            }
                        }
                        
                        // return
                        let arr = dict.object(forKey: "results")
                        completion(arr as! [[String:Any]])
                    }
                    
                    

                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
        }
    
}
