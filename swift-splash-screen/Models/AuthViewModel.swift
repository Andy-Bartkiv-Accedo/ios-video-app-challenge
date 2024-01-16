//
//  AuthViewModel.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-12-11.
//

import Foundation
import SwiftUI

final class AuthViewModel: ObservableObject {
    
    @AppStorage("AUTH_KEY") var isAuth = false {
        willSet { objectWillChange.send() }
    }
    @AppStorage("USER_KEY") var storedUserName = ""
    @AppStorage("AVATAR_KEY") var storedAvatar = ""
    //    @AppStorage("testKey") private var testData: Data = Data()
    @Published var userName = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var invalid: Bool = false
    @Published var avatar = ""
    @Published var userFavorites: [Int] = []
    
    private var authUsers: [User] = []
    
    init() {
        authUsers.append(User(
            id: "0000",
            name: "user",
            password: "1234",
            avatar: "user_img",
            favorites: [872585, 466420, 897087, 787699]
        ));
        if isAuth {
            self.userName = self.storedUserName
            self.avatar = self.storedAvatar
        }
        //        print("Logged in on: \(isAuth)")
        //        print("Current user: \(userName)")
    }
    
    func toggleAuth() {
        self.password = ""
        self.avatar = isAuth ? "" : self.avatar
        self.userName = isAuth ? "" : self.userName
        withAnimation{
            isAuth.toggle()
        }
    }
    
    func resetPassword() {
        self.password = ""
    }
    
    func createAccount() {
        if authUsers.contains(where: {$0.name == self.userName}) || self.userName.count == 0 {
            self.invalid = true
            self.userName = ""
            self.password = ""
            self.confirmPassword = ""
            return
        }
        
        if self.password != self.confirmPassword || self.password.count == 0 {
            self.invalid = true
            self.confirmPassword = ""
            return
        }
        
        authUsers.append(User(
            id: UUID().uuidString,
            name: self.userName,
            password: self.password,
            avatar: self.avatar,
            favorites: []
        ));
        authenticate();
    }
    
    func authenticate() {
        guard let user = authUsers.first(where: {$0.name == self.userName}) else {
            self.invalid = true
            self.userName = ""
            self.password = ""
            return
        }
        guard self.password == user.password else {
            self.invalid = true
            self.password = ""
            return
        }
        self.avatar = user.avatar
        self.userFavorites = user.favorites
        self.storedAvatar = user.avatar
        self.storedUserName = user.name
        toggleAuth()
    }
    
    func logOut() {
        toggleAuth()
    }
    
    func addNewUser(newUser: User) {
        authUsers.append(newUser);
    }
}
