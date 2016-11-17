//
//  ObjectTransform.swift
//  ObjectMapper
//
//  Created by Vlad Gorbenko on 9/25/16.
//  Copyright © 2016 hearst. All rights reserved.
//

import Foundation

open class ObjectTransform<ObjectType> {
	public typealias Object = ObjectType
	
	public typealias Transformation = ((_ object: Object, _ map: Map) -> Void)
	public typealias Validation = ((_ data: [String: Any]) -> Bool)
	
	open var validation: Validation? = { (data) in
		return true
	}
	
	fileprivate let from: Transformation?
	fileprivate let to: Transformation?
	
	public init(from: Transformation?, to: Transformation?) {
		self.from = from
		self.to = to
	}
	
	public init(_ bidirectional: Transformation?) {
		self.from = bidirectional
		self.to = bidirectional
	}
	
    @discardableResult
	open func transformFrom(_ map: Map, object: Object) -> ObjectType? {
		self.from?(object, map)
        return object
	}
    
	@discardableResult
    open func transformTo(_ map: Map, object: Object) -> [String: Any] {
		self.to?(object, map)
        return map.JSONDictionary
	}
	
	open func validate(_ validation: @escaping Validation) -> ObjectTransform<ObjectType> {
		self.validation = validation
		return self
	}
}
