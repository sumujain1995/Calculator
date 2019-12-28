//
//  Constants.swift
//  Calculator
//
//  Created by Sumeet  Jain on 27/12/19.
//  Copyright © 2019 Sumeet Jain. All rights reserved.
//

import UIKit

extension UILabel{
    func getLabelText() -> String{
        return self.text ?? "0"
    }
}

extension String{
    var getDouble: Double?{
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

extension Double{
    var displayString: String{
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
