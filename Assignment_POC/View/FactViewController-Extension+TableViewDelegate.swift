//
//  ViewController-Extension+TableViewDelegate.swift
//  Assignment_POC
//
//  Created by Pooja on 04/03/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit

extension FactViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let descriptionStr = factsViewModel.rowsArray[indexPath.row].description
        let titleStr = factsViewModel.rowsArray[indexPath.row].title
        let imgRef = factsViewModel.rowsArray[indexPath.row].imageHref
        if descriptionStr == nil && titleStr == nil &&  imgRef == nil {
            return 0
        } else {
            return  UITableView.automaticDimension
        }
    }
}
