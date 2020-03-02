//
//  FactsviewModel.swift
//  Assignment_POC
//
//  Created by Pooja on 28/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit

protocol FactsViewModelProtocol {
    func updateAllFacts(navigationTitle:String)
    func showActivityIndicator()
    func removeActivityIndicator()
}

class FactsviewModel: NSObject {

    var delegate: FactsViewModelProtocol?
    var rowsArray = [Rows]()
    var factsService = FactsService()
    
    func updateFacts() {
        self.delegate?.showActivityIndicator()
        factsService.apiCall() { (isSuccesfull, response) in
            
            if isSuccesfull {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Json_Data.self, from: response as! Data)
                    
                    DispatchQueue.main.async {
//                        self.navigationItem.title = jsonData.title ?? ""
                        //---- get the Data in rows array
                        self.rowsArray = jsonData.rows ?? []
                        self.delegate?.updateAllFacts(navigationTitle: jsonData.title ?? "")
                    }
                    
                    self.delegate?.removeActivityIndicator()
                } catch {
                    print("error----",error.localizedDescription)
                }
            }
        }
    }
    
    
}
