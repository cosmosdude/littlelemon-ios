//
//  UserViewModel.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import Foundation
import Combine
import SwiftUI

class UserViewModel: ObservableObject {
    
    private let userDefaults = UserDefaults.standard
    private let key = "user"
    
    var isLoggedIn: Bool { user != nil }
    
    static let notificationName = Notification.Name("UserUpdated")
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(onUserUpdate), name: Self.notificationName, object: nil)
    }
    
    /// Get the user
    var user: User? {
        get {
            try? JSONDecoder().decode(User.self, from: userDefaults.data(forKey: key) ?? Data())
        }
        set {
            objectWillChange.send()
            if let newValue {
                userDefaults.set(try? JSONEncoder().encode(newValue), forKey: key)
            } else {
                userDefaults.removeObject(forKey: key)
            }
            NotificationCenter.default.post(name: Self.notificationName, object: newValue)
        }
    }
    
    @objc
    private func onUserUpdate() {
        objectWillChange.send()
    }
    
}
