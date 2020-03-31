//
//  DataTableViewModel.swift
//  Assignment_POC
//
//  Created by Pooja on 04/03/20.
//  Copyright © 2020 Pooja. All rights reserved.
//

import UIKit

class DataTableViewModel: NSObject {
    
    var rowModel: Rows?
    var titleString: String {
        return rowModel?.title ?? ""
    }
    var desctiptionString: String {
        let descriptionString = rowModel?.description ?? "No Description"
        return descriptionString
    }
    var imageHrefUrl: URL? {
        if let imgHrefUrl = rowModel?.imageHref {
            // To convert string into URL
            if let url = URL.init(string: imgHrefUrl) {
                return url
            }
        }
        return nil
    }
    init(countryInfoData: Rows) {
        self.rowModel = countryInfoData
    }
}
