//
//  View_User.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-13.
//

import SwiftUI

struct View_User: View {
    @EnvironmentObject var avm: AuthViewModel
    @EnvironmentObject var mvm: MediaViewModel
    
    @State var showLoginModal: Bool = false
    @State var showNewAccountModal: Bool = false
    @State var selectedAvatar: String = "user2_img"

    var body: some View {
        
        let userName: String = avm.isAuth ? avm.userName : "Visitor"
        let userBtnLabel: String = avm.isAuth ? "Log Out" : "Sign In"
        
        ZStack{
            Color.cyan
                .edgesIgnoringSafeArea(.top)
            Circle()
                .scale(1.75)
                .foregroundColor(.white.opacity(0.15))
            Ellipse()
                .scale(0.8)
                .foregroundColor(.white.opacity(0.25))
            VStack {
                
                UserImage(userImage: avm.avatar)
                
                Text(userName)
                    .foregroundColor(.blue)
                    .font(.system(size: 30))
                    .bold()
                    .padding()
                
                VStack(spacing:30) {
                    
                    Button(userBtnLabel) {
                        if avm.isAuth {
                            avm.logOut()
                            mvm.updateFavorites(newFavorites: [])
                        } else {
                            showLoginModal = true
                        }
                    }
                    .foregroundColor(.white)
                    .font(.system(size: 25.0))
                    .frame(width: 180, height: 50)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    
                    if !avm.isAuth {
                        Button("New Account") {
                            showNewAccountModal = true
                        }
                            .foregroundColor(.white)
                            .font(.system(size: 25.0))
                            .frame(width: 180, height: 50)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                }
            }
            if showLoginModal {
                LogInModal(isVisible: $showLoginModal)
            }
            if showNewAccountModal {
                NewAccountModal(
                    isVisible: $showNewAccountModal,
                    selected: $selectedAvatar
                )
            }
        }
    }
}

struct LogInModal : View {
    @Binding var isVisible: Bool
    
    @EnvironmentObject var avm: AuthViewModel
    @EnvironmentObject var mvm: MediaViewModel

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 30) {
                TextField("User Name", text: $avm.userName)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                    .font(.system(size: 25))
                SecureField("Password", text: $avm.password)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                    .privacySensitive()
                    .font(.system(size: 25))
                Button("Log in") {
                    avm.authenticate()
                    if avm.isAuth {
                        mvm.updateFavorites(newFavorites: avm.userFavorites)
                    }
                    isVisible = avm.isAuth ? false : true;
                }
                    .foregroundColor(.white)
                    .font(.system(size: 25.0))
                    .frame(width: 150, height: 50)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                
                Button("Go Back") {
                    avm.resetPassword()
                    isVisible = false;
                }
                    .foregroundColor(.white)
                    .font(.system(size: 25.0))
                    .frame(width: 150, height: 50)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            .padding()
            Spacer()
        }
        .transition(.scale)
        .background(.cyan)
        .alert("Invalid UserName or Password",
               isPresented: $avm.invalid) {
            Button("Dismiss", action: avm.resetPassword)
        }
    }
}

struct NewAccountModal : View {
    @Binding var isVisible: Bool
    @Binding var selected: String
    
    @EnvironmentObject var avm: AuthViewModel
    
    private let userImages = ["user_img", "user2_img", "user3_img", "user4_img"]

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 30) {
                ScrollViewReader { value in
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(userImages, id: \.self) { avatar in
                                Image(avatar)
                                    .resizable()
                                    .opacity(avatar == selected ? 1 : 0.65)
                                    .frame(width: avatar == selected ? 110 : 90,
                                           height: avatar == selected ? 110 : 90)
                                    .overlay(Circle().stroke(Color.orange, lineWidth: 3))
                                    .onTapGesture {
                                        withAnimation{
                                            selected = avatar
                                            avm.avatar = selected
                                            value.scrollTo(selected, anchor: .center)
                                    }
                                }
                            }
                        }
                    }
                }
                TextField("Create User Name", text: $avm.userName)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                    .font(.system(size: 25))
                SecureField("Create Password", text: $avm.password)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                    .privacySensitive()
                    .font(.system(size: 25))
                SecureField("Confirm Password", text: $avm.confirmPassword)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                    .privacySensitive()
                    .font(.system(size: 25))
                Button("Create Account") {
                    avm.createAccount()
                    isVisible = avm.isAuth ? false : true;
                }
                    .foregroundColor(.white)
                    .font(.system(size: 25.0))
                    .frame(width: 200, height: 50)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                
                Button("Go Back") {
                    avm.resetPassword()
                    avm.avatar = ""
                    isVisible = false
                }
                    .foregroundColor(.white)
                    .font(.system(size: 25.0))
                    .frame(width: 150, height: 50)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            .padding()
            Spacer()
        }
        .transition(.scale)
        .background(.cyan)
        .alert("Invalid UserName or Password",
               isPresented: $avm.invalid) {
            Button("Dismiss", action: avm.resetPassword)
        }
    }
}

struct UserImage: View {
    var userImage: String
    var body: some View {
        if userImage != "" {
            Image(userImage)
                .resizable()
                .frame(width: 150, height: 150)
                .overlay(Circle().stroke(Color.orange, lineWidth: 3))
        } else {
            Image(systemName: "person")
                .resizable()
                .frame(width: 100, height: 100)
        }
    }
}

#Preview {
    View_User()
        .environmentObject(AuthViewModel())
        .environmentObject(MediaViewModel())
}
