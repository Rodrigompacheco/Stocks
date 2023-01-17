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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.barTintColor = .red
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let service = XCAStocksAPI()
        let viewController = SearchStockViewController(presenter: SearchStockPresenter(service: service))
        viewController.title = "Stocks"
        navigationController.pushViewController(viewController, animated: false)
    }
}
