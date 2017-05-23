//
//  CJSONDownloader.swift
//  ok
//
//  Created by suryasoft konsultama on 5/23/17.
//  Copyright © 2017 DavidValentino. All rights reserved.
//

import Foundation


class CJSONDownloader{
    
    private let _configure = URLSessionConfiguration.default
    
    private var _session:URLSession? = nil
    
    private var _request:URLRequest? = nil
    
   
    
    init(url: String!){
        _session = URLSession(configuration: _configure)
        _request = URLRequest(url: URL(string: url)!)
    }
    
    func getTask(completionHandler: @escaping ([String:AnyObject]) -> Void ){
    
        guard let _session = _session, let _request = _request else { return}
       
        let task = _session.dataTask(with: _request){ data, response, error in
            
            guard error == nil, let data = data else { return }
            
            do{
                guard let jsonDictionary:[String:AnyObject] = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else {return}
                completionHandler(jsonDictionary)
                
            }catch{
                print(error)
            }
            
            
        }
        task.resume()
        return 
    }
}
