//
//  NSMutableAttributedString+Extension.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 7/1/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit
import Foundation

extension NSMutableAttributedString {
    
    func addUnderline() {
        let underlineAttr: [NSAttributedStringKey: Any] = [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue]
        self.addAttributes(underlineAttr, range: NSRange(location: 0, length: self.length))
    }
}
