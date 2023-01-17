//
//  StockTableViewCellPresenter.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 16/01/23.
//

import Foundation
import XCAStocksAPI

class StockTableViewCellPresenter {
    
    private weak var view: StockTableCellView?
    private let stock: Quote
    var growingStatus: Bool = false
    
    init(stock: Quote) {
        self.stock = stock
    }
    
    func attachView(_ view: StockTableCellView) {
        self.view = view
        setupView()
    }

    func setupView() {
        view?.setupView()
        view?.setStockCodTitle("Id:")
        view?.setStockNameTitle(stock.displayName ?? "-")
        view?.setStockCod(stock.symbol)
        
        let marketPercent = round(1000 * (stock.regularMarketChangePercent ?? 0)) / 1000
        view?.setStockPercentStatus(String("\(marketPercent)%"))
        
        let currency = stock.currency ?? ""
        let makertPrice = round(100 * (stock.regularMarketPrice ?? 0)) / 100
        view?.setStockCurrentValue(String("\(makertPrice) \(currency)"))
        
        if stock.regularMarketChange ?? 0 > 0 {
            growingStatus = true
        }
        view?.changeStockPercentStatus()
    }
}
