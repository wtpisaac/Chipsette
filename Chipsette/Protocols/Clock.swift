//
//  Clock.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import Foundation

protocol Clock {
    func start(using: any SomeTimer.Type,
               pulsesPerSecond: UInt)
    func stop()
    
    func pulse() throws
    
    func register(method: @escaping () throws -> Void)
    
    init(errorHandler: ErrorHandler)
}
