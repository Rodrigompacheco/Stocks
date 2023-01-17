//
//  StockDetailsPresenter.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import Foundation
import XCAStocksAPI

class StockDetailsPresenter {
    
    private let service: IStocksAPI
    private let stock: Quote
    var stockDetails: StockChartData?
    
    private weak var view: StockDetailsView?
    weak var presenterCoordinatorDelegate: SearchStockPresenterCoordinatorDelegate?
    
    init(service: IStocksAPI, stock: Quote) {
        self.service = service
        self.stock = stock
    }
    
    func attachView(view: StockDetailsView) {
        self.view = view
    }
    
    func fetchStockChartDetails(for range: ChartRange, completion: @escaping () -> Void) {
        view?.startLoading()
        
        Task {
            do {
                let chartData = try await service.fetchChartData(tickerSymbol: stock.symbol, range: range)
                let stockChartItems = chartData?.indicators.map({ StockChartItem(timestamp: $0.timestamp, value: $0.close) }) ?? []
                            
                let allValues = stockChartItems.map({ $0.value })
                let growingState = allValues.last ?? 0 > allValues.first ?? 0 ? true : false
                stockDetails = StockChartData(name: stock.symbol,
                                              growingState: growingState,
                                              stockChartItems: stockChartItems)
               
                view?.stopLoading()
                completion()
            } catch {
                view?.stopLoading()
                view?.showAlert(error.localizedDescription)
                completion()
            }
        }
    }
}
