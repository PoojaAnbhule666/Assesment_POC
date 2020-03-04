//
//  ViewController-Extension+TableViewDataSource.swift
//  Assignment_POC
//
//  Created by Pooja on 04/03/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit
import SDWebImage

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factsViewModel.rowsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: datacellReuseIdentifier, for: indexPath) as! DataTableViewCell
        
        cell.lblDescription.text = factsViewModel.rowsArray[indexPath.row].description
        cell.lblTitle.text = factsViewModel.rowsArray[indexPath.row].title
        DispatchQueue.main.async {
            
            let imgUrl = self.factsViewModel.rowsArray[indexPath.row].imageHref
            //---- image downlaoded through sdWeb Image
            
            cell.imgProduct.sd_setImage(with: URL(string: imgUrl ?? "" ), placeholderImage: UIImage(named: placeholderImage), options: SDWebImageOptions.refreshCached) { (image, error, type, url) in
                if error != nil {
                    print("failed to download \(String(describing: url))  error \(String(describing: error))")
                }
            }
            
        }
        return cell
    }
    
}
