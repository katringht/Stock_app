//
//  DataModel.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 22.03.2021.
//

import SwiftUI
import RealmSwift

class DataModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var updateObject : Card?
    @Published var isFavorite = false
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard let dbRef = try? Realm()  else {return}
        
        let results = dbRef.objects(Card.self)
        //displaying results
        self.cards = results.compactMap({(card) -> Card? in
            return card
        })
        
    }
    
    func addData(title: String, detail: String) {
        
        let card = Card()
        card.title = title
        card.detail = detail
//        card.isFavorite = isFavorite
//        card.pricechange = change
//        card.regularprice = regular
        
        //getting refrence
        
        guard let dbRef = try? Realm()  else {return}
        
        //writing data
        try? dbRef.write{
            dbRef.add(card)
            
            //updating ui
            fetchData()
        }
    }
    
    func deleteData(obj: Card) {
        guard let dbRef = try? Realm()  else {return}
        
        try? dbRef.write{
            dbRef.delete(obj)
            
            fetchData()
        }
    }
    
//    func setUpInitialData(){
//
//        // Updation...
//
//        guard let updateData = updateObject else{return}
//
//        // Checking if it's update object and assigning values...
//        title = updateData.title
//        detail = updateData.detail
//    }
    
}
