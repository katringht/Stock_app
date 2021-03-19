//
//  PopularQueriesView.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 19.03.2021.
//

import SwiftUI

struct PopularQueries: View {
    var popular = ["Wix.com", "Blooming", "Vistra", "LKQ", "Porshe"]
    var recently = ["Wix.com", "FirstEnergy"]
    var body: some View{
        VStack(alignment: .leading, spacing: 5){
            HStack{
                Text("Popular queries")
                    .padding(.top, 50)
                    .padding(.leading, 10)
                    .font(Font.custom("Hiragino Sans W6", size: 20))
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach (popular, id: \.self){ item in
                        Text("\(item)")
                            .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(20.0)
                    }
                }
            }
            
            HStack{
                Text("Resently search")
                    .padding(.top, 50)
                    .padding(.leading, 10)
                    .font(Font.custom("Hiragino Sans W6", size: 20))
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach (recently, id: \.self){ item in
                        Text("\(item)")
                            .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(20.0)
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}

