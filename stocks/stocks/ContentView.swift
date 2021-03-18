//
//  ContentView.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 18.03.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var index = 0
    @State var show = false
    
    var body: some View{
        
        VStack(spacing: 0){
            appBar(index: self.$index, show: self.$show)
            
            ZStack{
                Stocks(show: self.$show).opacity(self.index == 0 ? 1 : 0)
                
                Favorites().opacity(self.index == 1 ? 1 : 0)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

//MARK:App Bar

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
struct appBar: View {
    @Binding var index: Int
    @Binding var show: Bool
    @State var text: String = ""
    
    var body: some View{
        
        VStack(spacing: 25){
            //textfield
            if self.show{
                HStack{
                    Image(systemName: "magnifyingglass")
                    ZStack(alignment: .leading) {
                            if text.isEmpty { Text("Find stock or trends..").foregroundColor(.black) }
                            TextField("", text: $text)
                        }
                }
                .modifier(OvalTextFieldStyle(roundedCornes: 20))
            }
            
            //segmented
            HStack{
                Button(action: {
                    self.index = 0
                }){
                    Text("Stocks")
                        .foregroundColor(self.index == 0 ? .black : .gray)
                        .fontWeight(.bold)
                        .font(Font.system(size: self.index == 0 ? 25 : 20))
                }
                
                Button(action: {
                    self.index = 1
                }){
                    Text("Favorites")
                        .foregroundColor(self.index == 1 ? .black : .gray)
                        .fontWeight(.bold)
                        .font(Font.system(size: self.index == 1 ? 25 : 20))
                }
                Spacer()
            }.padding(.bottom, 10)
            
        }
        .padding(.horizontal)
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 10)
    }
}

//MARK: Segments Views

struct Stocks: View {
    @Binding var show: Bool
    
    var body: some View{
        List {
            ForEach(0...15, id: \.self){ i in
                VStack {
                    if i == 0{
                        CellView()
                            .onAppear{
                                withAnimation{
                                    self.show = true
                                }
                            }
                            .onDisappear{
                                withAnimation{
                                    self.show = false
                                }
                            }
                    }
                    else{
                        CellView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .listRowInsets(EdgeInsets())
                .background(Color.white)
            }
        }
    }
}

struct Favorites: View {
    var body: some View{
        List {
            ForEach(0...15, id: \.self){ i in
                VStack {
                    Text("Favorites").padding(.leading)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .listRowInsets(EdgeInsets())
                .background(Color.white)
            }
        }
    }
}

//MARK: Cell Model

struct CellView: View {
    @State var stocks: [Stock] = []
    
    var body: some View{
        
        HStack{
            
            VStack(alignment: .leading, spacing: 15){
                Text("APPL")
                Text("Apple Inc.").font(.caption)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 15){
                Text("340$")
                    .foregroundColor(.green)
                Text("+3%").font(.caption)
            }
        }
        .background(Color(.systemGray6))
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .background(Color(.systemGray6))
        .cornerRadius(15.0)
        
        
    }
    
}

