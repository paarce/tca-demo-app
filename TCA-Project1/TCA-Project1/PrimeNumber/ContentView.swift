//
//  ContentView.swift
//  TCA-Project1
//
//  Created by Augusto Cordero Perez on 7/3/23.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var count: Int = 0
    @Published var favoritePrimes = [Int]()

    func currentCountIsFav() -> Bool {
        favoritePrimes.contains(count)
    }
}

struct ContentView: View {

    @ObservedObject var appState: AppState

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CounterView(appState: appState)) {
                    Text("Counter")
                }
                NavigationLink(destination: FavoritesListView(appState: appState)) {
                    Text("favorite primes")
                }
            }
            .navigationTitle("State management")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: .init())
    }
}


struct FavoritesListView: View {

    @ObservedObject var appState: AppState

    var body: some View {
        List {
            ForEach(appState.favoritePrimes, id: \.self) {
                Text("\($0)")
            }
            .onDelete { indexes in
                for index in indexes {
                    appState.favoritePrimes.remove(at: index)
                }
            }
        }
        .navigationTitle("Favorite primes")
    }
}
