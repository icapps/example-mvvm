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
    
    // MARK: - View model
    
    private let viewModel = LoginViewModel()
    
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
        
        viewModel.delegate = self
        
        updateLabels()
    }
    
    // MARK: - Actions
    
    @IBAction func verifyPassword(sender: AnyObject) {
        printAction("Tapped verify password")
        
        toggle(interaction: false)
        viewModel.verify(password: textField.text)
    }
    
    @IBAction func toggleLanguage(sender: AnyObject) {
        printAction("Tapped language toggle")
        
        viewModel.toggleLanguage()
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
    
    // MARK: - Labels
    
    private func updateLabels() {
        languageButton.setTitle(viewModel.languageLabel, forState: .Normal)
        titleLabel.text = viewModel.titleLabel
        descriptionLabel.text = viewModel.descriptionLabel
        textField.placeholder = viewModel.textFieldPlaceholderLabel
        button.setTitle(viewModel.verifyButtonLabel, forState: .Normal)
    }
    
}

extension LoginViewController: LoginViewModelDelegate {
    
    func loginViewModelDidSucceed(viewModel: LoginViewModel) {
        printBreadcrumb("The password is correct")
        toggle(interaction: true)
    }
    
    func loginViewModel(viewModel: LoginViewModel, didFailWith error: NSError) {
        printError("The password is incorrect")
        toggle(interaction: true)
        presentAlertController(withError: error)
    }
    
    func loginViewModelDidChangeLanguage(viewModel: LoginViewModel) {
        printBreadcrumb("The language changed")
        updateLabels()
    }
    
}