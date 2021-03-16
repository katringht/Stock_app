//
//  Model.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 14.03.2021.
//

import Foundation
import UIKit

var sourceSetted = false
var currentState = navigationState.stock
var hideState = Bool()


enum navigationState {
    case searching
    case favorite
    case stock
}

