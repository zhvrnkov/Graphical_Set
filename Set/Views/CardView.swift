//
//  CardView.swift
//  Set
//
//  Created by Vladislav Zhavoronkov on 24/07/2018.
//  Copyright © 2018 Vladislav Zhavoronkov. All rights reserved.
//

import UIKit

class CardView: UIButton {
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
        UIColor.red.setFill()
        roundedRect.fill()
    }

    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
////        backgroundColor = UIColor.red
//    }

}
