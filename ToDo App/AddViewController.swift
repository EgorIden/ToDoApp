//
//  ViewController.swift
//  ToDo App
//
//  Created by Egor on 02.02.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit
import CoreData

protocol AddViewControllerDelegate {
    func saveNote(text: String)
}

class AddViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var delegate: AddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(with:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        textView.becomeFirstResponder()
        
    }
    
    @objc func keyboardWillShow(with notification: Notification){
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        bottomConstraint.constant = keyboardHeight
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func done(_ sender: Any) {
        guard let text = textView.text else {
            return
        }
        delegate?.saveNote(text: text)
        dismiss(animated: true)
        textView.resignFirstResponder()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
        textView.resignFirstResponder()
    }
}

