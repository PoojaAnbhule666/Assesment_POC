//
//  ViewController-Extension+FactsViewModelProtocol.swift
//  Assignment_POC
//
//  Created by Pooja on 04/03/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import Foundation
import UIKit
extension ViewController : FactsViewModelProtocol {
    
    func updateAllFacts(navigationTitle: String) {
        self.navigationItem.title = navigationTitle
        self.tableViewFacts.reloadData()
    }
    
    func showActivityIndicator() {
        self.activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            
        }
    }
    
    func showAlert(messageStr: String) {
        self.showConnectionAlert(messageStr: messageStr)
        
    }
}
