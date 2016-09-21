//
//  Mapilizer.swift
//  Pods
//
//  Created by Vlad Gorbenko on 8/28/16.
//
//

import Foundation

public protocol Mapilizer {
    associatedtype Object
    associatedtype ObjectMap
    
    func mapFromMap(value: ObjectMap) -> Object?
    func mapToMap(value: ObjectMap) -> ObjectMap?
}

public class MapOf<ObjectType: Mappable>: Mapilizer {
    public typealias Object = ObjectType
    public typealias ObjectMap = Map
    
    private var fromJSON: (ObjectMap, Object) -> Void
    private var toJSON: ((ObjectMap, Object) -> Void)?
    var object: Object!
    
    public init(fromJSON: @escaping (ObjectMap, Object) -> Void, toJSON: @escaping (ObjectMap, Object) -> Void) {
        self.fromJSON = fromJSON
        self.toJSON = toJSON
    }
    
    public init(block: @escaping (ObjectMap, Object) -> Void) {
        self.fromJSON = block
        self.toJSON = { [unowned self] (map, object) in
            self.fromJSON(map, object)
        }
    }
    
    public func mapFromMap(value: Map) -> Object? {
        self.fromJSON(value, self.object)
        return object
    }
    
    public func mapToMap(value: ObjectMap) -> ObjectMap? {
        self.toJSON?(value, self.object)
        return value
    }
}
