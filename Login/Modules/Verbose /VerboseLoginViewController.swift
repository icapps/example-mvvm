//
//  VerboseLoginViewController.swift
//  Login
//
//  Created by Jelle Vandebeeck on 04/07/16.
//  Copyright © 2016 iCapps. All rights reserved.
//

import UIKit

import Stella

class VerboseLoginViewController: UIViewController {
    
    // MARK: - Internals
    
    private let correctPassword = "awesome"
    
    // MARK: - Outlets
    
    @IBOutlet var button: UIButton!
    @IBOutlet var textField: UITextField!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction func verifyPassword(sender: AnyObject) {
        printAction("Tapped verify password")
        verify(password: textField.text)
    }
    
}

extension VerboseLoginViewController {
    
    // MARK: - Dummy Service
    
    private func verify(password password: String?) {
        dispatch_on_main(after: 3) {
            if password == self.correctPassword {
                printBreadcrumb("The password is correct")
            } else {
                printError("The password is incorrect")
            }
        }
    }
    
}