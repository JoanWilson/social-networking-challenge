//
//  LoginViewController.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 13/08/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    let viewModel = LoginViewModel()
    
    lazy var subImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        let asset = UIImage(named: "Stars")
        let transparentImage = asset?.image(alpha: 1)
        image.image = transparentImage
        return image
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "planet")
        return image
    }()
    
    lazy var whiteLoginBackground: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "moon")
        return image
    }()
    
    lazy var loginInput: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .black
        
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(
            string: "E-mail",
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
    
    lazy var passwordInput: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.backgroundColor = .black
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
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
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    @objc func loginButtonAction(sender: UIButton!){
        let email = loginInput.text!
        let password = passwordInput.text!
        
        Task {
            let session = await viewModel.loginUser(email: email, password: password)
            let acccessToken = session?.token
            guard let token = acccessToken else {
                return
            }
            
            let data = Data(token.utf8)
            
            KeychainHelper.standard.delete(service: "access-token", account: "space-networking")
            KeychainHelper.standard.save(data, service: "access-token", account: "space-networking")
            let agorafoi = KeychainHelper.standard.read(service: "access-token", account: "space-networking")!
            let dataa = String(data: agorafoi, encoding: .utf8) ?? "invalid"
            print(session!)
            
            
            if session?.token != nil {
                print("deu certo")
                let feedUpViewController = FeedViewController()
                self.navigationController?.pushViewController(feedUpViewController, animated: true)
            }
            print(dataa)
            
        }
        
    }
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastre-se", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    @objc func registerButtonAction(){
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.subImageView)
        subImageView.pinEdges(to: view)
        view.addSubview(self.logoAppImageView)
        view.addSubview(self.loginInput)
        view.addSubview(self.passwordInput)
        view.addSubview(self.loginButton)
        view.addSubview(self.registerButton)
        passwordInput.isSecureTextEntry = true
//                passwordInput.enablePasswordToggle()
//        navigationController?.navigationBar.isHidden = true
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            
            logoAppImageView.widthAnchor.constraint(equalToConstant: 350),
            logoAppImageView.heightAnchor.constraint(equalToConstant: 300),
            logoAppImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            logoAppImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginInput.heightAnchor.constraint(equalToConstant: 60),
            loginInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginInput.topAnchor.constraint(equalTo: logoAppImageView.topAnchor, constant: 300),
            
            passwordInput.heightAnchor.constraint(equalToConstant: 60),
            passwordInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordInput.topAnchor.constraint(equalTo: loginInput.bottomAnchor, constant: 10),
            
            //            buttonLogin.heightAnchor.constraint(equalToConstant: 60),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 10),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            registerButton.heightAnchor.constraint(equalToConstant: 60)
            
            
            
            
        ])
    }
    
}
