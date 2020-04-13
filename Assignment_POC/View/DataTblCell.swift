//
//  DataTableViewCell.swift
//  Assignment_POC
//
//  Created by Pooja on 26/02/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit
import SDWebImage

class DataTblCell: UITableViewCell {
    let imgProduct: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.heightAnchor.constraint(equalToConstant: 60).isActive = true
        img.widthAnchor.constraint(equalToConstant: 60).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl .translatesAutoresizingMaskIntoConstraints = false
        lbl.heightAnchor.constraint(equalToConstant: 60).isActive = true
        lbl .numberOfLines = 0
        lbl .font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        lbl.textColor = UIColor.darkGray
        return lbl
    }()
    let lblDescription: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Avenir-Book", size: 12)
        lbl.textColor = UIColor.gray
        return lbl
    }()
    // MARK: Initalizers
    var dataViewModel: DataTableViewModel? {
        didSet {
            lblTitle.text = dataViewModel?.titleString
            lblDescription.text = dataViewModel?.desctiptionString
            let imgStr = dataViewModel?.imageHrefUrl
            let placeImage = UIImage(named: placeholderImage)
            imgProduct.sd_setImage(with: imgStr, placeholderImage: placeImage, options: SDWebImageOptions.refreshCached) { (image, error, type, url) in
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
        imgProduct.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 10).isActive = true
        imgProduct.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        // configure titleLabel
        contentView.addSubview(lblTitle)
        lblTitle .leadingAnchor.constraint(equalTo: imgProduct.trailingAnchor, constant: 10).isActive = true
        lblTitle.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        // configure authorLabel
        contentView.addSubview(lblDescription)
        lblDescription.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 10).isActive = true
        lblDescription.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        lblDescription.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 12).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
