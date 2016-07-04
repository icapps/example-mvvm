//
//  VerboseLoginViewController.swift
//  Login
//
//  Created by Jelle Vandebeeck on 04/07/16.
//  Copyright © 2016 iCapps. All rights reserved.
//

import UIKit

import Stella
import Delirium

class VerboseLoginViewController: UIViewController {
    
    // MARK: - Internals
    
    private let correctPassword = "awesome"
    
    // MARK: - Outlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var button: UIButton!
    
    // MARK: - Actions
    
    @IBAction func verifyPassword(sender: AnyObject) {
        printAction("Tapped verify password")
        
        verify(password: textField.text)
    }
    
}

extension VerboseLoginViewController {
    
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

extension VerboseLoginViewController {
    
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