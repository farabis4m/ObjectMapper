//
//  JSONParser.swift
//  ObjectMapper
//
//  Created by Vlad Gorbenko on 8/23/16.
//  Copyright © 2016 hearst. All rights reserved.
//

import Foundation

open class JSONParser {
	
	fileprivate var view: String.UnicodeScalarView
	fileprivate var index: String.UnicodeScalarView.Index
	/**
	NOTE: UnicodeScalars increase the performance compared to Characters
	*/
	var next: (Void) -> UnicodeScalar?
	
	public init(_ string: String) {
		self.view = string.unicodeScalars
		self.index = self.view.startIndex
        let view = self.view
        var index = self.index
		next = {
			if index == view.endIndex { return nil }
			let scalar = view[index]
			index = view.index(after: index)
			return scalar
		}
		
	}
	
	func checkType(_ str: String)->Any{
		switch str {
		case "true": return true
		case "false": return false
		case "null": return ()
		default:
			if let num = Int(str) {
				return num
			}
			if let num = Double(str) {
				return num
			}
			return str
		}
	}
	
	open func parse() -> Any? {
		let scalar = self.view[self.index]
		if scalar == "{" {
			return self.parseObject()
		}
		return self.parseArray()
	}
	
	
	/**
	Parse an Object
	*/
	open func parseObject()->[String: Any]{
		
		var output = [String: Any]()
		var buffer = String.UnicodeScalarView()
		var key = String.UnicodeScalarView()
		var inString = false
		
		while let scalar = next(){
			
			
			if scalar == "\""{
				
				if inString{
					if key.isEmpty{
						key = buffer
					}else{
						output[String(key)] = String(buffer)
					}
					buffer = String.UnicodeScalarView()
				}
				
				inString = !inString
				continue
			}
			
			if inString{
				buffer.append(scalar)
				continue
			}
			
			
			if scalar == ":"{
				if !buffer.isEmpty{
					key = buffer
					buffer = String.UnicodeScalarView()
				}
				continue
			}
			
			if scalar == ","{
				if !(buffer.isEmpty || key.isEmpty) {
					output[String(key)] = checkType(String(buffer))
					
				}
				buffer = String.UnicodeScalarView()
				key = String.UnicodeScalarView()
				continue
			}
			if (scalar == " ") ||  (scalar == "\n") || (scalar == "\t") { continue }
			
			if scalar == "{" {
				output[String(key)] = parseObject()
				buffer = String.UnicodeScalarView()
				continue
			}
			
			if scalar == "[" {
				if !key.isEmpty{
					output[String(key)] = parseArray()
					buffer = String.UnicodeScalarView()
				}
				continue
			}
			
			if scalar == "}"{
				if !(buffer.isEmpty || key.isEmpty) {
					output[String(key)] = checkType(String(buffer))
				}
				return output
			}
			
			buffer.append(scalar)
			
		}
		
        if output.keys.count == 1 && output.keys.first == "" {
            return (output[""] as? [String: Any]) ?? [:]
        }
		return output
	}
	
	
	/**
	Parse an Array
	*/
    open func parseArray() -> [[String: Any]] {
        var output = [[String: Any]]()
        var omits: [String.UnicodeScalarView] = [",".unicodeScalars, "\n".unicodeScalars, "\t".unicodeScalars, " ".unicodeScalars]
        let comma = ",".unicodeScalars[",".unicodeScalars.startIndex]
        let space = " ".unicodeScalars[" ".unicodeScalars.startIndex]
        let newLine = "\n".unicodeScalars["\n".unicodeScalars.startIndex]
        let tab = "\t".unicodeScalars["\t".unicodeScalars.startIndex]
		while let scalar = next() {
            if scalar == comma { continue }
			if scalar == "{" {
				output.append(parseObject())
				continue
			}
            if scalar == space || scalar == newLine || scalar == tab { continue }
            if scalar == "]" {
                return output
            }
		}
		return output
	}
	
}
