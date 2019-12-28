//
//  RoundedButton.swift
//  Calculator
//
//  Created by Sumeet  Jain on 27/12/19.
//  Copyright © 2019 Sumeet Jain. All rights reserved.
//

import UIKit

class RoundedButton: UIButton{
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.height / 2.0
//        self.addTarget(ViewController(), action: #selector(ViewController.calButtonHandler(_:)), for: .touchUpInside)
    }
}
