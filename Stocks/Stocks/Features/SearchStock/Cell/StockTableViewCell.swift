//
//  StockTableViewCell.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 16/01/23.
//

import UIKit
import SnapKit

final class StockTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: StockTableViewCell.self)
    
    private var stockCodTitleLabel = UILabel()
    private var stockCurrentValueLabel = UILabel()
    private var stockPercentLabel = UILabel()
    private var stockNameTitleLabel = UILabel()
    private var stockCodLabel = UILabel()
    private var stockNameLabel = UILabel()
    private var cardView = UIView()
    private var lineSeparatorView = UIView()
    
    private var presenter: StockTableViewCellPresenter?

    func attachPresenter(_ presenter: StockTableViewCellPresenter) {
        self.presenter = presenter
        presenter.attachView(self)
    }
    
    private func setupCardView() {
        self.addSubview(cardView)
        
        cardView.snp.makeConstraints {
            $0.top.leading.equalTo(10)
            $0.bottom.trailing.equalTo(-10)
        }
        
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOpacity = 0.7
    }
    
    private func setupRepositoryLabel() {
        cardView.addSubview(stockCodTitleLabel)

        stockCodTitleLabel.snp.makeConstraints {
            $0.top.equalTo(cardView).offset(10)
            $0.leading.equalTo(10)
        }
        
        stockCodTitleLabel.font = AppFonts.cardTitle
    }
    
    private func setupStarsLabel() {
        cardView.addSubview(stockCurrentValueLabel)
        
        stockCurrentValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(stockCodTitleLabel)
            $0.trailing.equalTo(cardView).offset(-10)
        }
        
        stockCurrentValueLabel.font = AppFonts.cardSubtitle
    }
    
    private func setupAuthorLabel() {
        cardView.addSubview(stockNameTitleLabel)
        
        stockNameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(lineSeparatorView.snp.bottom).offset(screenBased(regular: 18, reduced: 15, extended: 20))
            $0.leading.equalTo(stockCodTitleLabel.snp.leading)
        }
        
        stockNameTitleLabel.font = AppFonts.cardTitle
    }
    
    private func setupRepoNameLabel() {
        cardView.addSubview(stockCodLabel)
        
        stockCodLabel.snp.makeConstraints {
            $0.top.equalTo(stockCodTitleLabel.snp.bottom).offset(screenBased(regular: 4, reduced: 3, extended: 5))
            $0.leading.equalTo(stockCodTitleLabel.snp.leading)
        }
        
        stockCodLabel.font = AppFonts.cardSubtitle
        stockCodLabel.textColor = AppColorPalette.bluePetroleum
    }
    
    private func setupRepoStarsLabel() {
        cardView.addSubview(stockPercentLabel)
        
        stockPercentLabel.snp.makeConstraints {
            $0.centerY.equalTo(stockCodLabel)
            $0.trailing.equalTo(stockCurrentValueLabel.snp.trailing)
        }
        
        stockPercentLabel.font = AppFonts.cardSubtitle
        stockPercentLabel.textColor = AppColorPalette.yellowGold
    }
    
    private func setupAuthorNameLabell() {
        cardView.addSubview(stockNameLabel)
        
        stockNameLabel.snp.makeConstraints {
            $0.top.equalTo(stockNameLabel.snp.bottom).offset(screenBased(regular: 4, reduced: 3, extended: 5))
            $0.leading.equalTo(stockNameLabel.snp.leading)
        }
        
        stockNameLabel.font = AppFonts.cardSubtitle
        stockNameLabel.textColor = AppColorPalette.bluePetroleum
    }

    private func setupLineSeparatorView() {
        cardView.addSubview(lineSeparatorView)
        
        lineSeparatorView.snp.makeConstraints {
            $0.top.equalTo(stockCodLabel.snp.bottom).offset(screenBased(regular: 18, reduced: 15, extended: 20))
            $0.leading.equalTo(10)
            $0.trailing.equalTo(-10)
            $0.height.equalTo(1)
        }
        
        lineSeparatorView.backgroundColor = .lightGray
        lineSeparatorView.alpha = 0.5
    }
}

extension StockTableViewCell: StockTableCellView {
    func setupView() {
        self.selectionStyle = .none
        self.backgroundColor = AppColorPalette.mainBackground

        setupCardView()
        setupRepositoryLabel()
        setupStarsLabel()
        setupRepoNameLabel()
        setupRepoStarsLabel()
        setupLineSeparatorView()
        setupAuthorLabel()
        setupAuthorNameLabell()
    }
    
    func setStockCodTitle(_ title: String) {
        stockCodTitleLabel.text = title
    }
    
    func setStockNameTitle(_ title: String) {
        stockNameTitleLabel.text = title
    }
    
    func setStockPercentStatus(_ percent: String) {
        stockPercentLabel.text = percent
    }
    
    func setStockCurrentValue(_ value: String) {
        stockCurrentValueLabel.text = value
    }
}
