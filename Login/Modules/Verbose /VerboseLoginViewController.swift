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
    
    // MARK: - Outlets
    
    @IBOutlet var button: UIButton!
    @IBOutlet var textField: UITextField!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Actions
    
    @IBAction func verifyPassword(sender: AnyObject) {
        printAction("Tapped verify password")
    }
    
}