//
//  ViewController.swift
//  Assignment_POC
//
//  Created by Pooja on 26/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit


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
        data_TableView.delegate = self
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
                    self.showAlert(titleStr: "Connection", messageStr: "No network avialble")
                }
            }
        }
        
    }
    
    func showAlert(titleStr:String , messageStr:String) {
         let alert = UIAlertController.init(title:titleStr , message:messageStr , preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { _ in
                               alert.dismiss(animated: true, completion: nil)
                           }))
                           
                           self.present(alert, animated: true, completion: nil)
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


