//
//  RateChartItem.swift
//  Multi_Stocks
//
//  Created by Darek Barańczuk on 04/10/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation

struct RateChartItem: Identifiable {
    let id = UUID()
    let index: Int
    let value: Double
}
