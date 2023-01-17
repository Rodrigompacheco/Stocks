//
//  LineGraphSwiftUIView.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import SwiftUI
import XCAStocksAPI

struct GraphNode: Identifiable {
    let id = UUID()
    let value: Int
    let percentageX: Double
    let percentageY: Double
    
    func point(for size: CGSize) -> CGPoint {
        CGPoint(x: size.width * percentageX,
                y: size.height * percentageY)
    }
}

struct LineGraph: Shape {
    let nodes: [GraphNode]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for i in nodes.indices {
            let point = nodes[i].point(for: rect.size)
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        return path
    }
}

struct LineGraphSwiftUIView: View {
    
    let graphNodes: [GraphNode]
    @State private var selectedNode: GraphNode? = nil
    @Binding private var selectedValue: Int?
    
    init(values: [Int], selectedValue: Binding<Int?>) {
        self._selectedValue = selectedValue
        guard var maxValue = values.max(), var minValue = values.min() else {
            graphNodes = [GraphNode]()
            return
        }
        maxValue = maxValue + 20
        minValue = minValue - 20
        
        var nodes = [GraphNode]()
        for i in values.indices {
            let percentageY = 1 - Double(values[i] - minValue) / Double(maxValue - minValue)
            let percentageX = Double(i) / Double (values.count - 1)
            let newNode = GraphNode (value: values[i],
                                     percentageX: percentageX,
                                     percentageY: percentageY)
            nodes.append(newNode)
        }
        self.graphNodes = nodes
    }
    /*
    init(values: [Double]) {
        guard var maxValue = values.max(), var minValue = values.min() else {
            graphNodes = [GraphNode]()
            return
        }
        
        maxValue = maxValue + 20
        minValue = minValue - 20
        
        var nodes = [GraphNode]()
        for i in values.indices {
            let percentageY = 1 - Double(values[i] - minValue) / Double(maxValue - minValue)
            let percentageX = Double(i) / Double (values.count - 1)
            let newNode = GraphNode (value: values[i],
                                     percentageX: percentageX,
                                     percentageY: percentageY)
            nodes.append(newNode)
        }
        self.graphNodes = nodes
    }
     */
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                LineGraph(nodes: graphNodes)
                    .stroke(Color.black.opacity(0.8), style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                
                selectedNodeHighlight(viewSize: reader.size)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.opacity(0.000001))
            .coordinateSpace(name: "chart")
            .gesture(dragGesture(size: reader.size))
        }
    }
    
    @ViewBuilder
    func selectedNodeHighlight(viewSize: CGSize) -> some View {
        if let selectedNode = selectedNode, selectedValue != nil {
            let posX = viewSize.width * selectedNode.percentageX
            Rectangle ()
                .foregroundColor (.white.opacity(0.5))
                .frame (width: 4.5)
                .position(x: posX, y: viewSize.height / 2)
            
            let point = selectedNode.point(for: viewSize)
            ZStack {
                Circle()
                    .frame(width: 18, height: 18)
                    .foregroundColor (.white.opacity (0.9))
                
                Circle()
                    .frame (width: 11, height: 11)
                    .foregroundColor (Color .accentColor)
            }
            .position(x: point.x, y: point.y)
        }
    }
    
    func dragGesture(size: CGSize) -> some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .named("chart"))
            .onChanged { val in
                if graphNodes.isEmpty { return }
                
                var smallestIndex = 0
                var smallestDistance: CGFloat = 99999
                for i in graphNodes.indices {
                    let dragPercentageX = val.location.x / size.width
                    let distance = abs (graphNodes[i].percentageX - dragPercentageX)
                    if distance < smallestDistance {
                        smallestDistance = distance
                        smallestIndex = i
                    }
                }
                
                selectedNode = graphNodes[smallestIndex]
                selectedValue = graphNodes[smallestIndex].value
            }
    }
}

struct LineGraphSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
//        StockDetailsSwiftUIView(presenter: StockDetailsPresenter(service: XCAStocksAPI(), stock: Quote(symbol: "AAPL")))
        StockDetailsSwiftUIView()
    }
}
