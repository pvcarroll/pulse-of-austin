//
//  UITextView+Extension.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 6/10/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

extension UITextView {
    
    func setHTMLAsAttributedString(htmlString: String) {
        do {
            let attributedString = try NSAttributedString(data: htmlString.data(using: String.Encoding.unicode,
                                                                                allowLossyConversion: true)!,
                                                          options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            self.attributedText = attributedString
        } catch {
            print("Error converting html to attributed string: \(error)")
        }
        
    }
}
