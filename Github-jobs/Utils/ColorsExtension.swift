//
//  ColorsExtension.swift
//  Github-jobs
//
//  Created by Alisena Mudaber on 10/31/20.
//

import Foundation
import UIKit


extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let oxfordBlue = UIColor.rgb(red: 10, green: 34, blue: 57)
    static let blueNSC = UIColor.rgb(red: 29 , green: 132, blue: 181)
    static let maximumBlue = UIColor.rgb(red: 83, green: 162, blue: 190)
    static let outerSpaceCrayola = UIColor.rgb(red: 19 , green: 46, blue: 50)
    static let laurelGreen = UIColor.rgb(red: 186, green: 205, blue: 176)
    static let deepSpaceSparkle = UIColor.rgb(red: 71, green: 91, blue: 99)
}
