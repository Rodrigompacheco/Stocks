//
//  StockChartData.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import Foundation

struct StockChartData: Identifiable {
    let id = UUID()
    let name: String
    let growingState: Bool
    let stockChartItems: [StockChartItem]
    
    init(name: String, growingState: Bool, stockChartItems: [StockChartItem]) {
        self.name = name
        self.growingState = growingState
        self.stockChartItems = stockChartItems
    }
}
