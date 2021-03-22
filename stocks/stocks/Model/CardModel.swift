//
//  CardModel.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 22.03.2021.
//

import SwiftUI
import RealmSwift
import Combine

class Card: Object, Identifiable, ObjectKeyIdentifiable {
    @objc dynamic var id: Date = Date()
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
//    @objc dynamic var isFavorite = 0
//    @objc dynamic var regularprice = 0.0
//    @objc dynamic var pricechange = ""
}
