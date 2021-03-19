//
//  Test.swift
//  stocks
//
//  Created by Ekaterina Tarasova on 19.03.2021.
//

import SwiftUI

struct Test: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                apiCall().getStock()
            }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
