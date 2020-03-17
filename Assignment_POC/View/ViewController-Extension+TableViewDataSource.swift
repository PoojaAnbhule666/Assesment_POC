//
//  ViewController-Extension+TableViewDataSource.swift
//  Assignment_POC
//
//  Created by Pooja on 04/03/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factsViewModel.rowsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: datacellId, for: indexPath) as? DataTblCell else {
            return DataTblCell.init(style: .default, reuseIdentifier: datacellId)
        }
//        if cell == nil {
//            cell = DataTableViewCell.init(style: .default, reuseIdentifier: datacellReuseIdentifier)
//        }
        cell.dataViewModel = DataTableViewModel.init(countryInfoData: factsViewModel.rowsArray[indexPath.row])
        cell.layoutIfNeeded()
        cell.layoutSubviews()
        return cell
    }
}
