//
//  ReactiveLoginViewModelSpec.swift
//  Login
//
//  Created by Jelle Vandebeeck on 05/07/16.
//  Copyright © 2016 iCapps. All rights reserved.
//

import Quick
import Nimble

@testable import Login

class ReactiveLoginViewModelSpec: QuickSpec {
    override func spec() {
        
        describe("login view model") {
            context("verify password") {
                let viewModel = ReactiveLoginViewModel()
                
                it("should not validate the empty password") {
                    waitUntil(timeout: 3.0) { done in
                        viewModel.verify(password: nil) { success, error in
                            expect(success) == false
                            expect(error).notTo(beNil())
                            expect(viewModel.loading.value) == false
                            done()
                        }
                        expect(viewModel.loading.value) == true
                    }
                }
                
                it("should not validate the incorrect password") {
                    waitUntil(timeout: 3.0) { done in
                        viewModel.verify(password: "incorrect") { success, error in
                            expect(success) == false
                            expect(error).notTo(beNil())
                            expect(viewModel.loading.value) == false
                            done()
                        }
                        expect(viewModel.loading.value) == true
                    }
                }
                
                it("should  validate the correct password") {
                    waitUntil(timeout: 3.0) { done in
                        viewModel.verify(password: "awesome") { success, error in
                            expect(success) == true
                            expect(error).to(beNil())
                            expect(viewModel.loading.value) == false
                            done()
                        }
                        expect(viewModel.loading.value) == true
                    }
                }
            }
            
            context("labels") {
                let viewModel = ReactiveLoginViewModel()
                
                it("should have an English title text at launch") {
                    expect(viewModel.titleLabel).to(equal("Hi!"))
                }
                
                it("should have a English description text at launch") {
                    expect(viewModel.descriptionLabel).to(equal("Welcome to this awesome application that does absolutely nothing. It's just used as an example in order to explain how to get rid of big ass view controllers."))
                }
                
                it("should have a English button text at launch") {
                    expect(viewModel.verifyButtonLabel).to(equal("Verify your password"))
                }
                
                it("should have a English placeholder text at launch") {
                    expect(viewModel.textFieldPlaceholderLabel).to(equal("Enter your password"))
                }
                
                it("should have a English language text at launch") {
                    expect(viewModel.languageLabel).to(equal("EN"))
                }
            }
            
            context("language") {
                var viewModel: ReactiveLoginViewModel? = nil
                beforeEach {
                    viewModel = ReactiveLoginViewModel()
                    viewModel!.toggleLanguage()
                }
                
                
                it("should change the language property") {
                    expect(viewModel!.language.value) == ReactiveLoginViewModel.Language.nl
                    viewModel?.toggleLanguage()
                    expect(viewModel!.language.value) == ReactiveLoginViewModel.Language.en
                }
                
                it("should have an Dutch title text after toggle") {
                    expect(viewModel!.titleLabel).to(equal("Hallo!"))
                }
                
                it("should have a Dutch description text after toggle") {
                    expect(viewModel!.descriptionLabel).to(equal("Welkom bij deze geweldige app die echt waardeloos is. We gaan het enkel gebruiken om uit te leggen hoe we onze gigantische controllers kunnen kleiner maken."))
                }
                
                it("should have a Dutch button text after toggle") {
                    expect(viewModel!.verifyButtonLabel).to(equal("Verifieer je wachtwoord"))
                }
                
                it("should have a Dutch placeholder text after toggle") {
                    expect(viewModel!.textFieldPlaceholderLabel).to(equal("Geef je wachtwoord in"))
                }
                
                it("should have a Dutch language text after toggle") {
                    expect(viewModel!.languageLabel).to(equal("NL"))
                }
            }
        }
        
    }
}
