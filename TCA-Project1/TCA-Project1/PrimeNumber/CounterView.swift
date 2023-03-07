//
//  CounterView.swift
//  TCA-Project1
//
//  Created by Augusto Cordero Perez on 7/3/23.
//

import SwiftUI


struct CounterView: View {

    @ObservedObject var appState: AppState
    @State var isPrimerModalShow = false

    var body: some View {
        VStack {
            HStack {
                Button(action: {appState.count -= 1}) {
                    Text("-")
                }
                Text("\(appState.count)")
                Button(action: {appState.count += 1}) {
                    Text("+")
                }
            }
            Button(action: {
                self.isPrimerModalShow = true
            }) {
                Text("Is this prime?")
            }
            Button(action: {}) {
                Text("what is the \(ordinal(appState.count)) prime?")
            }
        }
        .navigationTitle("Counter Demo")
        .sheet(isPresented: $isPrimerModalShow) {
            PrimeSheetView(appState: appState)
        }
        
    }

}

extension CounterView {
    func ordinal(_ n: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: n as NSNumber) ?? ""
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(appState: .init())
    }
}


struct PrimeSheetView: View {

    @ObservedObject var appState: AppState

    var body: some View {
        VStack {
            if isPrime(appState.count) {
                Text("\(appState.count) is prime")

                if appState.currentCountIsFav() {
                    Button(action: {
                        appState.favoritePrimes.removeAll(where: { $0 == self.appState.count })
                    }) {
                        Text("Remove from favorites")
                    }
                } else {
                    Button(action: {
                        appState.favoritePrimes.append(self.appState.count)
                    }) {
                        Text("Save to favorites primes")
                    }
                }
            } else {
                Text("\(appState.count) is not prime :(")
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
