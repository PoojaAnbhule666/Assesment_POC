//
//  FactsService.swift
//  Assignment_POC
//
//  Created by pooja on 28/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import Foundation


struct FactsService {
    
    //----  Get Api call request
    
    func apiCall(completionBlock : @escaping (_ successful:Bool, _ responseData : Any) -> ()) {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else { return }
        print("url is-->> \(url)")
        
        // set up the session
        let config = URLSessionConfiguration.default
        let sharedSession = URLSession(configuration: config)
        
        let dataTask = sharedSession.dataTask(with: url,
                                              completionHandler: { (data, response, error) in
                                                guard error == nil else {
                                                    print ("error: \(error!)")
                                                    completionBlock(false,error ?? "error")
                                                    return
                                                }
                                                
                                                guard let content = data else {
                                                    completionBlock(false,"error no data")
                                                    return
                                                }
                                                // Convert Data to string using isoLatin2
                                                
                                                let strData = String(data: content, encoding: .isoLatin2)
                                                
                                                guard let decodedData = strData?.data(using: .utf8) else {
                                                    completionBlock(false,"error no data")
                                                    return
                                                }
                                                completionBlock(true,decodedData)
        })
        dataTask.resume()
    }
    
}

