//
//  FactsviewModel.swift
//  Assignment_POC
//
//  Created by Pooja on 28/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit

protocol FactsViewModelProtocol: AnyObject {
    func updateAllFacts(navigationTitle: String)
    func showActivityIndicator()
    func removeActivityIndicator()
    func showAlert(messageStr: String)
}

class FactsviewModel: NSObject {
    weak var delegate: FactsViewModelProtocol?
    var rowsArray = [Rows]()
    let factService: APIServiceProtocol
    
    /**update method for webservice call data updates and tableview updated when service call.*/
    init( apiService: APIServiceProtocol = FactsService()) {
        self.factService = apiService
    }
    func updateFacts() {
        self.delegate?.showActivityIndicator()
        factService.apiCall { (isSuccesfull, response) in
            if isSuccesfull {
                do {
                    let decoder = JSONDecoder()
                    guard let responseData = response as? Data else {
                        return
                    }
                    let jsonData = try decoder.decode(FactsData.self, from: responseData)
                    DispatchQueue.main.async {
                        //---- get the Data in rows array
                        self.rowsArray = jsonData.rows ?? []
                        self.delegate?.updateAllFacts(navigationTitle: jsonData.title ?? "")
                    }
                    self.delegate?.removeActivityIndicator()
                } catch {
                    print("error----", error.localizedDescription)
                }
            } else {
                DispatchQueue.main.async {
                    guard let responseString = response as? String else {
                        return
                    }
                    self.delegate?.showAlert(messageStr: responseString)
                    self.delegate?.removeActivityIndicator()
                }
            }
        }
    }
}
