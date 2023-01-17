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
    
    private weak var view: StockView?
    weak var presenterCoordinatorDelegate: SearchStockPresenterCoordinatorDelegate?
    
    init(service: IStocksAPI, stock: Quote) {
        self.service = service
        self.stock = stock
    }
    
    func attachView(view: StockView) {
        self.view = view
    }
    
    private func fetchStock(byTitle title: String) {
        //        service.fetchStock(title)
    }
}
