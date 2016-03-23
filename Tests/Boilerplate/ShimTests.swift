//
//  ShimTests.swift
//  Boilerplate
//
//  Created by Daniel Leping on 23/03/2016.
//  Copyright © 2016 Crossroad Labs, LTD. All rights reserved.
//

import XCTest
import Foundation
import Result

@testable import Boilerplate

class ShimTests: XCTestCase {
    func testSequenseJoin() {
        let joined = ["a", "b"].joined(separator: "|")
        
        XCTAssertEqual("a|b", joined)
    }
    
    func testAdvancedBy() {
        let array = ["a", "b", "c"]
        
        let start = array.startIndex
        let one = start.advanced(by: 1)
        let two = start.advanced(by: 2)
        let twoWithLimit = start.advanced(by:3, limit: 2)
        
        XCTAssertEqual(one, 1)
        XCTAssertEqual(two, 2)
        XCTAssertEqual(twoWithLimit, two)
        
        let string = "string"
        
        let withLimit = string.startIndex.advanced(by:10, limit: string.endIndex)
        XCTAssertEqual(withLimit, string.endIndex)
    }
    
    func testArrayMutation() {
        var array = ["a", "b", "c"]
        
        array.append(contentsOf: ["e"])
        
        XCTAssertEqual(array, ["a", "b", "c", "e"])
        
        array.insert("d", atIndex: 3)
        
        XCTAssertEqual(array, ["a", "b", "c", "d", "e"])
        
        array.remove(at: 2)
        
        XCTAssertEqual(array, ["a", "b", "d", "e"])
        
        let capacity = array.capacity
        var array2 = array
        let capacity2 = array2.capacity
        
        array.removeAll(keepingCapacity: true)
        array2.removeAll(keepingCapacity: false)
        
        XCTAssertEqual(array, array2)
        XCTAssertEqual(array, [])
        
        XCTAssertEqual(array.capacity, capacity)
        XCTAssertNotEqual(array2.capacity, capacity2)
    }
    
    func testCollectionPrefixes() {
        let array = ["a", "b", "b", "c"]
        
        XCTAssertEqual(array.prefix(upTo: 1), ["a"])
        XCTAssertEqual(array.prefix(through: 1), ["a", "b"])
        XCTAssertEqual(array.suffix(from: 2), ["b", "c"])
        
        let defaultSplit = array.split { element in
            element == "b"
        }
        
        let ommitingSplit = array.split(omittingEmptySubsequences: true) { element in
            element == "b"
        }
        
        let withEmptySplit = array.split(omittingEmptySubsequences: false) { element in
            element == "b"
        }
        
        let limitedSplit = array.split(maxSplits: 0, omittingEmptySubsequences: true) { element in
            element == "b"
        }
        
        XCTAssertEqual(defaultSplit.count, 2)
        XCTAssertEqual(ommitingSplit.count, 2)
        XCTAssertEqual(withEmptySplit.count, 3)
        XCTAssertEqual(limitedSplit.count, 1)
    }
    
    func testStringCase() {
        let hello = "Hello"
        
        XCTAssertEqual(hello.uppercased(), "HELLO")
        XCTAssertEqual(hello.lowercased(), "hello")
    }
}