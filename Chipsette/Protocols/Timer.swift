//
//  Timer.swift
//  Chipsette
//
//  Created by Isaac Trimble-Pederson on 10/4/22.
//

import Foundation

protocol SomeTimer {
    associatedtype TimerType = Self where TimerType:SomeTimer
    
    static func scheduledTimer(withTimeInterval: TimeInterval,
                               repeats: Bool,
                               block: @escaping @Sendable (TimerType) -> Void) -> TimerType
    
    func invalidate()
}

extension Timer: SomeTimer {}
