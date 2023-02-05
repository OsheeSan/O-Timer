//
//  BreakView.swift
//  Training-Timer
//
//  Created by admin on 05.02.2023.
//

import UIKit

@IBDesignable
class BreakView: UIView {
    
    override func prepareForInterfaceBuilder() {
        setup()
    }

    override func awakeFromNib() {
        setup()
    }
    
    func setup(){
        self.transform = CGAffineTransform(translationX: 0, y: 110)
        self.backgroundColor = .black
        self.viewWithTag(1)?.backgroundColor = UIColor(named: "MainColor")
        let BreakLabel = self.self.viewWithTag(2) as? UILabel
        BreakLabel?.textColor = UIColor(named: "RevertLabel")
        self.layer.cornerRadius = 20
    }
    
    
}
