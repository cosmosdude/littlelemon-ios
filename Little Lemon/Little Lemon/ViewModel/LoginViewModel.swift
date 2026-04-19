//
//  LoginViewModel.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import Combine
import SwiftUI

class LoginViewModel: UserViewModel {
    
    func login(_ user: User) {
        objectWillChange.send()
        self.user = user
    }
    
    func logout() {
        objectWillChange.send()
        self.user = nil
    }
}

struct User: Equatable, Codable {
    
    var avatar: UIImage? = nil
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    
    enum CodingKeys: CodingKey {
        case avatar
        case firstName
        case lastName
        case email
    }
    
    init(avatar: UIImage? = nil, firstName: String = "", lastName: String = "", email: String = "") {
        self.avatar = avatar
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let avatarData = try container.decodeIfPresent(Data.self, forKey: .avatar) {
            self.avatar = UIImage(data: avatarData)
        }
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.email = try container.decode(String.self, forKey: .email)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(avatar?.pngData(), forKey: .avatar)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encode(self.lastName, forKey: .lastName)
        try container.encode(self.email, forKey: .email)
    }
    
    static func ==(_ lhs: User, _ rhs: User) -> Bool {
        lhs.avatar === rhs.avatar && lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.email == rhs.email
    }
    
}
