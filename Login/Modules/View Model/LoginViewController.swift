//
//  LoginViewController.swift
//  Login
//
//  Created by Jelle Vandebeeck on 04/07/16.
//  Copyright © 2016 iCapps. All rights reserved.
//

import UIKit

import Stella
import Delirium

class LoginViewController: UIViewController {
    
    // MARK: - Internals
    
    private let correctPassword = "awesome"
    private var language = Language.en
    
    // MARK: - Outlets
    
    @IBOutlet var languageButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var button: UIButton!
    
    // MARK: - View flow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabels()
    }
    
    // MARK: - Actions
    
    @IBAction func verifyPassword(sender: AnyObject) {
        printAction("Tapped verify password")
        
        verify(password: textField.text)
    }
    
    @IBAction func toggleLanguage(sender: AnyObject) {
        printAction("Tapped language toggle")
        
        toggleLanguage()
    }
    
}

extension LoginViewController {
    
    // MARK: - UI
    
    private func toggle(interaction interaction: Bool) {
        if interaction {
            activityIndicatorView.stopAnimating()
        } else {
            activityIndicatorView.startAnimating()
        }
        button.hidden = !interaction
        textField.enabled = interaction
    }
    
}

extension LoginViewController {
    
    private enum Language: String {
        case nl = "nl"
        case en = "en"
    }
    
    // MARK: - Language
    
    private func toggleLanguage() {
        // Toggle the other language.
        language = language == .en ? .nl : .en
        
        updateLabels()
    }
    
    private func updateLabels() {
        let bundlePath = NSBundle.mainBundle().pathForResource(language.rawValue, ofType: "lproj")!
        let bundle = NSBundle(path: bundlePath)
        
        languageButton.setTitle(language.rawValue.uppercaseString, forState: .Normal)
        titleLabel.text = bundle?.localizedStringForKey("login.title", value: nil, table: nil)
        descriptionLabel.text = bundle?.localizedStringForKey("login.description", value: nil, table: nil)
        textField.placeholder = bundle?.localizedStringForKey("login.textfield.placeholder", value: nil, table: nil)
        button.setTitle(bundle?.localizedStringForKey("login.button", value: nil, table: nil), forState: .Normal)
    }
    
}

extension LoginViewController {
    
    // MARK: - Dummy Service
    
    private func verify(password password: String?) {
        toggle(interaction: false)
        dispatch_on_main(after: 2) {
            self.toggle(interaction: true)
            
            if password == self.correctPassword {
                printBreadcrumb("The password is correct")
            } else {
                printError("The password is incorrect")
                
                let userInfo = [NSLocalizedDescriptionKey: "The password you entered was incorrect. Please try again."]
                let error = NSError(domain: "com.icapps.error", code: 1, userInfo: userInfo)
                self.presentAlertController(withError: error)
            }
        }
    }
    
}