//
//  FactsviewModel.swift
//  Assignment_POC
//
//  Created by Pooja on 28/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit

protocol FactsViewModelProtocol: AnyObject {
    func updateAllFacts(navigationTitle:String)
    func showActivityIndicator()
    func removeActivityIndicator()
    func showAlert(messageStr: String)
}

class FactsviewModel: NSObject {
    
    weak var delegate: FactsViewModelProtocol?
    var rowsArray = [Rows]()
    var factsService = FactsService()
    
    func updateFacts() {
        self.delegate?.showActivityIndicator()
        factsService.apiCall(){ (isSuccesfull, response) in
            
            if isSuccesfull {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(FactsData.self, from: response as! Data)
                    
                    DispatchQueue.main.async {
                        //---- get the Data in rows array
                        self.rowsArray = jsonData.rows ?? []
                        self.delegate?.updateAllFacts(navigationTitle: jsonData.title ?? "")
                    }
                    
                    self.delegate?.removeActivityIndicator()
                } catch {
                    print("error----", error.localizedDescription)
                }
            }else {
                DispatchQueue.main.async {
                    self.delegate?.showAlert(messageStr: response as! String)
                    self.delegate?.removeActivityIndicator()
                }
            }
        }
    }
    
    
}
