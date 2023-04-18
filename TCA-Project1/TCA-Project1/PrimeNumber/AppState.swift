//
//  AppState.swift
//  TCA-Project1
//
//  Created by Augusto Cordero Perez on 7/3/23.
//

import SwiftUI
import Combine

final class Store<Value: ObservableObject, Action>: ObservableObject {

    let reducer: (inout Value, Action) -> Void
    private var cancellables: Set<AnyCancellable> = []
    var value: Value

    init(initialValue: Value, reducer: @escaping (inout Value, Action) -> Void) {
        self.value = initialValue
        self.reducer = reducer

        initialValue.objectWillChange
          .map { _ in } // ignore actual values
          .sink(receiveValue: self.objectWillChange.send)
          .store(in: &cancellables)
    }

    func send(action: Action) {
        reducer(&self.value, action)
    }
}

class AppState: ObservableObject {
    @Published var count: Int = 0
    @Published var favoritePrimes = [Int]()
    @Published var loggedInUser: User?
    @Published var activity: Activity?

    var currentCountIsFav: Bool {
        favoritePrimes.contains(count)
    }

    struct User {
        let id: Int
        let name: String
    }

    struct Activity {
        let timestamp: Date
        let type: ActivityType

        enum ActivityType {
            case addedFavoritePrime(Int)
            case removedFavoritePrime(Int)
        }
    }
}
