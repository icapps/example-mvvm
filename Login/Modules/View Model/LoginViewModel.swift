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
    func loginViewModel(viewModel: LoginViewModel, didChange language: LoginViewModel.Language)
    
}

class LoginViewModel {
    
    // MARK: - Delegate
    
    var delegate: LoginViewModelDelegate?
    
    // MARK: - Internals
    
    private let correctPassword = "awesome"
    private(set) var language = Language.en
    
}

extension LoginViewModel {
    
    enum Language: String {
        case nl = "nl"
        case en = "en"
    }
    
    // MARK: - Language
    
    func toggleLanguage() {
        // Toggle the other language.
        language = language == .en ? .nl : .en
        
        delegate?.loginViewModel(self, didChange:language)
    }
    
}

extension LoginViewModel {
    
    // MARK: - Dummy Service
    
    func verify(password password: String?) {
        dispatch_on_main(after: 2) {
            if password == self.correctPassword {
                printBreadcrumb("The password is correct")
                
                self.delegate?.loginViewModelDidSucceed(self)
            } else {
                printError("The password is incorrect")
                
                let userInfo = [NSLocalizedDescriptionKey: "The password you entered was incorrect. Please try again."]
                let error = NSError(domain: "com.icapps.error", code: 1, userInfo: userInfo)
                self.delegate?.loginViewModel(self, didFailWith: error)
            }
        }
    }
    
}