//
//  Enum.swift
//  stock_app
//
//  Created by Ekaterina Tarasova on 23.10.2021.
//

import Foundation

enum Result<T>{
    case Success(T)
    case Error(String)
}
