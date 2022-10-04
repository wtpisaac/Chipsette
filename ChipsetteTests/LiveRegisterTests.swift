//
//  LiveRegisterTests.swift
//  ChipsetteTests
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import XCTest

@testable import Chipsette

final class LiveRegisterTests: XCTestCase {
    
    func test_liveRegister_canInstantiate() {
        let _ = LiveRegister<UInt8>(value: 0)
    }
    
    func test_liveRegister_canSetValue() {
        let first = LiveRegister<UInt8>(value: 0)
        
        let second = first.mutating(to: 1)
        
        XCTAssertEqual(second.value,
                       1)
    }

}
