//
//  MainCoordinator.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 16/01/23.
//

import UIKit
import SwiftUI
import XCAStocksAPI

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let service: IStocksAPI
    
    init(navigationController: UINavigationController, service: IStocksAPI = XCAStocksAPI()) {
        self.navigationController = navigationController
        self.service = service
        
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.barTintColor = .red
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let presenter = SearchStockPresenter()
        presenter.presenterCoordinatorDelegate = self
        let viewController = SearchStockViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension MainCoordinator: StockListPresenterCoordinatorDelegate {
    func didSelectStock(stock: Quote) {
        let presenter = StockDetailsPresenter(service: service, stock: stock)
        let viewController = UIHostingController(rootView: StockDetailsSwiftUIView(presenter: presenter))
        viewController.title = stock.symbol.uppercased()
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: SearchStockPresenterCoordinatorDelegate {
    func didSelectSearch(with text: String) {
        let presenter = StockListPresenter(service: service, search: text)
        presenter.presenterCoordinatorDelegate = self
        let viewController = StockListViewController(presenter: presenter)
        viewController.title = "Stocks"
        navigationController.pushViewController(viewController, animated: true)
    }
}
