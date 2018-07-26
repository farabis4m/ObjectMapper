//
//  Mappable.swift
//  ObjectMapper
//
//  Created by Scott Hoyt on 10/25/15.
//  Copyright © 2015 hearst. All rights reserved.
//

import Foundation

public protocol Mappable {
	init()
    
    func mapping(map: Map)
}

public extension Mappable {
    func mapping(map: Map) {}
}

public extension Mappable {
    static var mapping: ObjectTransform<Self>? {
        return ObjectTransform({ $0.mapping(map: $1) })
	}
}

public extension Mappable {
    func toJSON(transform: ObjectTransform<Self>? = nil) -> [String: Any] {
		let map = Map(mappingType: .toJSON, JSON: [:])
        return (transform ?? type(of: self).mapping)?.transformTo(map, object: self) ?? [:]
	}
	func fromJSON(transform: ObjectTransform<Self>) -> Self? {
		let map = Map(mappingType: .fromJSON, JSON: [:])
        return (transform ?? type(of: self).mapping)?.transformFrom(map, object: self)
	}
}

public protocol StaticMappable: Mappable {
	/// This is function that can be used to:
	///		1) provide an existing cached object to be used for mapping
	///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
	static func objectForMapping(_ map: Map) -> Mappable?
}

public extension Mappable {
	
	init(with attributes: [String: Any]) {
        self.init()
		self.mapping(map: Map(mappingType: .fromJSON, JSON: attributes))
    }

    init(attributes: [String: Any]) {
        self.init()
        self.update(attributes: attributes)
    }
    
    func update(attributes: [String: Any], transform: ObjectTransform<Self>? = nil) {
		let map = Map(mappingType: .fromJSON, JSON: attributes)
        (transform ?? type(of: self).mapping)?.transformFrom(map, object: self)
    }
    
	/// Initializes object from a JSON String
	public init?(JSONString: String) {
//		if let obj: Self = Mapper().map(JSONString) {
//			self = obj
//		} else {
			return nil
//		}
	}
	
	/// Initializes object from a JSON Dictionary
	public init?(JSON: [String : Any], transform: ObjectTransform<Self>) {
		if let validate = transform.validation, validate(JSON) == false {
			return nil
		}
		if let obj: Self = Mapper(transform: transform).map(JSON) {
			self = obj
		} else {
			return nil
		}
	}
	
	/// Returns the JSON Dictionary for the object
//	public func toJSON() -> [String: Any] {
//		return [:]
////		return Mapper().toJSON(self)
//	}
	
//	/// Returns the JSON String for the object
//	public func toJSONString(prettyPrint: Bool = false) -> String? {
//		return Mapper().toJSONString(self, prettyPrint: prettyPrint)
//	}
    
}

public extension Array where Element: Mappable {
	
	/// Initialize Array from a JSON String
	public init?(JSONString: String) {
//		if let obj: [Element] = Mapper().mapArray(JSONString) {
//			self = obj
//		} else {
			return nil
//		}
	}
	
	/// Initialize Array from a JSON Array
	public init?(JSONArray: [[String : Any]]) {
//		if let obj: [Element] = Mapper().mapArray(JSONArray) {
//			self = obj
//		} else {
			return nil
//		}
	}
	
	/// Returns the JSON Array
	public func toJSON() -> [[String : Any]] {
		return []
//        return Mapper().toJSONArray(self)
	}
	
//	/// Returns the JSON String for the object
//	public func toJSONString(prettyPrint: Bool = false) -> String? {
//		return Mapper().toJSONString(self, prettyPrint: prettyPrint)
//	}
}

//public extension Set where Element: Mappable {
//	
//	/// Initializes a set from a JSON String
//	public init?(JSONString: String) {
//		if let obj: Set<Element> = Mapper().mapSet(JSONString) {
//			self = obj
//		} else {
//			return nil
//		}
//	}
//	
//	/// Initializes a set from JSON
//	public init?(JSONArray: [[String : Any]]) {
//		if let obj: Set<Element> = Mapper().mapSet(JSONArray) {
//			self = obj
//		} else {
//			return nil
//		}
//	}
//	
//	/// Returns the JSON Set
//	public func toJSON() -> [[String : Any]] {
//        return Mapper().toJSONSet(self)
//	}
//	
////	/// Returns the JSON String for the object
////	public func toJSONString(prettyPrint: Bool = false) -> String? {
////		return Mapper().toJSONString(self, prettyPrint: prettyPrint)
////	}
//}
