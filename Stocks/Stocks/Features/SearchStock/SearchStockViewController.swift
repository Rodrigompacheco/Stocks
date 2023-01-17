//
//  SearchStockViewController.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import UIKit

class SearchStockViewController: UIViewController {
    
    private let presenter: SearchStockPresenter
    private let appLogoImageView = UIImageView()
    private let appTitleLabel = UILabel()
    private let searchStockTextField = UITextField()
    private let searchButton = UIButton()
    
    init(presenter: SearchStockPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        setupSearchStockTextField()
        setupAppLogo()
        setupAppTitleLabel()
        setupSearchButton()
    }
    
    private func setupAppLogo() {
        view.addSubview(appLogoImageView)
        
        appLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(130)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(80)
        }
        
        appLogoImageView.image = UIImage(named: "stocksLogo")
        
    }
    
    private func setupAppTitleLabel() {
        view.addSubview(appTitleLabel)
        
        appTitleLabel.snp.makeConstraints {
            $0.top.equalTo(appLogoImageView.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalToSuperview()
        }
        
        appTitleLabel.text = presenter.appName
        appTitleLabel.font = .monospacedSystemFont(ofSize: 30, weight: .bold)
        appTitleLabel.textColor = .white
        appTitleLabel.textAlignment = .center
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
        searchStockTextField.layer.borderColor = UIColor.white.cgColor
        searchStockTextField.contentVerticalAlignment = .center
        searchStockTextField.font = .monospacedSystemFont(ofSize: 15, weight: .bold)
        searchStockTextField.textAlignment = .center
        searchStockTextField.backgroundColor = .white
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
        searchButton.backgroundColor = AppColorPalette.purple
        searchButton.layer.cornerRadius = 20
        searchButton.titleLabel?.font = .monospacedSystemFont(ofSize: 15, weight: .bold)
        searchButton.addTarget(self, action: #selector(searchStockButtonPressed), for: .touchUpInside)
    }
    
    @objc func searchStockButtonPressed() {
        presenter.searchStockButtonPressed(text: searchStockTextField.text ?? "")
        searchStockTextField.resignFirstResponder()
    }
}
