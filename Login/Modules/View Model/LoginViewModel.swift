//
//  LoginViewModel.swift
//  Login
//
//  Created by Jelle Vandebeeck on 04/07/16.
//  Copyright © 2016 iCapps. All rights reserved.
//

import Foundation
import Stella

protocol LoginViewModelDelegate {
    
    func loginViewModelDidSucceed(viewModel: LoginViewModel)
    func loginViewModel(viewModel: LoginViewModel, didFailWith error: NSError)
    func loginViewModelDidChangeLanguage(viewModel: LoginViewModel)
    
}

class LoginViewModel {
    
    // MARK: - Delegate
    
    var delegate: LoginViewModelDelegate?
    
    // MARK: - Internals
    
    private let correctPassword = "awesome"
    private var language = Language.en
    
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
    
    private enum Language: String {
        case nl = "nl"
        case en = "en"
    }
    
    // MARK: - Language
    
    func toggleLanguage() {
        // Toggle the other language.
        language = language == .en ? .nl : .en
        
        delegate?.loginViewModelDidChangeLanguage(self)
    }
    
}

extension LoginViewModel {
    
    // MARK: - Dummy Service
    
    func verify(password password: String?) {
        dispatch_on_main(after: 2) {
            if password == self.correctPassword {
                self.delegate?.loginViewModelDidSucceed(self)
            } else {
                let userInfo = [NSLocalizedDescriptionKey: "The password you entered was incorrect. Please try again."]
                let error = NSError(domain: "com.icapps.error", code: 1, userInfo: userInfo)
                self.delegate?.loginViewModel(self, didFailWith: error)
            }
        }
    }
    
}