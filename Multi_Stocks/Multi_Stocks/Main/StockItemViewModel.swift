//
//  StockItemViewModel.swift
//  Multi_Stocks
//
//  Created by Darek Barańczuk on 02/10/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

class StockItemViewModel: ObservableObject {
    
    @Published private(set) var latestRate: Rate? = nil
    @Published private(set) var rates: [Rate]? = nil
    @Published private(set) var noRates: Bool = false
    @Published private(set) var errorMessage: String? = nil
    
    let repository = AppleHelper().repo()
    
    func loadLatestRate(stockId: Int64) {
        Task { @MainActor in
            do {
                try await Task.sleep(nanoseconds: 200_000_000)
                try await repository.refeshStockRates(stockId: stockId)
                latestRate = try await repository.fetchLatestStockRate(stockId: stockId)
                rates = try await repository.fetchStockRates(stockId: stockId)
                if latestRate == nil {
                    noRates = true
                }
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
