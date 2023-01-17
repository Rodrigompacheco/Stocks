//
//  StockDetailsViewController.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import UIKit
import SnapKit

class StockDetailsViewController: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView()
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
        setupActivityIndicator()
        presenter.attachView(view: self)
    }
    
    private func setup() {
        
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

extension StockDetailsViewController: StockDetailsView {
    func showAlert(_ message: String) {
        
    }
    
    func startLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.bringSubviewToFront(activityIndicator)
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.view.sendSubviewToBack(self.activityIndicator)
        }
    }
}

