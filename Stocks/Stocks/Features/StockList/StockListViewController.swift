//
//  SearchStockViewController.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 16/01/23.
//

import UIKit
import SnapKit

class StockListViewController: UIViewController {
    
    private let presenter: StockListPresenter
    private let stocksTableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    
    init(presenter: StockListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) { return nil }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupStocksTableView()
        setupActivityIndicator()
        presenter.attachView(view: self)
    }
    
    private func setupStocksTableView() {
        view.addSubview(stocksTableView)
        
        stocksTableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
        stocksTableView.separatorColor = .clear
        stocksTableView.backgroundColor = AppColorPalette.mainBackground
        stocksTableView.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.identifier)
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        activityIndicator.color = .white
    }
}

extension StockListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getTotalStocks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.identifier, for: indexPath) as? StockTableViewCell {
            guard let stock = presenter.getStock(at: indexPath.row) else { return defaultCell }
            
            let stockTablePresenter = StockTableViewCellPresenter(stock: stock)
            cell.attachPresenter(stockTablePresenter)
            
            return cell
        }
        
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return screenBased(regular: 80, reduced: 70, extended: 90)
        } else {
            return 50
        }
    }
}

extension StockListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.stockSelected(at: indexPath.row)
    }
}

extension StockListViewController: StockView {
    func reloadData() {
        DispatchQueue.main.async {
            self.stocksTableView.reloadData()
        }
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
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
