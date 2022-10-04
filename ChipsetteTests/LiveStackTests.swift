//
//  LiveStackTests.swift
//  ChipsetteTests
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import XCTest

@testable import Chipsette

final class LiveStackTests: XCTestCase {
    
    func test_liveStack_canInitialize() {
        let _ = LiveStack(entries: 1)
    }
    
    func test_liveStack_canPushAndPop() {
        let address: UInt16 = 256
        let sut: Stack = LiveStack(entries: 1)
        
        let pushed = try! sut.stackPushing(address: address)
        let (retrieved, _) = try! pushed.stackPopping()
        
        XCTAssertEqual(retrieved, address)
    }
    
    func test_liveStack_poppingRemovesElementFromReturnedStack() {
        let addressOne: UInt16 = 256
        let addressTwo: UInt16 = 512
        let sut: Stack = LiveStack(entries: 2)
        
        let pushedStack = try! sut.stackPushing(address: addressOne)
                                  .stackPushing(address: addressTwo)
        
        let (firstRetrieved, poppedStack) = try! pushedStack.stackPopping()
        let (secondRetrieved, _) = try! poppedStack.stackPopping()
        
        XCTAssertEqual(firstRetrieved, addressTwo)
        XCTAssertEqual(secondRetrieved, addressOne)
    }
    
    func test_liveStack_willOverflowOnPushesPastEntries() {
        let address: UInt16 = 256
        let sut: Stack = LiveStack(entries: 0)
        
        XCTAssertThrowsError(
            try sut.stackPushing(address: address)
        ) { error in
            XCTAssertEqual(error as! StackError,
                           .overflow)
        }
    }
    
    func test_liveStack_willUnderflowWhenNoEntries() {
        let sut: Stack = LiveStack(entries: 0)
        
        XCTAssertThrowsError(
            try sut.stackPopping()
        ) { error in
            XCTAssertEqual(error as! StackError,
                           .underflow)
        }
    }

}
