//
//  Keyboard+Extension.swift
//  NotesW-Images
//
//  Created by Burak Erden on 1.03.2023.
//

import Foundation
import UIKit

extension NewItemVC {
    func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else {return}

        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        if textFieldBottomY + 50 > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = ((textBoxY - keyboardTopY / 2) - 60) * -1
            view.frame.origin.y = newFrameY
        }
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
    }
}

extension UIResponder {
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    static func currentFirst() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    @objc func _trap() {
        Static.responder = self
    }
}
