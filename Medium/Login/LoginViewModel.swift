//
//  LoginViewModel.swift
//  Medium
//
//  Created by Glny Gl on 29/11/2024.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    
    @Published var mail: String = ""
    @Published var password: String = ""
    
    @Published var mailWarning: String = ""
    @Published var passwordWarning: String = ""
    
    @Published var isButtonDisabled = true
    
    private var cancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        subscribeToMail()
        subscribeToPassword()
        subscribeToAll()
    }
    
    private func subscribeToMail() {
        $mail
            .map { mail in
                return mail.isEmpty || mail.contains("@gmail.com") ? "" : "Enter your gmail address"
            }
            .sink { [weak self] mailWarning in
                self?.mailWarning = mailWarning
            }
            .store(in: &cancellables)
    }
    
    private func subscribeToPassword() {
        $password
            .map { password in
                return password.isEmpty || password.count >= 6 ? "" : "Password should be at least 6 characters"
            }
            .sink { [weak self] passwordWarning in
                self?.passwordWarning = passwordWarning
            }
            .store(in: &cancellables)
    }
    
    private func subscribeToAll() {
        $mail
            .combineLatest($password)
            .map { mail, password in
               return ( mail.contains("@gmail.com") &&  password.count >= 6 )
            }
            .assign(to: &$isButtonDisabled)
    }
    
    private func subscribeToAll2() {
        $mail
            .combineLatest($password)
            .map { mail, password in
               return ( mail.contains("@gmail.com") &&  password.count >= 6 )
            }
            .assign(to: \.isButtonDisabled, on: self)
            .store(in: &cancellables)
    }
    
}
