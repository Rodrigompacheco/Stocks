//
//  StockChartData.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import Foundation

struct StockChartItem: Identifiable {
    let id = UUID()
    var timestamp: Date
    var value: Double
    
    init(timestamp: Date, value: Double) {
        self.timestamp = timestamp
        self.value = value
    }
}
