//
//  ViewController.swift
//  Assignment_POC
//
//  Created by Pooja on 26/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit

class FactViewController: UIViewController {
    let tableViewFacts = UITableView()
    var activityIndicator = UIActivityIndicatorView()
    let factsViewModel = FactsviewModel()
    var refreshCntrl = UIRefreshControl()
    lazy var refreshControl:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
               refreshControl.addTarget(self, action:
                   #selector(handleRefresh(_:)),
                                        for: UIControl.Event.valueChanged)
               refreshControl.tintColor = UIColor.lightGray
        return refreshControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        factsViewModel.delegate = self
        configureTableView()
         self.tableViewFacts.addSubview(refreshControl)
//        pullDownrefresh()
        let notifCentre = NotificationCenter.default
        let notifName = NSNotification.Name("Reachability")
        notifCentre.addObserver(self, selector: #selector(nwStatusChanged(notification:)), name: notifName, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        factsViewModel.updateFacts()
    }
    /** configure tableviewcell for display tableview cell in tableview.*/
    func configureTableView() {
        tableViewFacts.dataSource = self
        tableViewFacts.delegate = self
        tableViewFacts.estimatedRowHeight = 100
        tableViewFacts.allowsSelection = false
        tableViewFacts.rowHeight = UITableView.automaticDimension
        tableViewFacts.register(DataTblCell.self, forCellReuseIdentifier: datacellId)
        view.addSubview(tableViewFacts)
        tableViewFacts.translatesAutoresizingMaskIntoConstraints = false
        tableViewFacts.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableViewFacts.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableViewFacts.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableViewFacts.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    /**observer method for Reachabiltiy of connection for network availability check.*/
    @objc func nwStatusChanged(notification: Notification) {
        if let info = notification.userInfo as? [String: String] {
            let connectionStatus = info["connection"]
            if connectionStatus != "lost" {
            } else {
                DispatchQueue.main.async {
                    
                    self.showConnectionAlert(messageStr: "Unable to connect to the internet.")
                }
            }
        }
    }
    /**show alert when connect is not vailable*/
    func showConnectionAlert(messageStr: String) {
        let alert = UIAlertController.init(title: nil, message: messageStr, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    /**when refreshcontroller is added then pull down to refresh  and call url and update data in tableview.*/
    func pullDownrefresh() {
                self.tableViewFacts.refreshControl = refreshCntrl
        refreshCntrl.addTarget(self, action:
                   #selector(handleRefresh(_:)),
                                        for: UIControl.Event.valueChanged)
               refreshCntrl.tintColor = UIColor.lightGray
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        print("\(#function) pullDownrefresh ")
        factsViewModel.updateFacts()
        refreshControl.endRefreshing()    }
    
    func reloadController()  {
        self.tableViewFacts.reloadData()
    }
}
