//
//  SignUpViewController.swift
//  SocialNetworking
//
//  Created by Jamile Castro on 16/08/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //    var delegate: sendUserDelegate? = nil
        var viewModel: SignUpViewModel = SignUpViewModel()
    
    lazy var nameInput: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray3
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
        textField.backgroundColor = .systemGray3
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
        textField.backgroundColor = .systemGray3
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
        textField.isSecureTextEntry = true
        
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
            //            print(session)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up"
        self.setNavigationBar()
        view.backgroundColor = .white
        view.addSubview(self.nameInput)
        view.addSubview(self.emailInput)
        view.addSubview(self.passwordInput)
//        passwordInput.enablePasswordToggle()
        
        view.addSubview(createButton)
        
        configConstraints()
    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: "Sign Up")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(dissmissView))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    @objc
    func dissmissView(){
        self.dismiss(animated: true, completion: nil)
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




