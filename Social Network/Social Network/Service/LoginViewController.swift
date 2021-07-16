//
//  LoginViewController.swift
//  Social Network
//
//  Created by Alex on 16.07.2021.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordtextField: UITextField!
    
    @IBAction func LoginInButton(_ sender: UIButton) {
        guard let email = EmailTextField.text, EmailTextField.hasText,
              let password = PasswordtextField.text, PasswordtextField.hasText else {
            self.showAlert(title: "Ошибка", text: "Введите логин и пароль")
            print("Не корректные данные")
            return
        }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(title: "Error", text: error.localizedDescription)
                print(error)
                return
            } else {
                self.showHome()
            }
        }
    }
    @IBAction func RegistrationButton(_ sender: UIButton) {
        self.registration()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseApp.configure()
        
    }
    func registration() {
        guard let vc = storyboard?.instantiateViewController(identifier: "RegistrationViewController") else { return }
        guard let window = self.view.window else { return }
        window.rootViewController = vc
    }
    
    func showHome() {
        guard let vc = storyboard?.instantiateViewController(identifier: "APIViewController") else { return }
        guard let window = self.view.window else { return}
        window.rootViewController = vc
    }
    func showAlert(title: String?, text: String?) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let okControl = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okControl)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
