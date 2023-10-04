//
//  LocalStock.swift
//  Multi_Stocks
//
//  Created by Darek Barańczuk on 30/09/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

struct LocalStock {
    var label: String
    var queryParam: String
    var paramIndex: Int64
    
    static let `default` = LocalStock(label: "", queryParam: "", paramIndex: 0)
}
