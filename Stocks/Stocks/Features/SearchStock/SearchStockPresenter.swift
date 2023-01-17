//
//  SearchStockPresenter.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 16/01/23.
//

import Foundation
import XCAStocksAPI

class SearchStockPresenter {
    
    private let service: IStocksAPI
    private var stocks: [Quote] = []
    private var search = ""
    let serchStockPlaceHolder = "Search your Stock here!"
    let searchButtonTitle = "SEARCH"
    var isStocksListHidden = true
    
    private weak var view: StockView?
    
    init(service: IStocksAPI) {
        self.service = service
    }
    
    func attachView(view: StockView) {
        self.view = view
    }
    
    private func fetchStock(byTitle title: String) {
//        service.fetchStock(title)
    }
    
    func searchStockButtonPressed(withText text: String) {
        search = text
        isStocksListHidden = false
        view?.changeStocksListVisibility()
        view?.startLoading()
        
        Task {
            do {
                let symbols = try await service.searchTickers(query: search, isEquityTypeOnly: false)
                    .map({ $0.symbol })
                    .joined(separator:",")
                
                do {
                    stocks = try await service.fetchQuotes(symbols: symbols)

                    view?.stopLoading()
                    view?.reloadData()
                } catch {
                    view?.stopLoading()
                    print(error.localizedDescription)
                }
            } catch {
                view?.stopLoading()
                print(error.localizedDescription)
            }
        }
    }
    
    func setSearch(stock: String) {
        search = stock
    }
    
    func getTotalStocks() -> Int {
        return stocks.count
    }
    
    func getStock(at index: Int) -> Quote? {
        guard index < stocks.count else { return nil }
        
        return stocks[index]
    }
}
