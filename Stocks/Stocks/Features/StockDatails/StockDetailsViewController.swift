//
//  StockDetailsViewController.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import UIKit
import SnapKit

class StockDetailsViewController: UIViewController {
    
    private let presenter: StockDetailsPresenter
    
    init(presenter: StockDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        setup()
//        presenter.attachView(view: self)
    }
    
    private func setup() {
        
    }
}

