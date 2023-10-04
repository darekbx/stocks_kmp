//
//  StockItemView.swift
//  Multi_Stocks
//
//  Created by Darek Barańczuk on 02/10/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct StockItemView: View {
    @StateObject var viewModel: StockItemViewModel = StockItemViewModel()
    var stock: Stock
    
    var body: some View {
        HStack {
            if let latestRate = viewModel.latestRate {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(stock.label)")
                            .padding(.trailing, 4)
                        Text("\(latestRate.value, specifier: "%.2f")zł")
                            .fontWeight(.bold)
                    }
                    if let rates = viewModel.rates {
                        RatesChartView(rates: rates.map { $0.value })
                    }
                }
            } else if viewModel.noRates {
                Text("n/a")
                    .fontWeight(.bold)
            } else {
                ProgressView()
            }
        }.onAppear {
            viewModel.loadLatestRate(stockId: stock.id)
        }
    }
}

#Preview {
    StockItemView(
        viewModel: StockItemViewModel(),
        stock: Stock(id: 1, label: "Allegro", queryParam: "ale", paramIndex: 0)
    )
}
