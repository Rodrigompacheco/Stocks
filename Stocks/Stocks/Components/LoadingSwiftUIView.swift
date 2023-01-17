//
//  LoadingSwiftUIView.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 17/01/23.
//

import SwiftUI

struct LoadingSwiftUIView: View {
    var body: some View {
        ZStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .background(.clear)
        }
    }
}

struct LoadingSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSwiftUIView()
    }
}
