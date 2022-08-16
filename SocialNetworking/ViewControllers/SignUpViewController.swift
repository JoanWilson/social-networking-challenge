//
//  SignUpViewController.swift
//  SocialNetworking
//
//  Created by Jamile Castro on 16/08/22.
//

import UIKit

protocol sendUserDelegate {
    func createNewUser(loginTextField: String, emailTextField: String, passwordTextField: String)
}

class SignUpViewController: UIViewController {
    
    var delegate: sendUserDelegate? = nil
    var viewModel: SignUpViewModel = SignUpViewModel()
    
    lazy var nameInput: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .red
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.attributedPlaceholder =  NSAttributedString(
            string: "Digite seu nome",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.textColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        
        return textField
    }()
    
    lazy var emailInput: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .red
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder =  NSAttributedString(
            string: "Digite seu email",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.textColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        
        return textField
    }()
    
    lazy var passwordInput: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .red
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)]
        )
        textField.textColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        
        return textField
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .custom)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        return button
    }()
    
    @objc func buttonAction(sender: UIButton!){
        let newUser = NewUser(name: nameInput.text!, email: emailInput.text!, password: passwordInput.text!)
         Task {
             let session = await viewModel.createNewUser(newUser: newUser)
             print(session)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(self.nameInput)
        view.addSubview(self.emailInput)
        view.addSubview(self.passwordInput)
        passwordInput.isSecureTextEntry = true
        passwordInput.enablePasswordToggle()
        
        view.addSubview(createButton)
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            nameInput.heightAnchor.constraint(equalToConstant: 60),
            nameInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nameInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameInput.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            emailInput.heightAnchor.constraint(equalToConstant: 60),
            emailInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailInput.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 10),
            
            
            passwordInput.heightAnchor.constraint(equalToConstant: 60),
            passwordInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 10),
            
            createButton.heightAnchor.constraint(equalToConstant: 60),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            createButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 10),
            
            
        ])
    }
}

class TextFieldWithPadding: UITextField {
    var  textPadding = UIEdgeInsets(
        top: 10, left: 20, bottom: 10, right: 20
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}


