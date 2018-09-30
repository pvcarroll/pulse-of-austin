//
//  AuthUtils.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 9/29/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthUtils {
    
    static func sendPasswordReset(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            print("Send password reset error: \(String(describing: error))")
        }
    }
}
