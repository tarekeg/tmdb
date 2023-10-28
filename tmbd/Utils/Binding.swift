//
//  Binding.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

@propertyWrapper
struct Mutable<Value> {
    var wrappedValue: Value {
        get { projectedValue.value }
        set { projectedValue.accept(newValue) }
    }
    
    let projectedValue: BehaviorRelay<Value>
    
    init(wrappedValue: Value) {
        projectedValue = BehaviorRelay(value: wrappedValue)
    }
}

extension Mutable {
    typealias LateInit = LateMutable
}

/// `Mutable` where `BehaviorRelay` is initialized on setting first value
///
@propertyWrapper
struct LateMutable<Value> {
    private var publisher: BehaviorRelay<Value>?
    
    var wrappedValue: Value {
        get { projectedValue.value }
        set {
            if let publisher = self.publisher {
                publisher.accept(newValue)
            } else {
                publisher = BehaviorRelay(value: newValue)
            }
        }
    }
    
    var projectedValue: BehaviorRelay<Value> {
        guard let publisher = self.publisher else {
            fatalError("Property being accessed without initialization")
        }
        return publisher
    }
}

/// One parameter observable function, use to trigger view action from view model.
/// Example of action would be show alert, open view controller, dismiss, etc.
/// Note that the wrapped value type has to be a function with single parameter.
@propertyWrapper
struct ViewAction<Value> {
    private let publisher = PublishRelay<Value>()
    let projectedValue: PublishRelay<Value>
    
    let wrappedValue: (Value) -> Void
    
    init() {
        let publisher = self.publisher
        projectedValue = publisher
        wrappedValue = { publisher.accept($0) }
    }
}

extension ViewAction {
    typealias NoParam = NoParamViewAction
}

@propertyWrapper
struct NoParamViewAction {
    private let publisher = PublishRelay<Void>()
    let projectedValue: PublishRelay<Void>
    
    let wrappedValue: () -> Void
    
    init() {
        let publisher = self.publisher
        projectedValue = publisher
        wrappedValue = { publisher.accept(()) }
    }
}
