//
//  MainView.swift
//  Multi_Stocks
//
//  Created by Darek Barańczuk on 29/09/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    @State private var stock: LocalStock = .default
    @State var showingAddStock = false
    
    var body: some View {
        NavigationView {
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else if let data = viewModel.stocks {
                List {
                    ForEach(data, id: \.id) { item in
                        /*NavigationLink {
                         StockDetailsView(stock: item)
                         } label: {*/
                        StockItemView(stock: item)
                            .padding()
                        //}
                    }
                    .onDelete(perform: { indexSet in
                        let index = indexSet[indexSet.startIndex]
                        let itemToDelete = data[index]
                        viewModel.delete(stock: itemToDelete)
                    })
                    .background(RoundedRectangle(cornerRadius: 12).fill(.white))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                }
                .listStyle(.insetGrouped)
                .toolbar{
                    Button {
                        showingAddStock.toggle()
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
                .navigationTitle("Stocks")
                .sheet(isPresented: $showingAddStock) {
                    NavigationView{
                        TextFormView { validate in
                            AddView(stock: $stock)
                                .navigationTitle("Add stock")
                                .toolbar {
                                    ToolbarItem(placement: .cancellationAction) {
                                        Button("Cancel") {
                                            showingAddStock = false
                                        }
                                    }
                                    ToolbarItem(placement: .confirmationAction) {
                                        Button("Done") {
                                            if validate() {
                                                showingAddStock = false
                                                viewModel.save(localStock: stock)
                                            }
                                        }
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}
