//
//  LiveClock.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import Foundation

typealias Callable = () throws -> Void

class LiveClock: Clock {
    private let errorHandler: ErrorHandler
    private var registeredMethods: Array<Callable> = []
    private var associatedTimer: (any SomeTimer)?
    
    func start(using timer: any SomeTimer.Type,
               pulsesPerSecond: UInt) {
        let pulseInterval = 60.0 / Double(pulsesPerSecond)

        self.associatedTimer =
            timer
            .scheduledTimer(withTimeInterval: pulseInterval,
                            repeats: true,
                            block: { _ in
                do {
                    try self.pulse()
                } catch {
                    self.errorHandler.handle(error)
                }
        })
        return
    }
    
    func stop() {
        return
    }
    
    func pulse() throws {
        try registeredMethods.forEach { method in
            try method()
        }
    }
    
    func register(method: @escaping () throws -> Void) {
        registeredMethods.append(method)
    }
    
    required init(errorHandler: ErrorHandler) {
        // FIXME: Should the error handler be in init, or should this be optional and set deferred?
        // Throwing the errors somewhere isn't critical and can be ignored
        // TODO: For consistency's sake this should probably be made optional
        self.errorHandler = errorHandler
    }
}
