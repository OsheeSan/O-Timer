//
//  TimerManager.swift
//  Training-Timer
//
//  Created by admin on 05.02.2023.
//

import Foundation


class TimerManager {
    var rounds: Int
    var timePerRound: Int
    var withBreak: Bool
    var breakTime: Int
    
    init(rounds: Int, timePerRound: Int, withBreak: Bool, breakTime: Int) {
        self.rounds = rounds
        self.timePerRound = timePerRound
        self.withBreak = withBreak
        self.breakTime = breakTime
    }
    
    init(){
        self.rounds = 1
        self.timePerRound = 15
        self.withBreak = false
        self.breakTime = 10
    }
}
