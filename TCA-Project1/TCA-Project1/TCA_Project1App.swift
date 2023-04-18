//
//  TCA_Project1App.swift
//  TCA-Project1
//
//  Created by Augusto Cordero Perez on 7/3/23.
//

import SwiftUI

@main
struct TCA_Project1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialValue: AppState(),
                    reducer: appReducer()
                )
            )
        }
    }
}

extension TCA_Project1App {
    func appReducer() -> (inout AppState, AppAction) -> Void {
        Operators.combine(
            Operators.pullBack(counterReducer, value: \.count, action: \.counter),
            Operators.pullBack(primeReducer, value: \.self, action: \.prime),
            Operators.pullBack(favoritePrimesReducer, value: \.favoritePrimes, action: \.favoritePrime)
        )
    }

    func counterReducer(count: inout Int, action: CounterAction) {
        switch action {
        case . incrTapped:
            count += 1
        case . decrTapped:
            count -= 1
        }
    }

    func primeReducer(state: inout AppState, action: PrimeAction) {
        switch action {
        case .savePrime:
            state.favoritePrimes.append(state.count)
        case .removePrime:
            state.favoritePrimes.removeAll(where: { $0 == state.count })
        }
    }

    func favoritePrimesReducer(state: inout [Int], action: FavoritePrimeAction) {
        switch action {
        case .delete(let indexes):
            for index in indexes {
                state.remove(at: index)
            }
        }
    }
}

enum AppAction {
    case counter(CounterAction)
    case prime(PrimeAction)
    case favoritePrime(FavoritePrimeAction)

    var counter: CounterAction? {
        get {
            guard case .counter(let action) = self else {  return nil }
            return action
        }

        set {
            guard case .counter = self, let newValue else {  return }
            self = .counter(newValue)
        }
    }

    var prime: PrimeAction? {
        get {
            guard case .prime(let action) = self else {  return nil }
            return action
        }
        set {
            guard case .prime = self, let newValue else {  return }
            self = .prime(newValue)
        }
    }
    var favoritePrime: FavoritePrimeAction? {
        get {
            guard case .favoritePrime(let action) = self else {  return nil }
            return action
        }
        set {
            guard case .favoritePrime = self, let newValue else {  return }
            self = .favoritePrime(newValue)
        }
    }
}
