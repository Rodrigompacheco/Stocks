//
//  MainCoordinator.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 16/01/23.
//

import UIKit
import XCAStocksAPI

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let service: IStocksAPI
    
    init(navigationController: UINavigationController, service: IStocksAPI = XCAStocksAPI()) {
        self.navigationController = navigationController
        self.service = service
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.barTintColor = .red
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let presenter = SearchStockPresenter(service: service)
        presenter.presenterCoordinatorDelegate = self
        let viewController = SearchStockViewController(presenter: presenter)
        viewController.title = "Stocks"
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension MainCoordinator: SearchStockPresenterCoordinatorDelegate {
    func didSelectStock(stock: Quote) {
        let presenter = StockDetailsPresenter(service: service, stock: stock)
        
        let viewController = StockDetailsViewController(presenter: presenter)
        viewController.title = stock.symbol.uppercased()
        navigationController.pushViewController(viewController, animated: true)
    }
}
