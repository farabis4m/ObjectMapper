import Foundation
//
//  ObjectMapper+Operators.swift
//  Pods
//
//  Created by Vladislav Gorbenlo on 30/08/16.
//  Copyright © 2016 Vlad Gorbenko. All rights reserved.
//

import ObjectMapper

infix operator <-- {}

///// Object conforming to Mappable
//public func <-- <T>(inout left: T, right: Map) {
//    left <- right
//}

/// Optional Mappable objects
public func <-- <T>(inout left: T?, right: Map) {
    switch right.mappingType {
    case .FromJSON where right.isKeyPresent:
        if let l = right.currentValue as? T {
            left = l
        } else {
            left <- right
        }
    case .ToJSON:
        left <- right
    default: ()
    }
}

/// Implicitly unwrapped optional Mappable objects
public func <-- <T>(inout left: T!, right: Map) {
    switch right.mappingType {
    case .FromJSON where right.isKeyPresent:
        if let l = right.currentValue as? T {
            left = l
        } else {
            left <- right
        }
    case .ToJSON:
        left <- right
    default: ()
    }
}


/// Object of Basic type with Transform
public func <-- <Transform: TransformType>(inout left: Transform.Object, right: (Map, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .FromJSON where map.isKeyPresent:
        if let l = map.currentValue as? Transform.Object {
            left = l
        } else {
            left <- (map, transform)
        }
    case .ToJSON:
        left <- (map, transform)
    default: ()
    }
}

/// Optional object of basic type with Transform
public func <-- <Transform: TransformType>(inout left: Transform.Object?, right: (Map, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .FromJSON where map.isKeyPresent:
        if let l = map.currentValue as? Transform.Object {
            left = l
        } else {
            left <- (map, transform)
        }
    case .ToJSON:
        left <- (map, transform)
    default: ()
    }
}

/// Implicitly unwrapped optional object of basic type with Transform
public func <-- <Transform: TransformType>(inout left: Transform.Object!, right: (Map, Transform)) {
    let (map, transform) = right
    switch map.mappingType {
    case .FromJSON where map.isKeyPresent:
        if let l = map.currentValue as? Transform.Object {
            left = l
        } else {
            left <- (map, transform)
        }
        
    case .ToJSON:
        left <- (map, transform)
    default: ()
    }
}

// MARK:- Mappable Objects - <T: Mappable>

/// Object conforming to Mappable
public func <-- <T: Mappable>(inout left: T, right: Map) {
    switch right.mappingType {
    case .FromJSON:
        if let l = right.currentValue as? T {
            left = l
        } else {
            left <- right
        }
    case .ToJSON:
        left <- right
    }
}

/// Optional Mappable objects
public func <-- <T: Mappable>(inout left: T?, right: Map) {
    switch right.mappingType {
    case .FromJSON where right.isKeyPresent:
        if let l = right.currentValue as? T {
            left = l
        } else {
            left <- right
        }
    case .ToJSON:
        left <- right
    default: ()
    }
}

/// Implicitly unwrapped optional Mappable objects
public func <-- <T: Mappable>(inout left: T!, right: Map) {
    switch right.mappingType {
    case .FromJSON where right.isKeyPresent:
        if let l = right.currentValue as? T {
            left = l
        } else {
            left <- right
        }
    case .ToJSON:
        left <- right
    default: ()
    }
}

/// Array of Mappable objects
public func <-- <T: Mappable>(inout left: Array<T>, right: Map) {
    switch right.mappingType {
    case .FromJSON where right.isKeyPresent:
        if let l = right.currentValue as? [T] {
            left = l
        } else {
            left <- right
        }
    case .ToJSON:
        left <- right
    default: ()
    }
}

/// Optional array of Mappable objects
public func <-- <T: Mappable>(inout left: Array<T>?, right: Map) {
    switch right.mappingType {
    case .FromJSON where right.isKeyPresent:
        if let l = right.currentValue as? [T] {
            left = l
        } else {
            left <- right
        }
    case .ToJSON:
        left <- right
    default: ()
    }
}

/// Implicitly unwrapped Optional array of Mappable objects
public func <-- <T: Mappable>(inout left: Array<T>!, right: Map) {
    switch right.mappingType {
    case .FromJSON where right.isKeyPresent:
        if let l = right.currentValue as? [T] {
            left = l
        } else {
            left <- right
        }
    case .ToJSON:
        left <- right
    default: ()
    }
}

/// Object of Raw Representable type
public func <-- <T: RawRepresentable>(inout left: T, right: Map) {
    if let value = right.currentValue as? T {
        left = value
    } else {
        left <- (right, EnumTransform())
    }
}

/// Optional Object of Raw Representable type
public func <-- <T: RawRepresentable>(inout left: T?, right: Map) {
    if let value = right.currentValue as? T {
        left = value
    } else {
        left <- (right, EnumTransform())
    }
}

/// Implicitly Unwrapped Optional Object of Raw Representable type
public func <-- <T: RawRepresentable>(inout left: T!, right: Map) {
    if let value = right.currentValue as? T {
        left = value
    } else {
        left <- (right, EnumTransform())
    }
}


