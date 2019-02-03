//
//  UIFont+Extension.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 4/21/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

extension UIFont {
    class var screenTitle: UIFont {
        let screenTitleFont = UIFont(name: "Futura-Bold", size: 34.0)
        guard let font = screenTitleFont else { return systemFont(ofSize: 34.0, weight: .bold) }
        return font
    }
    class var futuraBold26: UIFont {
        let font = UIFont(name: "Futura-Bold", size: 26.0)
        guard let font2 = font else { return systemFont(ofSize: 26.0, weight: .bold) }
        return font2
    }
    class var futuraBold13: UIFont {
        let font = UIFont(name: "Futura-Bold", size: 13.0)
        guard let font2 = font else { return systemFont(ofSize: 13.0, weight: .bold) }
        return font2
    }
    class var cardTitle: UIFont {
        let cardTitleFont = UIFont(name: "Futura-Bold", size: 16.0)
        guard let font = cardTitleFont else { return systemFont(ofSize: 16.0, weight: .bold) }
        return font
    }
    class var introCardBody: UIFont {
        let cardTitleFont = UIFont(name: "Futura-Medium", size: 16.0)
        guard let font = cardTitleFont else { return systemFont(ofSize: 16.0, weight: .medium) }
        return font
    }
    class var introCardBodyBold: UIFont {
        let cardTitleFont = UIFont(name: "Futura-Bold", size: 16.0)
        guard let font = cardTitleFont else { return systemFont(ofSize: 16.0, weight: .bold) }
        return font
    }
    class var futura20: UIFont {
        let font = UIFont(name: "Futura", size: 20.0)
        guard let font2 = font else { return systemFont(ofSize: 20.0, weight: .regular) }
        return font2
    }
    class var futuraMedium20: UIFont {
        let font = UIFont(name: "Futura-Medium", size: 20.0)
        guard let font2 = font else { return systemFont(ofSize: 20.0, weight: .medium) }
        return font2
    }
    class var futura16: UIFont {
        let font = UIFont(name: "Futura", size: 16.0)
        guard let font2 = font else { return systemFont(ofSize: 16.0, weight: .regular) }
        return font2
    }
    class var futura13: UIFont {
        let font = UIFont(name: "Futura", size: 13.0)
        guard let font2 = font else { return systemFont(ofSize: 13.0, weight: .medium) }
        return font2
    }
    class var buttonFont: UIFont {
        let buttonText = UIFont(name: "Macho-Bold", size: 16.0)
        guard let font = buttonText else { return systemFont(ofSize: 16.0, weight: .bold) }
        return font
    }
}
