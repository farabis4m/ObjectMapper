//
//  ExternalMappingTests.swift
//  ObjectMapper
//
//  Created by Vlad Gorbenko on 9/25/16.
//  Copyright © 2016 hearst. All rights reserved.
//

import Foundation
import XCTest
import ObjectMapper

let userMapper = ObjectTransform<User1>( {
	$0.firstName <- $1["first_name"]
	$0.lastName <- $1["last_name"]
})

class User1: Mappable {

	var firstName: String!
	var lastName: String!
	
	required init() {}
}

//extension User1: CustomStringConvertible {
//	var description: String { return "\(self.firstName) \(self.lastName)" }
//}

extension User1 {
	static var defaultMapping: ObjectTransform<User1> { return userMapper }
}

class ExternalMappingTests: XCTestCase {
	
	func testExternalTransform() {
		print(User1.defaultMapping)
		print(User1.defaultMapping)
		let json: [String: Any] = ["first_name" : "Vlad", "last_name" : "Gorbenko"]
		let user = User1(JSON: json, transform: userMapper)
		print(user)
		print("The end")
	}
}
