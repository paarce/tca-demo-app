//
//  FavoritePrimesView.swift
//  TCA-Project1
//
//  Created by Augusto Cordero Perez on 14/4/23.
//

import SwiftUI

enum FavoritePrimeAction {
    case delete(IndexSet)
}

struct FavoritesListView: View {

    @ObservedObject var store: Store<AppState, AppAction>

    var body: some View {
        List {
            ForEach(store.value.favoritePrimes, id: \.self) {
                Text("\($0)")
            }
            .onDelete { indexes in
                store.send(action: .favoritePrime(.delete(indexes)))
            }
        }
        .navigationTitle("Favorite primes")
    }
}

struct FavoritePrimesView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(
                initialValue: AppState(),
                reducer: { (_, _) in }
            )
        )
    }
}
