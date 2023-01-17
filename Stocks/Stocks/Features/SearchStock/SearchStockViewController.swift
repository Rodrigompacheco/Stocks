//
//  SearchStockViewController.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 16/01/23.
//

import UIKit
import SnapKit

class SearchStockViewController: UIViewController {
    
    private let presenter: SearchStockPresenter
    private let stocksTableView = UITableView()
    private let searchStockTextField = UITextField()
    private let searchButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView()
    private let searchTFReducedConstraint = 10
    
    init(presenter: SearchStockPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) { return nil }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = .white
        setupSearchStockTextField()
        setupSearchButton()
        setupStocksTableView()
        setupActivityIndicator()
        presenter.attachView(view: self)
    }
    
    private func setupSearchStockTextField() {
        view.addSubview(searchStockTextField)
        
        searchStockTextField.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.height.equalTo(60)
            $0.width.equalToSuperview().offset(-50)
        }
        
        searchStockTextField.placeholder = presenter.serchStockPlaceHolder
        searchStockTextField.layer.cornerRadius = 30
        searchStockTextField.layer.borderWidth = 1.0
        searchStockTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchStockTextField.contentVerticalAlignment = .center
        searchStockTextField.textAlignment = .center
    }
    
    private func setupSearchButton() {
        view.addSubview(searchButton)
        
        searchButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(100)
            $0.top.equalTo(searchStockTextField.snp.bottom).offset(20)
        }

        searchButton.setTitle(presenter.searchButtonTitle, for: .normal)
        searchButton.backgroundColor = .blue
        searchButton.layer.cornerRadius = 20
        searchButton.addTarget(self, action: #selector(searchStockButtonPressed), for: .touchUpInside)
    }
    
    private func setupStocksTableView() {
        view.addSubview(stocksTableView)
        
        stocksTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        stocksTableView.dataSource = self
        stocksTableView.separatorColor = .clear
        stocksTableView.backgroundColor = AppColorPalette.mainBackground
        stocksTableView.isHidden = presenter.isStocksListHidden
        stocksTableView.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.identifier)
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc func searchStockButtonPressed() {
        presenter.searchStockButtonPressed(withText: searchStockTextField.text ?? "")
        searchStockTextField.resignFirstResponder()
    }
}

extension SearchStockViewController: UITableViewDataSource {
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
            return screenBased(regular: 196, reduced: 188, extended: 200)
        } else {
            return 50
        }
    }
}

extension SearchStockViewController: StockView {
    func changeStocksListVisibility() {
//        DispatchQueue.main.sync {
            searchButton.isHidden = !presenter.isStocksListHidden
            searchStockTextField.isHidden = !presenter.isStocksListHidden
            stocksTableView.isHidden = presenter.isStocksListHidden
//        }
    }
    
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
        
    }
}
