//
//  LiveMemoryTests.swift
//  ChipsetteTests
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import XCTest
@testable import Chipsette

final class LiveMemoryTests: XCTestCase {

    func test_liveMemory_canInitializeBlank() {
        let _: Memory = try! LiveMemory(capacity: 0,
                                         initialBytes: [],
                                         byteLoadOffset: 0)
    }
    
    func test_liveMemory_canRetrieveDataInitialized() {
        let programContents: [UInt8] = [1, 2, 3, 4]
        let capacity: UInt16 = 4
        
        let liveMemory: Memory = try! LiveMemory(capacity: capacity,
                                         initialBytes: programContents,
                                         byteLoadOffset: 0)
        
        let retrieved = try! liveMemory.getByte(at: 2)
        XCTAssertEqual(retrieved, 3)
    }
    
    func test_liveMemory_zeroesAndSetsBytesOffset() {
        let programContents: [UInt8] = [1, 2, 3, 4]
        let capacity: UInt16 = 6
        
        let liveMemory: Memory = try! LiveMemory(capacity: capacity,
                                                 initialBytes: programContents,
                                                 byteLoadOffset: 2)
        
        let shouldBeZero = try! liveMemory.getByte(at: 1)
        let shouldBeOne = try! liveMemory.getByte(at: 2)
        
        XCTAssertEqual(shouldBeZero, 0)
        XCTAssertEqual(shouldBeOne, 1)
    }
    
    func test_liveMemory_willThrowErrorIfProgramTooLarge() {
        let programContents: [UInt8] = [1, 2, 3, 4]
        let capacity: UInt16 = 3 // too small for program
        
        XCTAssertThrowsError(
            try LiveMemory(capacity: capacity,
                           initialBytes: programContents,
                           byteLoadOffset: 0)
        ) { error in
            XCTAssertEqual(error as! MemoryError,
                           .programTooLarge)
        }
    }
    
    func test_liveMemory_willThrowErrorIfProgramTruncatedByCapacity() {
        // Variation of too large, but due to offset

        let programContents: [UInt8] = [1, 2, 3, 4]
        let capacity: UInt16 = 4

        XCTAssertThrowsError(
            try LiveMemory(capacity: capacity,
                           initialBytes: programContents,
                           byteLoadOffset: 2)
        ) { error in
            XCTAssertEqual(error as! MemoryError,
                           .programTooLarge)
        }
    }
    
    func test_liveMemory_willThrowErrorIfAccessOutOfRange() {
        let programContents: [UInt8] = [1, 2, 3, 4]
        let capacity: UInt16 = 4
        let liveMemory: Memory = try! LiveMemory(capacity: capacity,
                                                 initialBytes: programContents,
                                                 byteLoadOffset: 0)
        
        XCTAssertThrowsError(
            try liveMemory.getByte(at: 4)
        ) { error in
            XCTAssertEqual(error as! MemoryError,
                           .outOfBounds)
        }
    }
    
    func test_liveMemory_givesValidMutatedCopyOnSet() {
        let programContents: [UInt8] = [1, 2, 3, 4]
        let capacity: UInt16 = 4
        let liveMemory: Memory = try! LiveMemory(capacity: capacity,
                                                 initialBytes: programContents,
                                                 byteLoadOffset: 0)
        
        let mutatedMemory = try! liveMemory.memoryMutatingByte(at: 0,
                                                               to: 5)
        
        XCTAssertEqual(try! mutatedMemory.getByte(at: 0),
                       5)
    }
    
    func test_liveMemory_givesOutOfBoundsOnInvalidMemorySet() {
        let programContents: [UInt8] = [1, 2, 3, 4]
        let capacity: UInt16 = 4
        let liveMemory: Memory = try! LiveMemory(capacity: capacity,
                                                 initialBytes: programContents,
                                                 byteLoadOffset: 0)
        
        XCTAssertThrowsError(
            try liveMemory.memoryMutatingByte(at: 4,
                                              to: 5)
        ) { error in
            XCTAssertEqual(error as! MemoryError,
                           .outOfBounds)
        }
    }

}
