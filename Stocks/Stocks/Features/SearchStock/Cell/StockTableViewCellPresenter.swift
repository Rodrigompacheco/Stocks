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
        view?.setStockNameTitle("Name:")
        view?.setStockPercentStatus("")
        view?.setStockCurrentValue("")
    }
}