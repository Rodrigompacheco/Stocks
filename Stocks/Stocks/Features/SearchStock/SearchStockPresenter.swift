//
//  SearchStockPresenter.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import Foundation

class SearchStockPresenter {
    
    private var search = ""
    let serchStockPlaceHolder = "Search your Stock here!"
    let searchButtonTitle = "SEARCH"
    let appName = "STOCKSapp"
    
    weak var presenterCoordinatorDelegate: SearchStockPresenterCoordinatorDelegate?
    
    init() {}
    
    func searchStockButtonPressed(text: String) {
        search = text
        presenterCoordinatorDelegate?.didSelectSearch(with: text)
    }
}
