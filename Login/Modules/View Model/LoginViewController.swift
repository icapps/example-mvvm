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
        
        updateLabels(to: viewModel.language)
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
    
    private func updateLabels(to language: LoginViewModel.Language) {
        let bundlePath = NSBundle.mainBundle().pathForResource(language.rawValue, ofType: "lproj")!
        let bundle = NSBundle(path: bundlePath)
        
        languageButton.setTitle(language.rawValue.uppercaseString, forState: .Normal)
        titleLabel.text = bundle?.localizedStringForKey("login.title", value: nil, table: nil)
        descriptionLabel.text = bundle?.localizedStringForKey("login.description", value: nil, table: nil)
        textField.placeholder = bundle?.localizedStringForKey("login.textfield.placeholder", value: nil, table: nil)
        button.setTitle(bundle?.localizedStringForKey("login.button", value: nil, table: nil), forState: .Normal)
    }
    
}

extension LoginViewController: LoginViewModelDelegate {
    
    func loginViewModelDidSucceed(viewModel: LoginViewModel) {
        // Succeeded 🎉
        toggle(interaction: true)
    }
    
    func loginViewModel(viewModel: LoginViewModel, didFailWith error: NSError) {
        toggle(interaction: true)
        presentAlertController(withError: error)
    }
    
    func loginViewModel(viewModel: LoginViewModel, didChange language: LoginViewModel.Language) {
        updateLabels(to: language)
    }
    
}