//
//  LiveKeypadTests.swift
//  ChipsetteTests
//
//  Created by Isaac Trimble-Pederson on 10/6/22.
//

import XCTest

@testable import Chipsette

final class LiveKeypadTests: XCTestCase {
    class MockKeypadInputHandler: KeypadInputHandler {
        var lastPressedKey: Key?
        
        func keyWasPressed(_ key: Key) {
            lastPressedKey = key
        }
    }

    func test_LiveKeypad_canInstantiate() {
        let _ = LiveKeypad()
    }

    func test_LiveKeypad_whenKeyPressedNotifiesHandler() {
        let handler = MockKeypadInputHandler()
        let sut = LiveKeypad()
        sut.registerHandler(handler)
        
        sut.keyPressed(.n0)
        
        XCTAssertEqual(handler.lastPressedKey,
                       .n0)
    }
}
