//
//  PrimeSheetView.swift
//  TCA-Project1
//
//  Created by Augusto Cordero Perez on 14/4/23.
//

import SwiftUI

struct PrimeAlert: Identifiable {
  let prime: Int
  var id: Int { self.prime }
}

enum PrimeAction {
    case savePrime
    case removePrime
}

struct PrimeSheetView: View {

    @ObservedObject var store: Store<AppState, AppAction>

    var body: some View {
        VStack {
            if isPrime(store.value.count) {
                Text("\(store.value.count) is prime")

                if store.value.currentCountIsFav {
                    Button(action: { store.send(action: .prime(.removePrime)) }) {
                        Text("Remove from favorites")
                    }
                } else {
                    Button(action: { store.send(action: .prime(.savePrime)) }) {
                        Text("Save to favorites primes")
                    }
                }
            } else {
                Text("\(store.value.count) is not prime :(")
            }
        }
    }

    private func isPrime(_ p: Int) -> Bool {
        if p <= 1 { return  false }
        if p <= 3 { return  true }
        for i in 2...Int(sqrtf(Float(p))) {
            if p % i == 0 { return false }
        }
        return true
    }
}
