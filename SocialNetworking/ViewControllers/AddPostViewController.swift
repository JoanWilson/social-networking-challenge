//
//  AddPostViewController.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 18/08/22.
//

import UIKit

class AddPostViewController: UIViewController {
    
    lazy var addPostText: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.autocorrectionType = .no
//        textField.autocapitalizationType = .none
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.systemGray3.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 12
        textField.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textField.textAlignment = .natural
        textField.keyboardType = .twitter
        textField.attributedText = NSAttributedString(string: "Eu acredito que...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.4)])
//        textField.attributedPlaceholder = NSAttributedString(
//            string: "Seu post",
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)]
//        )
//        textField.accessibilityScroll(.down)
        
        
        return textField
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton(type: .custom)
        button.configuration = .filled()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Post", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    @objc func postButtonAction(){
        let token = KeychainHelper.standard.read(service: "access-token", account: "space-networking")!
        
        let tokenString = String(data: token, encoding: .utf8) ?? "invalid"
        print(tokenString)

        
        Task {
            await API.createPost(content: addPostText.text, token: tokenString)
            dismiss(animated: true)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(addPostText)
        view.addSubview(postButton)

        configConstraints()
        // Do any additional setup after loading the view.
    }
    
    private func configConstraints () {
        NSLayoutConstraint.activate([
            
            addPostText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addPostText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addPostText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            addPostText.heightAnchor.constraint(equalToConstant: 300),
            
            postButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            postButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            postButton.topAnchor.constraint(equalTo: addPostText.bottomAnchor, constant: 15),
        
            
        ])
    }

}


class CustomTextField: UITextField {
    struct Constants {
        static let sidePadding: CGFloat = 10
        static let topPadding: CGFloat = 8
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x + Constants.sidePadding,
            y: bounds.origin.y + Constants.topPadding,
            width: bounds.size.width - Constants.sidePadding * 2,
            height: bounds.size.height - Constants.topPadding * 2
        )
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
}
