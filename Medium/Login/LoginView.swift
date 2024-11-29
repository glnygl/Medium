//
//  LoginView.swift
//  Medium
//
//  Created by Glny Gl on 29/11/2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 30) {
            
            TextField("Mail", text: $viewModel.mail)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .showWarning(viewModel.mailWarning)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
                .showWarning(viewModel.passwordWarning)
            
            Button("Login") {
                print("Login Successful!")
            }
            .buttonStyle(.borderedProminent)
            .disabled(!viewModel.isButtonDisabled)
        }
        .padding()
    }
}

struct WarningModifier: ViewModifier {
    let warning: String
    
    @ViewBuilder
    func body(content: Content) -> some View {
        content.overlay(alignment: .leadingFirstTextBaseline) {
            Text(warning)
                .font(.system(size: 12).bold())
                .foregroundStyle(.gray)
                .offset(y: 24)
        }
    }
}

extension View {
    func showWarning(_ warning: String) -> some View {
        ModifiedContent(content: self, modifier: WarningModifier(warning: warning)
        )
    }
}

#Preview {
    LoginView()
}
