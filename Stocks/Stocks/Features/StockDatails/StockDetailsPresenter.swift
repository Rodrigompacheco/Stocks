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
//        fetchStockChartDetails()
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
                print(error.localizedDescription)
                completion()
            }
        }
    }
}
/*
 StockChartData(
 id: E22F1F4C-2609-43F1-9033-DE624FC769F1,
 name: "AAPL",
 stockChartItems: [
    Stocks.StockChartItem(
        id: A69AEBD2-5AEC-42FD-902E-F0AFCE668FAE,
        timestamp: 2023-01-03 14:30:00 +0000,
        value: 125.06999969482422),
    Stocks.StockChartItem(
        id: 2D13214F-3B4B-4AE5-957C-866EBF1F41F0,
        timestamp: 2023-01-04 14:30:00 +0000,
        value: 126.36000061035156),
    Stocks.StockChartItem(
        id: 226B918D-DEBE-4744-B69C-38EA23499F95,
        timestamp: 2023-01-05 14:30:00 +0000,
        value: 125.0199966430664),
    Stocks.StockChartItem(id: 6877E1C2-3ADA-4580-8F1C-44D3613E2E58, timestamp: 2023-01-06 14:30:00 +0000, value: 129.6199951171875), Stocks.StockChartItem(id: 9179D7F8-E474-4C34-ABC5-49918584EA55, timestamp: 2023-01-09 14:30:00 +0000, value: 130.14999389648438), Stocks.StockChartItem(id: 2CEAAB28-A995-46B0-B34E-121C24D90C95, timestamp: 2023-01-10 14:30:00 +0000, value: 130.72999572753906), Stocks.StockChartItem(id: 5ADA8FA4-2CD0-48D0-9D71-A1DD4011F446, timestamp: 2023-01-11 14:30:00 +0000, value: 133.49000549316406), Stocks.StockChartItem(id: C3BFD622-8455-4391-9E39-7B3D0CDE9577, timestamp: 2023-01-12 14:30:00 +0000, value: 133.41000366210938), Stocks.StockChartItem(id: 3B078F00-B70A-424F-9A01-CF2A48B1F41D, timestamp: 2023-01-13 14:30:00 +0000, value: 134.75999450683594), Stocks.StockChartItem(id: C2F90A8D-47B6-407D-9896-19B2C60D7F6A, timestamp: 2023-01-17 15:39:07 +0000, value: 136.0207977294922)])
 
 
 Indicator(
 timestamp: 2018-01-15 05:00:00 +0000,
 open: 44.474998474121094,
 high: 45.025001525878906,
 low: 43.76750183105469,
 close: 44.6150016784668)
 */
