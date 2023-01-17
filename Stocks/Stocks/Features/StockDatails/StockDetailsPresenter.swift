//
//  StockDetailsPresenter.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import Foundation
import XCAStocksAPI

struct StockChartData: Identifiable {
    let id = UUID()
    let timestamp: Date
    let value: Double
    
    init(timestamp: Date, value: Double) {
        self.timestamp = timestamp
        self.value = value
    }
}

class StockDetailsPresenter {
    
    private let service: IStocksAPI
    private let stock: Quote
    var values: [StockChartData] = []
    
    private weak var view: StockDetailsView?
    weak var presenterCoordinatorDelegate: SearchStockPresenterCoordinatorDelegate?
    
    init(service: IStocksAPI, stock: Quote) {
        self.service = service
        self.stock = stock
    }
    
    func attachView(view: StockDetailsView) {
        self.view = view
        fetchStockChartDetails()
    }
    
    func fetchStockChartDetails() {
        view?.startLoading()
        
        Task {
            do {
                let chartData = try await service.fetchChartData(tickerSymbol: stock.symbol, range: .fiveYear)
                
                values = chartData?.indicators.map({ StockChartData(timestamp: $0.timestamp, value: $0.close) }) ?? []
                values.forEach { val in
                    print(val)
                }
                view?.stopLoading()
            } catch {
                view?.stopLoading()
                print(error.localizedDescription)
            }
        }
    }
}
/*
 Indicator(
 timestamp: 2018-01-15 05:00:00 +0000,
 open: 44.474998474121094,
 high: 45.025001525878906,
 low: 43.76750183105469,
 close: 44.6150016784668)
 */
