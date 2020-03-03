//
//  DynamicType.swift
//  MovieBuff
//
//  Created by Mac Tester on 11/29/16.
//  Copyright © 2016 Lunaria Software LLC. All rights reserved.
//

public struct DynamicType<T> {

    typealias ModelEventListener = (T) -> Void
    typealias Listeners = [ModelEventListener]

    private var listeners: Listeners = []
    var value: T? {
        didSet {
            listeners.forEach { (observer) in
                if let value = value {
                    observer(value)
                }
            }
        }
    }

    mutating func bind(_ listener: @escaping ModelEventListener) {
        listeners.append(listener)
        if let value = value {
            listener(value)
        }
    }

}
