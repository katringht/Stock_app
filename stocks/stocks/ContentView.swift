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

//MARK: HOME

struct Home: View {
    
    @State var index = 0
    @State var text: String = ""
    @State var isHide = false
    
    var body: some View{
        
        VStack(spacing: 0){
            if !isHide{
                SearchBar( text: $text)
            }
            segmentedView(index: $index)
            
            ZStack{
                Stocks(text: $text, isHide: $isHide).opacity(self.index == 0 ? 1 : 0)
                
                Favorites().opacity(self.index == 1 ? 1 : 0)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}


//MARK: Stock View

struct Stocks: View {
    @State var stock = [Stock]()
    @Binding var text : String
    @Binding var isHide: Bool
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0 ){
                GeometryReader{ reader -> AnyView in
                    let yAxis = reader.frame(in: .global).minY
                    
                    if yAxis < 0 && !isHide{
                        DispatchQueue.main.async{
                            withAnimation{
                                isHide = true
                            }
                        }
                    }
                    
                    if yAxis > 0 && isHide{
                        DispatchQueue.main.async{
                            withAnimation{
                                isHide = false
                            }
                        }
                    }
                    return AnyView(
                        Text("")
                            .frame(width: 0, height: 0)
                    )
                }
                .frame(width: 0, height: 0)
                
                ForEach(stockSearchText(), id: \.self){ i in
                    VStack {
                        HStack{
                            VStack(alignment: .leading, spacing: 15){
                                HStack{
                                    Text(i.symbol)
                                        .font(Font.custom("Hiragino Sans W6", size: 15))
                                    Button(action: {
                                        //
                                    }) {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(Color(.systemGray))
                                    }
                                }
                                Text(i.longName).font(.caption)
                                    .font(Font.custom("Hiragino Sans W6", size: 18))
                            }
                            
                            Spacer()
                            
                            let myDouble = i.regularMarketPrice
                            let doubleStr = String(format: "%.2f", myDouble)
                            
                            VStack(alignment: .trailing, spacing: 15){
                                Text("$\(doubleStr)")
                                    .font(Font.custom("Hiragino Sans W5", size: 20))
                                    .foregroundColor(.black)
                                Text("\(i.regularMarketDayRange)")
                                    .font(.caption)
                                    .font(Font.custom("Hiragino Sans W5", size: 18))
                                    .foregroundColor(.green)
                            }
                        }
                        .background(Color(.systemGray6))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .background(Color(.systemGray6))
//                        .background(i % 2 == 1 ? Color.yellow : Color.gray)
                        .cornerRadius(17.0)
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    
                }
            }
            
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://mboum.com/api/v1/co/collections/?list=day_gainers&start=1&apikey=demo") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(StocksApi.self, from: data) {
                    DispatchQueue.main.async {
                        // update our UI
                        self.stock = decodedResponse.quotes
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
    }
    
    func stockSearchText() -> [Stock] {
        return stock.filter({ text.isEmpty ? true : $0.longName.contains(text) })
    }
}

//MARK: Favorite View

struct Favorites: View {
    
    @State var stock = [Stock]()
    
    
    var body: some View{
        List (stock, id: \.self){ item in
            VStack {
                Text(item.symbol).padding(.leading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.gray)
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://mboum.com/api/v1/co/collections/?list=day_gainers&start=1&apikey=demo") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(StocksApi.self, from: data) {
                    DispatchQueue.main.async {
                        // update our UI
                        self.stock = decodedResponse.quotes
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
    }
}


//MARK: API

struct StocksApi: Codable {
    var quotes: [Stock]
}

struct Stock: Codable, Hashable{
    var sharesOutstanding: Int
    var symbol: String
    var longName: String
    var regularMarketPrice: Double
    var regularMarketDayRange: String
    
}

