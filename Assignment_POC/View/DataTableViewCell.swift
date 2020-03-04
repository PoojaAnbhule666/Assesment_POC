//
//  DataTableViewCell.swift
//  Assignment_POC
//
//  Created by Pooja on 26/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit
import SDWebImage

class DataTableViewCell: UITableViewCell {
    
    let lblTitle = UILabel()
    let lblDescription = UILabel()
    let imgProduct = UIImageView()
    
    // MARK: Initalizers
    var dataViewModel: DataTableViewModel? {
        didSet {
            lblTitle.text = dataViewModel?.titleString
            lblDescription.text = dataViewModel?.desctiptionString
            imgProduct.sd_setImage(with: dataViewModel?.imageHrefUrl, placeholderImage: UIImage(named: placeholderImage), options: SDWebImageOptions.refreshCached) { (image, error, type, url) in
                if error != nil {
                    print("failed to download \(String(describing: url))  error \(String(describing: error))")
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // configure imageView
        contentView.addSubview(imgProduct)
        imgProduct.contentMode = .scaleAspectFit
        imgProduct.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imgProduct.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imgProduct.translatesAutoresizingMaskIntoConstraints = false
        imgProduct.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 10).isActive = true
        imgProduct.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        
        // configure titleLabel
        contentView.addSubview(lblTitle)
        lblTitle .translatesAutoresizingMaskIntoConstraints = false
        
        lblTitle .leadingAnchor.constraint(equalTo: imgProduct.trailingAnchor, constant: 10).isActive = true
        lblTitle .topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 20).isActive = true
        lblTitle .trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        lblTitle .numberOfLines = 0
        lblTitle .font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        
        // configure authorLabel
        contentView.addSubview(lblDescription)
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        lblDescription.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor,constant: 10).isActive = true
        lblDescription.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        lblDescription.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        lblDescription.topAnchor.constraint(equalTo: imgProduct.bottomAnchor, constant: 15).isActive = true
        lblDescription.numberOfLines = 0
        lblDescription.font = UIFont(name: "Avenir-Book", size: 12)
        lblDescription.textColor = UIColor.gray
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
