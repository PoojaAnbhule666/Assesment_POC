//
//  FactsService.swift
//  Assignment_POC
//
//  Created by pooja on 28/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    // swiftlint:disable void_return
    func apiCall(completionBlock : @escaping (_ successful: Bool, _ responseData: Any) -> ())
}

class FactsService: APIServiceProtocol {
    /**get api call request*/
    func apiCall(completionBlock : @escaping (_ successful: Bool, _ responseData: Any) -> ()) {
        guard let url = URL(string: webServiceUrl) else { return }
        print("url is-->> \(url)")
        /**setup session for webservice call*/
        let config = URLSessionConfiguration.default
        let sharedSession = URLSession(configuration: config)
        // swiftlint:disable unused_closure_parameter
        let dataTask = sharedSession.dataTask(with: url,
                                              completionHandler: { (data, response, error) in
                                                guard error == nil else {
                                                    print("error: \(error!)")
                                                    completionBlock(false, error?.localizedDescription ?? "error")
                                                    return
                                                }
                                                guard let content = data else {
                                                    completionBlock(false, "error no data")
                                                    return
                                                }
                                                // Convert Data to string using isoLatin
                                                let strData = String(data: content, encoding: .isoLatin2)
                                                guard let decodedData = strData?.data(using: .utf8) else {
                                                    completionBlock(false, "error no data")
                                                    return
                                                }
                                                completionBlock(true, decodedData)
        })
        dataTask.resume()
    }
}
