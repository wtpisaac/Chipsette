//
//  LiveSpriteTests.swift
//  ChipsetteTests
//
//  Created by Isaac Trimble-Pederson on 10/6/22.
//

import XCTest

@testable import Chipsette

final class LiveSpriteTests: XCTestCase {

    func test_LiveSprite_correctlyInstantiatesWithBytes() {
        let zeroFontSpriteData: [UInt8] = [0xF0, 0x90, 0x90, 0x90, 0xF0]
        let sut = try! LiveSprite(bytes: zeroFontSpriteData)
        
        XCTAssertEqual(sut.bytes, zeroFontSpriteData)
    }
    
    func test_LiveSprite_rejectsTooFewBytes() {
        XCTAssertThrowsError(
            try LiveSprite(bytes: [0x0])
        ) { error in
            XCTAssertEqual(error as! SpriteErrors,
                           .invalidByteFormat)
        }
    }
    
    func test_LiveSprite_rejectsTooManyBytes() {
        XCTAssertThrowsError(
            try LiveSprite(bytes: [0x0, 0x1, 0x2, 0x3, 0x4, 0x5])
        ) { error in
            XCTAssertEqual(error as! SpriteErrors,
                           .invalidByteFormat)
        }
    }

}
