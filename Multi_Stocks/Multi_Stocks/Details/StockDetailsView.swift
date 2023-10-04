//
//  StockDetailsView.swift
//  Multi_Stocks
//
//  Created by Darek Barańczuk on 03/10/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct StockDetailsView: View {
    @StateObject var viewModel: StockDetailsViewModel = StockDetailsViewModel()
    
    var stock: Stock
    
    var body: some View {
        VStack {
            if let rates = viewModel.rates {
                List {
                    ForEach(rates, id: \.self) { rate in
                        Text("\(rate.value)")
                    }
                }
            }
        }.onAppear {
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != "1" {
                viewModel.refreshRates(stockId: stock.id)
            }
        }
        .navigationTitle(stock.label)
    }
}

#Preview {
    StockDetailsView(stock: Stock(id: 1, label: "Label", queryParam: "param", paramIndex: 0))
}
