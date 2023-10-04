import SwiftUI
import shared
import os

struct ContentView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.phrases, id: \.self) { phrase in
            Text(phrase)
        }
    }
}

extension ContentView {
    class ViewModel: ObservableObject {
        
        private let logger = Logger(
            subsystem: Bundle.main.bundleIdentifier!,
            category: String(describing: ViewModel.self)
        )
        
        @Published var phrases: [String] = ["Loading..."]
        let repository = AppleHelper().repo()
        
        init() {
            
            Task { @MainActor in
                let addId = try await self.repository.addStock(label: "Allegro", queryParam: "ale", paramIndex: 0)
                
                self.logger.debug("Added, id: \(addId)")
                let stocks = try await self.repository.fetchStocks()
                
                self.logger.debug("Fetched stocks, count: \(stocks.count)")
                let stock = stocks.first
                
                if let stockItem = stock {
                    self.logger.debug("First stock: \(stockItem.id), \(stockItem.label)")
                    
                    self.logger.debug("Refreshing stock, id: \(stockItem.id)")
                    try await self.repository.refeshStockRates(stockId: stockItem.id)
                    
                    let items = try await self.repository.fetchStockRates(stockId: stockItem.id)
                    let s = items.map { rate in
                        "\(rate.value)"
                    }
                    self.logger.debug("Stock rates: \(s.joined(separator: ", "))")
                }
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
        ContentView(viewModel: ContentView.ViewModel())
	}
}
