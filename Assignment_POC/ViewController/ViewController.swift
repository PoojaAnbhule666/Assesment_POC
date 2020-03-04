//
//  ViewController.swift
//  Assignment_POC
//
//  Created by Pooja on 26/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
     
     let data_TableView = UITableView()
    var activityIndicator = UIActivityIndicatorView()
    let factsViewModel = FactsviewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        factsViewModel.delegate = self
        configureTableView()
        pullDownrefresh()
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(notification:)), name: NSNotification.Name("Reachability"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        factsViewModel.updateFacts()
        
    }
    
    func configureTableView() {
        data_TableView.dataSource = self
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
    
    
    // --- observer method for Reachabiltiy of connection
    
    @objc func networkStatusChanged(notification: Notification) {
        if let info = notification.userInfo as? [String: String] {
            let connectionStatus = info["connection"]
            if connectionStatus != "lost" {
                
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController.init(title: "Connection", message: "No network avialble", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { _ in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    // Method is For Pull Down refresh
    
    func pullDownrefresh(){
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.lightGray
        self.data_TableView.insertSubview(refreshControl, at: 0)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("\(#function) pullDownrefresh ")
        factsViewModel.updateFacts()
        refreshControl.endRefreshing()
    }
    
}

//---- extension for UITableViewDataSource

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factsViewModel.rowsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: datacellReuseIdentifier, for: indexPath) as! DataTableViewCell
        
//        if let description = factsViewModel.rowsArray[indexPath.row].description {
            //Here you received string 'category'
            cell.description_Label.text = factsViewModel.rowsArray[indexPath.row].description
//        }
//        if let tittle = factsViewModel.rowsArray[indexPath.row].title {
            //Here you received string 'category'"
            cell.tittle_Label.text = factsViewModel.rowsArray[indexPath.row].title
//        }
        
        DispatchQueue.main.async {
            
            let imgUrl = self.factsViewModel.rowsArray[indexPath.row].imageHref
            //---- image downlaoded through sdWeb Image
                //                cell.product_ImageView.translatesAutoresizingMaskIntoConstraints = false
            cell.product_ImageView.sd_setImage(with: URL(string: imgUrl ?? "" ), placeholderImage: UIImage(named: placeholderImage), options: SDWebImageOptions.refreshCached) { (image, error, type, url) in
                    if error != nil {
                        print("failed to download \(String(describing: url))  error \(String(describing: error))")
                    }
                }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if factsViewModel.rowsArray[indexPath.row].description == nil && factsViewModel.rowsArray[indexPath.row].title == nil &&  factsViewModel.rowsArray[indexPath.row].imageHref == nil {
            return 0
        } else {
            return  UITableView.automaticDimension
        }
    }
    
}

//---extention of viewmodel

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
