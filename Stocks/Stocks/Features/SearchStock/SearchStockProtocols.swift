//
//  SearchStockProtocols.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

protocol SearchStockPresenterCoordinatorDelegate: AnyObject {
    func didSelectSearch(with text: String)
}
