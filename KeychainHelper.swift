//
//  KeychainHelper.swift
//  KeyChain
//
//  Created by Davin Henrik on 8/3/23.
//

// KeychainHelper.swift
import Foundation
import Security

class KeychainHelper {
    static func savePassword(username: String, password: String) -> Bool {
        let passwordData = password.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: "myapp.com", // Change this to your app's domain
            kSecAttrAccount as String: username,
            kSecValueData as String: passwordData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    static func getPassword(username: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: "myapp.com", 
            kSecAttrAccount as String: username,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data,
               let password = String(data: retrievedData, encoding: .utf8) {
                return password
            }
        }

        return nil
    }

    static func deletePassword(username: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: "myapp.com", // Change this to your app's domain
            kSecAttrAccount as String: username
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}

