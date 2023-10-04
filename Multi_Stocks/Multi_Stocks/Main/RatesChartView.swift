//
//  RatesChartView.swift
//  Multi_Stocks
//
//  Created by Darek Barańczuk on 04/10/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import Charts
import shared

struct RatesChartView: View {
    var rates: [Double]
    
    var body: some View {
        VStack {
            var min = rates.min() ?? 1
            var max = rates.max() ?? 2
            var index = 0
            let data: [RateChartItem] = rates.map { item in
                index += 1
                return RateChartItem(index: index, value: item)
            }
            
            Chart {
                ForEach(data, id: \.id) { shape in
                    LineMark(
                        x: .value("Index", shape.index),
                        y: .value("Rate", shape.value)
                    )
                }
            }
            .chartYScale(domain: (min - 0.02)...(max + 0.02))
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { value in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.month(.defaultDigits))
                }
            }
            .frame(height: 200)
        }
    }
}

#Preview {
    RatesChartView(rates: [4.231, 4.24, 4.19, 4.199, 4.21, 4.20, 4.24, 4.25, 4.22, 4.22])
}
