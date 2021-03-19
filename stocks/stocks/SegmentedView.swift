//
//  SegmentedView.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 19.03.2021.
//

import SwiftUI


struct segmentedView: View {
    @Binding var index: Int
    var body: some View{
        HStack{
            Button(action: {
                self.index = 0
            }){
                Text("Stocks")
                    .foregroundColor(self.index == 0 ? .black : .gray)
                    .fontWeight(.bold)
                    .font(Font.custom("Hiragino Sans W6", size: self.index == 0 ? 25 : 20))
            }
            
            Button(action: {
                self.index = 1
            }){
                Text("Favorites")
                    .foregroundColor(self.index == 1 ? .black : .gray)
                    .fontWeight(.bold)
                    .font(Font.custom("Hiragino Sans W6", size: self.index == 1 ? 25 : 20))
            }
            Spacer()
        }
        .padding(.bottom, 10)
        .padding(.horizontal)
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 10)
    }
}
