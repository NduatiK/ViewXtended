//
//  WrappedData.swift
//  TH2G
//
//  Created by Nduati Kuria on 29/12/2018.
//  Copyright © 2018 nduatiKuria. All rights reserved.
//

import Foundation

public protocol Wrapped: class {
    associatedtype T
    var _data: T? { get set }
    var data: T { get }
    var recalulateClosure: () -> T { get }
    init(recalulateClosure: @escaping () -> T)
}

public extension Wrapped {
    public var data: T {
        if let data = _data {
            return data
        } else {
            let data = recalculateData()
            _data = data
            return data
        }
    }

    public func recalculateData() -> T {
        return recalulateClosure()
    }
    
    public func clearData() {
        _data = nil
    }
}

public class WrappedArray<Element>: WrappedObject<Array<Element>> {}

public class WrappedObject<ObjectType>: Wrapped {
    public var _data: ObjectType?

    public var recalulateClosure: () -> ObjectType

    public typealias T = ObjectType
    required public init(recalulateClosure: @escaping () -> ObjectType) {
        self.recalulateClosure = recalulateClosure
    }
}
