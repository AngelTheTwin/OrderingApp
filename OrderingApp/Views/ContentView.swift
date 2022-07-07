//
//  ContentView.swift
//  OrderingApp
//
//  Created by Angel de Jesús Sánchez Morales on 28/06/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("loggeduser") var user = Data()
    
    var body: some View {
        if (user.isEmpty) {
            LoginView()
        } else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
    }
}
