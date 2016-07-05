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
import ReactiveKit
import ReactiveUIKit

class ReactiveLoginViewController: UIViewController {
    
    // MARK: - View model
    
    private let viewModel = ReactiveLoginViewModel()
    
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
        
        setupObservers()
    }
    
    // MARK: - Reactive
    
    private func setupObservers() {
        // Observe the language changes.
        let _ = viewModel.language.observeNext { language in
            self.languageButton.setTitle(self.viewModel.languageLabel, forState: .Normal)
            self.titleLabel.text = self.viewModel.titleLabel
            self.descriptionLabel.text = self.viewModel.descriptionLabel
            self.textField.placeholder = self.viewModel.textFieldPlaceholderLabel
            self.button.setTitle(self.viewModel.verifyButtonLabel, forState: .Normal)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func verifyPassword(sender: AnyObject) {
        printAction("Tapped verify password")
        
        toggle(interaction: false)
        viewModel.verify(password: textField.text) { success, error in
            self.toggle(interaction: true)
            
            if success {
                printBreadcrumb("The password is correct")
            } else if let error = error {
                printError("The password is incorrect")
                self.presentAlertController(withError: error)
            }
        }
    }
    
    @IBAction func toggleLanguage(sender: AnyObject) {
        printAction("Tapped language toggle")
        
        viewModel.toggleLanguage()
    }
    
}

extension ReactiveLoginViewController {
    
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