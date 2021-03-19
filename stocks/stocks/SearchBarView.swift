//
//  SearchBarView.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 19.03.2021.
//

import SwiftUI

struct OvalTextFieldStyle: ViewModifier {
    var roundedCornes: CGFloat
    func body(content : Content) -> some View {
        content
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: roundedCornes)
                    .strokeBorder(Color.black, lineWidth: 1)
            )
    }
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var index: Int
    @State var isSearching = false
    
    var body: some View{
        
        VStack(spacing: 25){
            //textfield
            GeometryReader{reader in
                HStack{
                    Image(systemName: "magnifyingglass")
                    ZStack(alignment: .leading) {
                        if text.isEmpty { Text("Find stock or trend..").foregroundColor(.black) }

                        TextField("", text: $text)
                            .onTapGesture(perform: {
                                isSearching = true
                                self.index = 2
                            })
                    }
                    if isSearching{
                        Button(action: {
                            index = 0
                            text = ""
                            isSearching = false
                            
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        })
                        
                        
                    }
                }
                .modifier(OvalTextFieldStyle(roundedCornes: 20))
            }
            .frame(height: 10)
            .padding(.horizontal)
            .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 10)
        }
    }
}
