//
//  UITextField+SecureToggle.swift
//  SocialNetworking
//
//  Created by Jamile Castro on 16/08/22.
//

import Foundation
import UIKit

let button = UIButton(type: .custom)

extension  UITextField {
    
    func enablePasswordToggle(){
        
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 10)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
        button.tintColor = .white
    }
    
    @objc func togglePasswordView(_ sender: Any) {
        isSecureTextEntry.toggle()
        button.isSelected.toggle()
    }
    
}
