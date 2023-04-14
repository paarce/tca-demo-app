//
//  CounterView.swift
//  TCA-Project1
//
//  Created by Augusto Cordero Perez on 7/3/23.
//

import SwiftUI

struct CounterView: View {

    @ObservedObject var store: Store<AppState>
    @State var isPrimeModalShow = false
    @State var alertPrime: PrimeAlert?

    var body: some View {
        VStack {
            HStack {
                Button(action: {store.value.count -= 1}) {
                    Text("-")
                }
                Text("\(store.value.count)")
                Button(action: {store.value.count += 1}) {
                    Text("+")
                }
            }
            Button(action: {
                isPrimeModalShow.toggle()
            }) {
                Text("Is this prime?")
            }
            Button(action: {
                nthPrime(store.value.count) { nth in
                    guard let nth else { return }
                    alertPrime = .init(prime: nth)
                }
            }) {
                Text("what is the \(ordinal(store.value.count)) prime?")
            }
        }
        .navigationTitle("Counter Demo")
        .sheet(isPresented: $isPrimeModalShow) {
            PrimeSheetView(store: store)
        }
        .sheet(item: $alertPrime, content: { n in
            Text("The Nth prime is \(n.id)")
        })
    }
}

extension CounterView {
    func ordinal(_ n: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: n as NSNumber) ?? ""
    }
    
    func nthPrime(_ n: Int, callback: @escaping (Int?) -> Void) -> Void {
      wolframAlpha(query: "prime \(n)") { result in
        callback(
          result
            .flatMap {
              $0.queryresult
                .pods
                .first(where: { $0.primary == .some(true) })?
                .subpods
                .first?
                .plaintext
            }
            .flatMap(Int.init)
        )
      }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(store: Store(initialValue: AppState()))
    }
}
