//
//  Keychain.swift
//  SocialNetworking
//
//  Created by Joan Wilson Oliveira on 17/08/22.
//

import Foundation

final class KeychainHelper {
    static let standard = KeychainHelper()
    private init (){}
    
    func save(_ data: Data, service: String, account: String) {
        
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary
        
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        print(status)
        
        if status != errSecSuccess {
            // Print out the error
            print("Error: \(status)")
        } else if status == errSecDuplicateItem {
            // Item already exist, thus update it.
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            // Update existing item
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    
    func read(service: String, account: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    func delete(service: String, account: String) {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
    
    func isLogged() -> Bool {
        
        let data = KeychainHelper.standard.read(service: "access-token", account: "space-networking")
        
        guard let dataToken = data else {
            
            return false
        }
        
        let token = String(data: dataToken, encoding: .utf8) ?? "invalid"
        

        return true
    }
}
