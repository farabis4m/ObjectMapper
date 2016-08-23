//
//  DictionaryTransform.swift
//  ObjectMapper
//
//  Created by Milen Halachev on 7/20/16.
//  Copyright © 2016 hearst. All rights reserved.
//

import Foundation

public struct DictionaryTransform<Key, Value where Key: Hashable, Key: RawRepresentable, Key.RawValue == String, Value: Mappable>: TransformType {
	
	public init() {}
	
	public func transformFromJSON(value: Any?) -> [Key: Value]? {
		guard let json = value as? [String: Any] else {
			return nil
		}
		let result = json.reduce([:]) { (result, element) -> [Key: Value] in
			guard
			let key = Key(rawValue: element.0),
			let valueJSON = element.1 as? [String: Any],
			let value = Value(JSON: valueJSON)
			else {
				return result
			}
			var result = result
			result[key] = value
			return result
		}
		return result
	}
	
	public func transformToJSON(value: [Key: Value]?) -> [String: Any]? {
		let result = value?.reduce([:]) { (result, element) -> [String: Any] in
			let key = element.0.rawValue
			let value = element.1.toJSON()
			var result = result
			result[key] = value
			return result
		}
		return result
	}
}