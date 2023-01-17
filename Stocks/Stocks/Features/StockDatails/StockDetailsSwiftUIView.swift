//
//  StockDetailsSwiftUIView.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import SwiftUI
import XCAStocksAPI

//struct Stock: Identifiable {
//    var id: String { name }
//    let name: String
//    let values: [Int]
//
//    static let MSCIWorld = Stock (name: "MSCI World", values: [
//        1015, 1027, 1012, 1025, 1035, 1046, 1057, 1046, 1031, 1017, 1027, 1037, 1051, 1039,
//        1029, 1019, 1029, 1040, 1028, 1015, 1030, 1045, 1033, 1019, 1032, 1047, 1032, 1019,
//        1031, 1045, 1032, 1045, 1033, 1047, 1057, 1068, 1058, 1071, 1082, 1071, 1083, 1098,
//        1087, 1101, 1113, 1103, 1089, 1099, 1087, 1076, 1089, 1104, 1116, 1105, 1095, 1085,
//        1073, 1062, 1052, 1038, 1024, 1037, 1023, 1011, 1024, 1014, 1003, 1015, 1029, 1042,
//        1056, 1044, 1055, 1066, 1080, 1070, 1080, 1066, 1076, 1063, 1049, 1063, 1076, 1089,
//        1102, 1113, 1101, 1114, 1129, 1144, 1131, 1141, 1155, 1169, 1181, 1191, 1203, 1188,
//        1202, 1216, 1230, 1244, 1233, 1246, 1234, 1249, 1235, 1225, 1236, 1249, 1263, 1253,
//        1239, 1249, 1261, 1247, 1257, 1242, 1232, 1245
//    ])
//}



struct StockDetailsSwiftUIView: View {
    
    
    let presenter: StockDetailsPresenter
//    let stock = Stock.MSCIWorld
    let bgColor = Color(.black)
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
//            LineGraphSwiftUIView(values: presenter.values.map({ $0.value }))
//                .frame(maxHeight: .infinity)
            
            navBar
            
//            print(presenter.stockDetails)
            
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
                .background(selectedButtonTitle == title ? headerColor : .black.opacity(0.2))
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
            
            //Spacer()
            Text("\(curValue.timestamp)")
                .font(.subheadline.bold())
                .foregroundColor(.white)
                .padding(.leading)
                .padding(.trailing)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        }
//        .padding(20)
        .padding(.bottom, 10)
        .background(
            LinearGradient(gradient: Gradient(colors: [.gray.opacity(0.12), .gray.opacity(0.06), .black]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
    }
}


struct StockDetailsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
//        StockDetailsSwiftUIView(presenter: StockDetailsPresenter(service: XCAStocksAPI(), stock: Quote(symbol: "AAPL")))
        StockDetailsSwiftUIView(presenter: StockDetailsPresenter(service: XCAStocksAPI(),
                                                                 stock: Quote(symbol: "AAPL")))
    }
}

//import SwiftUI
//import Charts
//
//struct StockDetailsSwiftUIView: View {
//
//    let presenter: StockDetailsPresenter
//
//    init(presenter: StockDetailsPresenter) {
//        self.presenter = presenter
//        presenter.fetchStockChartDetails()
//    }
//
//    var body: some View {
//
//        VStack {
//            GroupBox ( "Line Chart - Step Count") {
//                Chart {
//                    ForEach(presenter.values) {
//                        LineMark(
//                            x: .value("Week Day", $0.timestamp, unit: .day),
//                            y: .value("Step Count", $0.value)
//                        )
//                    }
//                }
//            }
//        }
//    }
//}
