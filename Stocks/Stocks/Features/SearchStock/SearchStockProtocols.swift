//
//  SearchStockProtocols.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 16/01/23.
//

import Foundation
import XCAStocksAPI

protocol StockTableCellView: AnyObject {
    func setupView()
    func setStockCodTitle(_ title: String)
    func setStockNameTitle(_ title: String)
    func setStockPercentStatus(_ percent: String)
    func setStockCurrentValue(_ value: String)
    func setStockCod(_ cod: String)
    func setStockName(_ name: String)
    func changeStockPercentStatus()
}

protocol StockView: AnyObject{
    func showAlert(_ message: String)
    func changeStocksListVisibility()
    func reloadData()
    func startLoading()
    func stopLoading()
}

protocol SearchStockPresenterCoordinatorDelegate: AnyObject {
    func didSelectStock(stock: Quote)
}
