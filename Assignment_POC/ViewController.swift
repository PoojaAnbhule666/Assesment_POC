//
//  ViewController.swift
//  Assignment_POC
//
//  Created by Pooja on 26/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let datacellReuseIdentifier = "DataTableViewCell"
    fileprivate let data_TableView = UITableView()
    var rowsArray = [Rows]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func configureTableView() {
            data_TableView.dataSource = self
    //        data_TableView.separatorStyle = .singleLine
            data_TableView.estimatedRowHeight = 100
            data_TableView.allowsSelection = false
            data_TableView.rowHeight = UITableView.automaticDimension
            data_TableView.register(DataTableViewCell.self, forCellReuseIdentifier: datacellReuseIdentifier)
            
            view.addSubview(data_TableView)
            data_TableView.translatesAutoresizingMaskIntoConstraints = false
            data_TableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            data_TableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            data_TableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            data_TableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
}

//---- extension for UITableViewDataSource

extension ViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: datacellReuseIdentifier, for: indexPath) as! DataTableViewCell
 
        cell.description_Label.text = self.rowsArray[indexPath.row].description
        cell.tittle_Label.text = self.rowsArray[indexPath.row].title
        DispatchQueue.main.async {
            
            let imgUrl = self.rowsArray[indexPath.row].imageHref
            
//            //---- image downlaoded through sdWeb Image
//            cell.product_ImageView.sd_setImage(with: URL(string: imgUrl ?? ""), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions.refreshCached) { (image, error, type, url) in
//                if error != nil {
//                    print("failed to download \(String(describing: url))  error \(String(describing: error))")
//                }
//            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if rowsArray[indexPath.row].description == nil && rowsArray[indexPath.row].title == nil &&  rowsArray[indexPath.row].imageHref == nil {
            return 0
        } else {
            return  UITableView.automaticDimension
        }
    }
    
}


