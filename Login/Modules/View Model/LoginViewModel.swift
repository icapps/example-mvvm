//
//  LoginViewModel.swift
//  Login
//
//  Created by Jelle Vandebeeck on 04/07/16.
//  Copyright © 2016 iCapps. All rights reserved.
//

import Foundation
import Stella

class LoginViewModel {
    
    // MARK: - Internals
    
    private let correctPassword = "awesome"
    private var language = Language.en
    private var updateLanguage: (() -> ())? = nil
    
    // MARK: - Init
    
    init(updateLanguage: (() -> ())? = nil) {
        self.updateLanguage = updateLanguage
    }
    
    // MARK: - Labels
    
    private var bundle: NSBundle? {
        let bundlePath = NSBundle.mainBundle().pathForResource(language.rawValue, ofType: "lproj")!
        return NSBundle(path: bundlePath)
    }
    
    var titleLabel: String? {
        return bundle?.localizedStringForKey("login.title", value: nil, table: nil)
    }
    
    var descriptionLabel: String? {
        return bundle?.localizedStringForKey("login.description", value: nil, table: nil)
    }
    
    var textFieldPlaceholderLabel: String? {
        return bundle?.localizedStringForKey("login.textfield.placeholder", value: nil, table: nil)
    }
    
    var verifyButtonLabel: String? {
        return bundle?.localizedStringForKey("login.button", value: nil, table: nil)
    }
    
    var languageLabel: String? {
        return language.rawValue.uppercaseString
    }
    
}

extension LoginViewModel {
    
    // MARK: - Language
    
    private enum Language: String {
        case nl = "nl"
        case en = "en"
    }
    
    func toggleLanguage() {
        // Toggle the other language.
        language = language == .en ? .nl : .en
        updateLanguage?()
    }
    
}

extension LoginViewModel {
    
    // MARK: - Dummy Service
    
    func verify(password password: String?, completion: ((success: Bool, error: NSError?) -> ())?) {
        dispatch_on_main(after: 2) {
            if password == self.correctPassword {
                completion?(success: true, error: nil)
            } else {
                let userInfo = [NSLocalizedDescriptionKey: "The password you entered was incorrect. Please try again."]
                let error = NSError(domain: "com.icapps.error", code: 1, userInfo: userInfo)
                completion?(success: false, error: error)
            }
        }
    }
    
}