//
//  MainViewModel.swift
//  Multi_Stocks
//
//  Created by Darek Barańczuk on 29/09/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

class MainViewModel: ObservableObject {
    
    @Published private(set) var stocks: [Stock]? = nil
    @Published private(set) var errorMessage: String? = nil
    
    let repository = AppleHelper().repo()
    
    init() {
        Task { @MainActor in
            do {
                stocks = try await repository.fetchStocks()
                //throw "error"
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func delete(stock: Stock) {
        Task { @MainActor in
            do {
                try await repository.deleteStock(stockId: stock.id)
                // Reload
                stocks = try await repository.fetchStocks()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func save(localStock: LocalStock) {
        Task { @MainActor in
            do {
                try await repository.addStock(
                    label: localStock.label,
                    queryParam: localStock.queryParam,
                    paramIndex: Int32(localStock.paramIndex)
                )
                // Reload
                stocks = try await repository.fetchStocks()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

extension String: Error {}
