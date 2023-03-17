//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by 정주호 on 17/03/2023.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    // MARK: - make UI
    
    private let usernameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username..."
        tf.returnKeyType = .next
        //leftViewMode = 텍스트 필드의 왼쪽에 패딩을 넣어주고 싶은 경우 사용
        tf.leftViewMode = .always
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = Constants.cornerRadius
        tf.backgroundColor = .secondarySystemBackground
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.secondaryLabel.cgColor
        return tf
    }()
    
    private let emailField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email address..."
        tf.returnKeyType = .next
        //leftViewMode = 텍스트 필드의 왼쪽에 패딩을 넣어주고 싶은 경우 사용
        tf.leftViewMode = .always
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = Constants.cornerRadius
        tf.backgroundColor = .secondarySystemBackground
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.secondaryLabel.cgColor
        return tf
    }()
    
    private let passwordField: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.placeholder = "Password..."
        tf.returnKeyType = .continue
        tf.leftViewMode = .always
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = Constants.cornerRadius
        tf.backgroundColor = .secondarySystemBackground
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.secondaryLabel.cgColor
        return tf
    }()
    
    private let registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = Constants.cornerRadius
        btn.backgroundColor = .systemGreen
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        registerButton.addTarget(self,
                                 action: #selector(didTapRegister),
                                 for: .touchUpInside)
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+100, width: view.width-40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom+10, width: view.width-40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom+10, width: view.width-40, height: 52)

    }
    
    private func addSubView() {
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
    }
    
    @objc private func didTapRegister() {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
        let username = usernameField.text, !username.isEmpty,
        let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    //good
                    self.dismiss(animated: true)
                }
                else {
                    //failed

                }
            }
        }
    }


}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            didTapRegister()
        }
        return true
    }
}
