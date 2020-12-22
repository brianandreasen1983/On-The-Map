//
//  LoginViewController.swift
//  On The Map
//
//  Created by Brian Andreasen on 4/25/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButon: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func login(_ sender: Any) {
        setLoggingIn(true)
        UdacityClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: handleSessionResponse(success:error:))
    }
    
    @IBAction func signUp(_ sender: Any) {
        let url = NSURL(string: "https://auth.udacity.com/sign-up" )
        
        UIApplication.shared.openURL(url! as URL)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearTextFields()
    }
    
    func handleSessionResponse(success: Bool, error: Error?)  {
        if success {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
                self.setLoggingIn(false)
            }
        } else {
            setLoggingIn(false)
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func showLoginFailure(message: String) {
        setLoggingIn(false)
        let message = "The username or password is incorrect"
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert )
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func disableButtons() {
        loginButton.isEnabled = false;
        signUpButon.isEnabled = false;
    }
    
    func enableButtons() {
        loginButton.isEnabled = true;
        signUpButon.isEnabled = true;
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn{
            activityIndicator.startAnimating()
            disableButtons()
        } else {
            activityIndicator.stopAnimating()
            enableButtons()
        }
    }
    
    func clearTextFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
}
