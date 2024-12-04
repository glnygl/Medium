//
//  NewLoginView.swift
//  Medium
//
//  Created by Glny Gl on 02/12/2024.
//

import SwiftUI
import Combine

struct NewLoginView: View {
    
    @State var viewModel = NewLoginViewModel()
    
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
            .disabled(!viewModel.isButtonEnabled)
        }
        .padding()
    }
}

#Preview {
    NewLoginView()
}
