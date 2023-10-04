//
//  StockDetailsViewModel.swift
//  Multi_Stocks
//
//  Created by Darek Barańczuk on 03/10/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

class StockDetailsViewModel: ObservableObject {
    
    @Published private(set) var rates: [Rate]? = nil
    @Published private(set) var errorMessage: String? = nil
    
    let repository = AppleHelper().repo()
    
    func refreshRates(stockId: Int64) {
        Task { @MainActor in
            do {
                try await repository.refeshStockRates(stockId: stockId)
                rates = try await repository.fetchStockRates(stockId: stockId)
            } catch {
                print(error.localizedDescription)
                errorMessage = error.localizedDescription
            }
        }
    }
}
