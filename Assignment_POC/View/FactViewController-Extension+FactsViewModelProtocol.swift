//
//  ViewController-Extension+FactsViewModelProtocol.swift
//  Assignment_POC
//
//  Created by Pooja on 04/03/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import Foundation
import UIKit

extension FactViewController: FactsViewModelProtocol {
    /**when webservice call data is updated then update tableview using this method*/
    func updateAllFacts(navigationTitle: String) {
        self.navigationItem.title = navigationTitle
        self.tableViewFacts.reloadData()
    }
    /**show activity indicator when webservice is call.*/
    func showActivityIndicator() {
        self.activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    /**after  webservice response getting then remove activityindicator.*/
    func removeActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
    func showAlert(messageStr: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showConnectionAlert(messageStr: messageStr)
        }
    }
    func reloadcontroller() {
        self.tableViewFacts.reloadData()
        if refreshControl.isRefreshing
        {
            self.refreshControl.endRefreshing()
        }
    }
}
