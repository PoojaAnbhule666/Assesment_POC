//
//  ViewController-Extension+TableViewDelegate.swift
//  Assignment_POC
//
//  Created by Pooja on 04/03/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit

extension ViewController : UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if factsViewModel.rowsArray[indexPath.row].description == nil && factsViewModel.rowsArray[indexPath.row].title == nil &&  factsViewModel.rowsArray[indexPath.row].imageHref == nil {
            return 0
        } else {
            return  UITableView.automaticDimension
        }
    }
    
}
