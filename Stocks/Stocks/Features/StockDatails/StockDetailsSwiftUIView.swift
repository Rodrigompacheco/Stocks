//
//  StockDetailsSwiftUIView.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import SwiftUI
import XCAStocksAPI

struct StockDetailsSwiftUIView: View {
    
    let presenter: StockDetailsPresenter
    let bgColor = Color(.black)
    let purpleColor = Color(red: 185/255, green: 166/255, blue: 247/255)
    let headerColor = Color(hue: 0.357, saturation: 0.233, brightness: 0.118)
    
    @State private var chartData: StockChartData?
    @State private var selectedValue: StockChartItem?
    @State private var isLoading: Bool = false
    @State private var selectedButtonTitle = "1D"
    
    init(presenter: StockDetailsPresenter) {
        self.presenter = presenter
    }

    var curValue: StockChartItem {
        if let selectedValue = selectedValue {
            return selectedValue
        }
        return chartData?.stockChartItems.last ?? StockChartItem(timestamp: Date(), value: 0)
    }

    var body: some View {
        VStack(spacing: 0) {
            navBar
                        
            ZStack {
                LineGraphSwiftUIView(chartItems: chartData?.stockChartItems ?? [StockChartItem(timestamp: Date(),
                                                                                               value: 0)],
                                     growingState: chartData?.growingState ?? true,
                                     selectedValue: $selectedValue)
                    .accentColor(bgColor)
                    .frame(maxHeight: .infinity)
                
                if isLoading {
                    LoadingSwiftUIView()
                        .accentColor(bgColor)
                }
            }
            
            HStack {
                customButton(title: "1D") {
                    fetchStockChartDetails(for: .oneDay)
                }
                
                customButton(title: "1W") {
                    fetchStockChartDetails(for: .oneWeek)
                }
                
                customButton(title: "1M") {
                    fetchStockChartDetails(for: .oneMonth)
                }
                
                customButton(title: "3M") {
                    fetchStockChartDetails(for: .threeMonth)
                }
                
                customButton(title: "1Y") {
                    fetchStockChartDetails(for: .oneYear)
                }
            }
            .padding(.top, 10)
            
            HStack {
                customButton(title: "YTD") {
                    fetchStockChartDetails(for: .ytd)
                }
                
                customButton(title: "MAX") {
                    fetchStockChartDetails(for: .max)
                }
            }
            .padding(.top, 10)
        }
        .background(bgColor.ignoresSafeArea())
        .statusBar(hidden: true)
        .onAppear {
            fetchStockChartDetails(for: .oneDay)
        }
    }
    
    func fetchStockChartDetails(for range: ChartRange) {
        isLoading = true
        presenter.fetchStockChartDetails(for: range) {
            chartData = presenter.stockDetails
            isLoading = false
        }
    }
    
    func customButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: {
            selectedButtonTitle = title
            selectedValue = nil
            action()
        }) {
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 6)
                .background(selectedButtonTitle == title ? purpleColor.opacity(0.9) : .black.opacity(0.2))
                .cornerRadius(5)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    var navBar: some View {
        VStack {
            Text("$ \(curValue.value)")
                .font(.title.bold())
                .foregroundColor (.white)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.trailing)
                .padding(.bottom, 10)
            
            Text("\(curValue.timestamp)")
                .font(.subheadline.bold())
                .foregroundColor(.white)
                .padding(.leading)
                .padding(.trailing)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
        .padding(.bottom, 10)
        .background(
            LinearGradient(gradient: Gradient(colors: [purpleColor.opacity(0.19), purpleColor.opacity(0.10), .black]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
    }
}


struct StockDetailsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailsSwiftUIView(presenter: StockDetailsPresenter(service: XCAStocksAPI(),
                                                                 stock: Quote(symbol: "AAPL")))
    }
}
