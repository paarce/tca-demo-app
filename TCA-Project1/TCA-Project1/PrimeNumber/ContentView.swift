//
//  ContentView.swift
//  TCA-Project1
//
//  Created by Augusto Cordero Perez on 7/3/23.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var store: Store<AppState>

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CounterView(store: store)) {
                    Text("Counter")
                }
                NavigationLink(destination: FavoritesListView(store: self.store)) {
                    Text("Favorite primes")
                }
            }
            .navigationTitle("State management")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialValue: AppState()))
    }
}


