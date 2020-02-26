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
        
       configureTableView()
//       pullDownrefresh()
       callApi()
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
    
    // ---- Rest Api Call
    
    func callApi()  {
        let url =  "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
//        showActivityIndicatorOnView(view: self.view)
        apiCall(serviceURL: url) { (isSuccesfull, response) in
            
            if isSuccesfull {
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Json_Data.self, from: response as! Data)
                    
                    DispatchQueue.main.async {
                        self.navigationItem.title = jsonData.title ?? ""
                        //---- get the Data in rows array
                        self.rowsArray = jsonData.rows ?? []
                        self.data_TableView.reloadData()
                    }
                    
//                    self.removeActivityIndicator()
                } catch {
                    print("error----",error.localizedDescription)
                }
            }
        }
    }
    
    //----  Get Api call request

    func apiCall(serviceURL : String, completionBlock : @escaping (_ successful:Bool, _ responseData : Any) -> ()) {
        guard let url = URL(string: "\(serviceURL)") else { return }
        print("url is-->> \(url)")
        
        // set up the session
        let config = URLSessionConfiguration.default
        let sharedSession = URLSession(configuration: config)
        
        let dataTask = sharedSession.dataTask(with: url,
                                              completionHandler: { (data, response, error) in
                                                guard error == nil else {
                                                    print ("error: \(error!)")
                                                    completionBlock(false,error ?? "error")
                                                    return
                                                }
                                                
                                                guard let content = data else {
                                                    completionBlock(false,"error no data")
                                                    return
                                                }
                                                // Convert Data to string using isoLatin2
                                                
                                                let strData = String(data: content, encoding: .isoLatin2)
                                                
                                                guard let decodedData = strData?.data(using: .utf8) else {
                                                    completionBlock(false,"error no data")
                                                    return
                                                }
                                                completionBlock(true,decodedData)
        })
        dataTask.resume()
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


