//
//  WeighInElaborate.swift
//  PulseOfAustin
//
//  Created by Paul Carroll on 5/5/18.
//  Copyright © 2018 Paul Carroll. All rights reserved.
//

import UIKit

class WeighInElaborate: UIView, UITextViewDelegate {
    
    @IBOutlet var cardTitle: UILabel!
    @IBOutlet var selectedAnswerButton: UIButton!
    @IBOutlet var weighInTextView: UITextView!
    @IBOutlet var submitButton: UIButton!
    
    var response = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        self.cardTitle.font = UIFont.cardTitle
        self.cardTitle.textColor = UIColor.darkGray74
        
        self.selectedAnswerButton.backgroundColor = UIColor.infoCardBackground
        self.selectedAnswerButton.titleLabel?.font = UIFont.buttonFont
        self.selectedAnswerButton.setTitleColor(UIColor.darkGray74, for: .normal)
        self.selectedAnswerButton.layer.cornerRadius = 5
        
        self.weighInTextView.delegate = self
        self.weighInTextView.text = "Have more to share on why you made your selection?"
        self.weighInTextView.textColor = UIColor.infoCardBackground
        self.weighInTextView.layer.borderColor = UIColor.darkGray74.cgColor
        self.weighInTextView.layer.borderWidth = 0.5
        
        self.submitButton.backgroundColor = UIColor.customYellow
        self.submitButton.setTitle("SUBMIT", for: .normal)
        self.submitButton.titleLabel?.font = UIFont.buttonFont
        self.submitButton.setTitleColor(UIColor.whiteText, for: .normal)
        self.submitButton.layer.cornerRadius = self.submitButton.frame.height / 2
    }
    
    //
    // MARK: Private methods
    //
    
    @objc private func dismissKeyboard() {
        self.weighInTextView.endEditing(true)
    }
    
    //
    // MARK:- UITextViewDelegate
    //
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.weighInTextView.text = nil
        self.weighInTextView.textColor = UIColor.darkGray74
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            self.response = textView.text
            self.submitButton.isUserInteractionEnabled = true
        } else {
            self.submitButton.isUserInteractionEnabled = false
        }
    }
}
