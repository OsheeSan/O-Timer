//
//  Functions.swift
//  TestProject
//
//  Created by admin on 26.01.2023.
//

import Foundation

func timeToString(_ timeInt : Int) -> String{
    var time: String {
        var minutes: Int = timeInt / 60
        var res = ""
        if minutes < 10 {
            res = "0\(minutes):"
        } else {
            res = "\(minutes):"
        }
        if timeInt - minutes*60 < 10 {
            res += "0\(timeInt - minutes*60)"
        } else {
            res += "\(timeInt - minutes*60)"
        }
        return res
    }
    return time
}
