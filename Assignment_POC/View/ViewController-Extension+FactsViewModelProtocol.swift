//
//  ViewController-Extension+FactsViewModelProtocol.swift
//  Assignment_POC
//
//  Created by test on 04/03/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import Foundation

extension ViewController : FactsViewModelProtocol {
    func updateAllFacts(navigationTitle: String) {
        self.navigationItem.title = navigationTitle
        self.data_TableView.reloadData()
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
    
}
