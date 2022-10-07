//
//  LiveClockTests.swift
//  ChipsetteTests
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import XCTest

@testable import Chipsette

final class LiveClockTests: XCTestCase {
    class MockTimer: SomeTimer {
        static var lastInstantiatedTimer: MockTimer?
        
        var timeInterval: TimeInterval
        var repeats: Bool
        var block: (@Sendable (LiveClockTests.MockTimer) -> Void)
        
        var valid: Bool = true
        
        static func scheduledTimer(withTimeInterval: TimeInterval, repeats: Bool, block: @escaping @Sendable (LiveClockTests.MockTimer) -> Void) -> LiveClockTests.MockTimer {
            let mockTimer = MockTimer(timeInterval: withTimeInterval,
                                      repeats: repeats,
                                      block: block)
            
            return mockTimer
        }
        
        func invalidate() {
            valid = false
        }
        
        init(timeInterval: TimeInterval,
             repeats: Bool,
             block: @escaping @Sendable (LiveClockTests.MockTimer) -> Void) {
            self.timeInterval = timeInterval
            self.repeats = repeats
            self.block = block
            
            Self.lastInstantiatedTimer = self
        }
    }
    
    class MockErrorHandler: ErrorHandler {
        var handledErrors: [Error] = []
        
        func handle(_ error: Error) {
            handledErrors.append(error)
        }
    }
    
    enum MockError: Error {
        case methodThrew
    }
    
    override func tearDown() {
        MockTimer.lastInstantiatedTimer = nil
    }

    func test_LiveClock_canInstantiate() {
        let handler = MockErrorHandler()
        let _ = LiveClock(errorHandler: handler)
    }
    
    func test_LiveClock_canRegisterAndPulseMethod() {
        let handler = MockErrorHandler()
        let sut = LiveClock(errorHandler: handler)
        var called = false
        
        sut.register {
            called = true
        }
        
        try! sut.pulse()
        
        XCTAssertTrue(called)
    }
    
    func test_LiveClock_pulsesMultipleMethods() {
        let handler = MockErrorHandler()
        let sut = LiveClock(errorHandler: handler)
        var firstCalled = false
        var secondCalled = false
        
        sut.register {
            firstCalled = true
        }
        
        sut.register {
            secondCalled = true
        }
        
        try! sut.pulse()
        
        XCTAssertTrue(firstCalled)
        XCTAssertTrue(secondCalled)
    }
    
    func test_LiveClock_instantiatesTimerCorrectly() {
        let handler = MockErrorHandler()
        let sut = LiveClock(errorHandler: handler)
        
        sut.start(using: MockTimer.self,
                  pulsesPerSecond: 1000)
        
        let configuredTimer = MockTimer.lastInstantiatedTimer!
        
        XCTAssertEqual(configuredTimer.timeInterval, 0.06, accuracy: 0.001)
        XCTAssertTrue(configuredTimer.repeats)
    }
    
    func test_LiveClock_schedulesPulsesOnTimer() {
        let handler = MockErrorHandler()
        let sut = LiveClock(errorHandler: handler)
        var pulseCalled = false
        
        sut.register {
            pulseCalled = true
        }
        
        // Test
        sut.start(using: MockTimer.self,
                  pulsesPerSecond: 1000)
        
        let instantiatedTimer = MockTimer.lastInstantiatedTimer!
        // Manually execute the timer block to see if it's wired up correctly
        instantiatedTimer.block(instantiatedTimer)
        
        XCTAssertTrue(pulseCalled)
    }
    
    func test_LiveClock_errorThrowingCallForwardsToHandler() {
        let handler = MockErrorHandler()
        let sut = LiveClock(errorHandler: handler)
        
        sut.register {
            throw MockError.methodThrew
        }
        
        sut.start(using: MockTimer.self,
                  pulsesPerSecond: 1000)
        
        // Execute indirectly via timer block
        let instantiatedTimer = MockTimer.lastInstantiatedTimer!
        instantiatedTimer.block(instantiatedTimer)
        
        let error = handler.handledErrors.first!
        XCTAssertEqual(error as! MockError,
                       .methodThrew)
    }

}
