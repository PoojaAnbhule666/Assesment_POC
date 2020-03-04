//
//  ViewController.swift
//  Assignment_POC
//
//  Created by Pooja on 26/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let tableViewFacts = UITableView()
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
        tableViewFacts.dataSource = self
        tableViewFacts.delegate = self
        tableViewFacts.estimatedRowHeight = 100
        tableViewFacts.allowsSelection = false
        tableViewFacts.rowHeight = UITableView.automaticDimension
        tableViewFacts.register(DataTableViewCell.self, forCellReuseIdentifier: datacellReuseIdentifier)
        
        view.addSubview(tableViewFacts)
        tableViewFacts.translatesAutoresizingMaskIntoConstraints = false
        tableViewFacts.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableViewFacts.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableViewFacts.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableViewFacts.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    // --- observer method for Reachabiltiy of connection
    @objc func networkStatusChanged(notification: Notification) {
        if let info = notification.userInfo as? [String: String] {
            let connectionStatus = info["connection"]
            if connectionStatus != "lost" {
            } else {
                DispatchQueue.main.async {
                    self.showConnectionAlert(messageStr: "The Internet connection appears to be offline.")
                }
            }
        }
    }
    
    func showConnectionAlert(messageStr: String) {
        let alert = UIAlertController.init(title: nil, message: messageStr, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    // Method is For Pull Down refresh
    
    func pullDownrefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.lightGray
        self.tableViewFacts.insertSubview(refreshControl, at: 0)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("\(#function) pullDownrefresh ")
        factsViewModel.updateFacts()
        refreshControl.endRefreshing()
    }
    
}


