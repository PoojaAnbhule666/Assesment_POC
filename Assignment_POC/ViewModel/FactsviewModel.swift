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
    func reloadcontroller()
}

class FactsviewModel: NSObject {
    
    weak var delegate: FactsViewModelProtocol?
    var rowsArray = [Rows]()
    let apiService: APIServiceProtocol
    private let network = NetworkManager.sharedInstance
    /**update method for webservice call data updates and tableview updated when service call.*/
    init( apiService: APIServiceProtocol = FactsService()) {
        self.apiService = apiService
    }
    func updateFacts() {
        network.reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
             self.delegate?.removeActivityIndicator()
            }
                          self.delegate?.showAlert(messageStr: "Unable to connect to the internet.")
                   return
                      }
        DispatchQueue.main.async {
              self.delegate?.showActivityIndicator()
              }
        apiService.apiCall { (isSuccesfull, response) in
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
                        self.delegate?.removeActivityIndicator()
                    }
                    
                } catch {
                    print("error----", error.localizedDescription)
                }
            }
            else {
                DispatchQueue.main.async {
                    guard response is String else {
                        return
                    }
                    self.delegate?.reloadcontroller()
                    self.delegate?.showAlert(messageStr: "server error occured")
                    self.delegate?.removeActivityIndicator()

                }
            }
        }
    }
}
