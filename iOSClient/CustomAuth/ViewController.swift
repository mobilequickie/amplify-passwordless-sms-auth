//
//  ViewController.swift
//  CustomAuth
//
//  Created by Dennis Hills on 12/4/19.
//  Copyright © 2019 Dennis Hills. All rights reserved.
//
import UIKit
import AWSMobileClient
import PhoneNumberKit // See https://github.com/marmelroy/PhoneNumberKit
import Toast_Swift  // See https://github.com/scalessec/Toast-Swift

class ViewController: UIViewController {
    
    @IBOutlet weak var btnAuth: UIButton!
    @IBOutlet weak var txtPhoneNumber: PhoneNumberTextField!
    
    let phoneNumberKit = PhoneNumberKit() // phone number validator
    lazy var passCodeView = PassCodeView(digitCount: 6, validate: self.validatePassCode) // pass code view
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        txtPhoneNumber.withExamplePlaceholder = true
        txtPhoneNumber.withFlag = true
        txtPhoneNumber.withPrefix = true
 
        self.changeAuthButtonState(isSignedIn: false)
        initializeAWSMobileClient() // Initialize AWSMobileClient
    }
    
    func showPassCodeView() {
        view.addSubviews(views: passCodeView)
        passCodeView.horizontal(toView: view, space: 8)
        passCodeView.top(toView: view, space: 180)
    }
    
    // PassCodeView Completion handler - Called when all passcode fields have been entered
    func validatePassCode(_ code: String) {
        self.sendAuthChallengeResponse(challengeResponse: code)
    }
    
    // Add user state listener and initialize the AWSMobileClient
    func initializeAWSMobileClient() {
        
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                switch(userState){
                case .signedIn: // is Signed IN
                    print("Logged In")
                    self.changeAuthButtonState(isSignedIn: true)
                    print("Cognito Identity Id (authenticated): \(String(describing: AWSMobileClient.default().identityId))")
                case .signedOut: // is Signed OUT
                    print("Logged Out")
                    self.changeAuthButtonState(isSignedIn: false)
                    print("Cognito Identity Id (unauthenticated): \(String(describing: AWSMobileClient.default().identityId))")
                case .signedOutUserPoolsTokenInvalid: // User Pools refresh token INVALID
                    print("User Pools refresh token is invalid or expired.")
                    self.changeAuthButtonState(isSignedIn: false)
                case .signedOutFederatedTokensInvalid: // Federated refresh token from social provider (e.g. Facebook, Google, Login with Amazon, SignIn with Apple is INVALID
                    print("Federated refresh token is invalid or expired.")
                    self.changeAuthButtonState(isSignedIn: false)
                default:
                    self.changeAuthButtonState(isSignedIn: false)
                    AWSMobileClient.default().signOut()
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        self.addUserStateListener() // Register for user state changes
    }
    
    // AWSMobileClient - a realtime notifications for user state changes
    func addUserStateListener() {
        
        AWSMobileClient.default().addUserStateListener(self) { (userState, info) in
            switch (userState) {
            case .guest:
                self.changeAuthButtonState(isSignedIn: false)
                print("Listener status change: guest")
            case .signedIn:
                self.changeAuthButtonState(isSignedIn: true)
                print("Listener status change: signedIn")
                DispatchQueue.main.async {
                    self.view.hideAllToasts()
                    self.passCodeView.removeFromSuperview() // Remove the passcode view
                    self.view.makeToast("Successfully athenticated!", duration: 2.5, position: .top)
                }
            case .signedOut:
                self.changeAuthButtonState(isSignedIn: false)
                print("Listener status change: signedOut")
                DispatchQueue.main.async {
                    self.view.makeToast("User successfully signed out.", duration: 3.0, position: .top)
                }
            case .signedOutUserPoolsTokenInvalid:
                self.changeAuthButtonState(isSignedIn: false)
                print("Listener status change: signedOutUserPoolsTokenInvalid")
            case .signedOutFederatedTokensInvalid:
                self.changeAuthButtonState(isSignedIn: false)
                print("Listener status change: signedOutFederatedTokensInvalid")
            default:
                self.changeAuthButtonState(isSignedIn: false)
                print("Listener: unsupported userstate")
            }
        }
    }
    
    func signUp() {
        // TODO - Do we need signup for passwordless SMS? Probably if you want to capture a display name or user's real name
    }
    
    // This is the default signIn for an existing user with Phone Number as their official Cognito "Username".
    // The password DOES NOT MATTER and will never be used or need to be stored anywhere. Just and oddity with AWSMobileClient.
    func signIn(phoneNumber: String) {
        AWSMobileClient.default().signIn(username: phoneNumber, password: NSUUID().uuidString) { (signInResult, error) in
            if let signInResult = signInResult {
                if (signInResult.signInState == .customChallenge) {
                    print("Custom Challenge parameters: \(signInResult.parameters)")
                    DispatchQueue.main.async {
                        self.view.makeToast("Enter passcode sent to phone # ending in \(String(phoneNumber.suffix(4)))", duration: 2.7, position: .top)
                        self.showPassCodeView() // show the passcode view
                    }
                } else {
                    print("SignInResult: \(signInResult)")
                }
            } else {
                var displayErrorMsg = ""
                if let error = error as? AWSMobileClientError { 
                    switch(error) {
                    case .userNotFound(let message):
                        displayErrorMsg = message
                    case .badRequest(let message):
                        displayErrorMsg = message
                    default:
                        displayErrorMsg = "Authentication error."
                        break
                    }
                    DispatchQueue.main.async {
                        self.view.makeToast("\(displayErrorMsg)", duration: 3.0, position: .top)
                    }
                }
            }
        }
    }
    
     // This is the default entry point for sending back all challenge-response answers during CUSTOM_AUTH flow
    func sendAuthChallengeResponse(challengeResponse: String) {
        AWSMobileClient.default().confirmSignIn(challengeResponse: challengeResponse,
                            completionHandler: { (signInResult, error) in
            if let error = error  {
                print("\(error.localizedDescription)")
            } else if let signInResult = signInResult {
                switch (signInResult.signInState) {
                case .signedIn:
                    print("User is signed in.")
                default:
                    print("\(signInResult.signInState.rawValue)")
                }
            }
        })
    }
    
    // Changes the single auth button title depending on the logged in status of the user
    func changeAuthButtonState(isSignedIn: Bool) {
        DispatchQueue.main.async {
            if(isSignedIn) {
                DispatchQueue.main.async {
                    self.btnAuth.setTitle("Logout", for: .normal)
                }
            } else {
                DispatchQueue.main.async {
                    self.btnAuth.setTitle("Login", for: .normal)
                }
            }
        }
    }
    
    // This button becomes teh LOGIN button if user is logged out, else it becomes a LOGOUT button
    @IBAction func btnAuthPressed(_ sender: Any) {
        if (AWSMobileClient.default().isSignedIn) {
            self.signOut()
        } else {
            // do phone number validation first
            do {
                let validPhoneNumber = try phoneNumberKit.parse(self.txtPhoneNumber.text!)
                let validFormattedPhoneNumber = phoneNumberKit.format(validPhoneNumber, toType: .e164)
                print("Sending phone number as e.164 formatted: \(validFormattedPhoneNumber)")
                self.signIn(phoneNumber: validFormattedPhoneNumber)
            }
            catch {
                print("Failed to validate phone number")
                DispatchQueue.main.async {
                    self.view.makeToast("\(self.txtPhoneNumber.text!) Invalid phone number.", duration: 2.2, position: .top)
                }
            }
        }
    }
    
    func signOut() {
        AWSMobileClient.default().signOut()
    }
}
