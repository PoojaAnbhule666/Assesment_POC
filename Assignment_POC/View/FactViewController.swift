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
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        factsViewModel.delegate = self
        configureTableView()
        pullDownrefresh()
        factsViewModel.updateFacts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    /**show alert when connect is not vailable*/
    func showConnectionAlert(messageStr: String) {
        let alert = UIAlertController.init(title: nil, message: messageStr, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { _ in            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    /**when refreshcontroller is added then pull down to refresh  and call url and update data in tableview.*/
    func pullDownrefresh() {
        // set up the refresh control
        self.refreshControl.addTarget(self, action: #selector(refresh(sender:)) , for: UIControl.Event.valueChanged)
        self.tableViewFacts.addSubview(refreshControl)
    }
    @objc func refresh(sender:AnyObject) {
        refreshControl.endRefreshing()
        factsViewModel.updateFacts()
    }
    
}
