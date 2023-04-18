//
//  Operators.swift
//  TCA-Project1
//
//  Created by Augusto Cordero Perez on 17/4/23.
//

import Foundation

class Operators {

    static func combine<Value, Action>(
        _ reducers: (inout Value, Action) -> Void...
    ) -> (inout Value, Action) -> Void {
        return { value, action in
            for reducer in reducers {
                reducer(&value, action)
            }
        }
    }

    static func pullBack<LocalValue, GlobalValue, GlobalAction, LocalAction>(
        _ reducer: @escaping (inout LocalValue, LocalAction) -> Void,
        value: WritableKeyPath<GlobalValue, LocalValue>,
        action: WritableKeyPath<GlobalAction, LocalAction?>
    ) -> (inout GlobalValue, GlobalAction) -> Void {
        return { globalValue, globalAction in
            guard let localAction = globalAction[keyPath: action] else { return }
            reducer(&globalValue[keyPath: value], localAction)
        }
    }
}

// Legacy methods
extension Operators {
    static func pullBackByValue<LocalValue, GlobalValue, Action>(
        _ reducer: @escaping (inout LocalValue, Action) -> Void,
        value: WritableKeyPath<GlobalValue, LocalValue>
    ) -> (inout GlobalValue, Action) -> Void {
        return { global, action in
            reducer(&global[keyPath: value], action)
        }
    }

    // oldPullBack(method, get: { $0.cont }, set: { $0.count = $1 })
    static func oldPullBack<LocalValue, GlobalValue, Action>(
        _ reducer: @escaping (inout LocalValue, Action) -> Void,
        get: @escaping (GlobalValue) -> LocalValue,
        set: @escaping (inout GlobalValue, LocalValue) -> Void
    ) -> (inout GlobalValue, Action) -> Void {
        return { global, action in
            var localValue = get(global)
            reducer(&localValue, action)
            set(&global, localValue)
        }
    }
}
