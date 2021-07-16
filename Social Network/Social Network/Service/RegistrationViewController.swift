//
//  RegistrationViewController.swift
//  Social Network
//
//  Created by Alex on 16.07.2021.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var YourEmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ReplyPassword: UITextField!
    @IBAction func registrationButton(_ sender: UIButton) {
        
        guard  let email = YourEmailTextField.text, YourEmailTextField.hasText,
               let password = PasswordTextField.text, PasswordTextField.hasText,
               let replyPassword = ReplyPassword.text, ReplyPassword.hasText,
               replyPassword == password else {
            self.showAlert(title: "Ошибка", text: "Пароли не совпадают")
            print("error")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self ]authresult, error in
            if error != nil {
                self?.showAlert(title: "Ошибка", text: "")
                print("")
                return
            } else {
                self?.backHome()
            }
        }
        self.registrationButton(sender)
        
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        backHome()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func backHome() {
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") else { return }
        guard let window = self.view.window else {return}
        window.rootViewController = vc
    }
    
    
    
    func showAlert(title: String?, text: String?) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let okControl = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okControl)
        self.present(alert, animated: true, completion: nil)
    }
  

}
