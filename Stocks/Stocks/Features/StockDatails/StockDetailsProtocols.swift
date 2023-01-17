//
//  StockDetailsProtocols.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import Foundation

protocol StockDetailsView: AnyObject{
    func showAlert(_ message: String)
    func startLoading()
    func stopLoading()
}
