//
//  FavoritePrimesView.swift
//  TCA-Project1
//
//  Created by Augusto Cordero Perez on 14/4/23.
//

import SwiftUI


struct FavoritesListView: View {

    @ObservedObject var store: Store<AppState>

    var body: some View {
        List {
            ForEach(store.value.favoritePrimes, id: \.self) {
                Text("\($0)")
            }
            .onDelete { indexes in
                for index in indexes {
                    store.value.favoritePrimes.remove(at: index)
                }
            }
        }
        .navigationTitle("Favorite primes")
    }
}

struct FavoritePrimesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView(store: Store(initialValue: AppState()))
    }
}
