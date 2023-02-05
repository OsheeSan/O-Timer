//
//  Timer.swift
//  Training-Timer
//
//  Created by admin on 05.02.2023.
//

import Foundation

class Timer {
    var rounds: Double = 1
    var timePerRound = 0.5
    var withBreak = false
    var breakTime: Double = 0.25
    
    init(rounds: Double, timePerRound: Double, withBreak: Bool, breakTime: Double) {
        self.rounds = rounds
        self.timePerRound = timePerRound
        self.withBreak = withBreak
        self.breakTime = breakTime
    }
}
