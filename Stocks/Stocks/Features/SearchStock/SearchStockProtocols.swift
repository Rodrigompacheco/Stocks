//
//  SearchStockProtocols.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 16/01/23.
//

import Foundation

protocol StockTableCellView: AnyObject {
    func setupView()
    func setStockCodTitle(_ title: String)
    func setStockNameTitle(_ title: String)
    func setStockPercentStatus(_ percent: String)
    func setStockCurrentValue(_ value: String)
}

protocol StockTableItemView: AnyObject {
    func setupView()
    func setStockTitle(_ title: String)
    func setStockFullTitle(_ fullTitle: String)
}

protocol StockView: AnyObject{
    func showAlert(_ message: String)
}
