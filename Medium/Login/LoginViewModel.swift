//
//  LoginViewModel.swift
//  Medium
//
//  Created by Glny Gl on 29/11/2024.
//

import Foundation
import Combine

// MARK: Read Article
// https://medium.com/@glnygl94/using-observableobject-in-combine-swiftui-3-6b33dd51749f

final class LoginViewModel: ObservableObject {
    
//     MARK: Propery observers
//        @Published var mail: String = "" {
//            didSet {
//                guard oldValue != mail else { return }
//                mailWarning =  mail.isEmpty || mail.contains("@gmail.com") ? "" : "Enter your gmail address"
//            }
//        }
//    
//        @Published var password: String = "" {
//            didSet {
//                guard oldValue != password else { return }
//                passwordWarning = password.isEmpty || password.count >= 6 ? "" : "Password should be at least 6 characters"
//            }
//        }
    
    @Published var mail: String = ""
    @Published var password: String = ""
    
    @Published var mailWarning: String = ""
    @Published var passwordWarning: String = ""
    
    @Published var isButtonEnabled = false
    
    private var cancellable: AnyCancellable? // single cancellable
    private var cancellables = Set<AnyCancellable>() // cancellable set
    
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
            .assign(to: &$isButtonEnabled)
    }
    

    // MARK: Other examples
    
    private func subscribeToAll2() {
        $mail
            .combineLatest($password)
            .map { mail, password in
                return ( mail.contains("@gmail.com") &&  password.count >= 6 )
            }
            .assign(to: \.isButtonEnabled, on: self) // assign func has keyPath and root
            .store(in: &cancellables)
    }
    
    private func subscribeToAll3() {
        cancellable = $mail  // assign AnyCancellable object to cancellable propery to keep subscription alive so you dont have to use store func anymore
            .combineLatest($password)
            .map { mail, password in
                return ( mail.contains("@gmail.com") &&  password.count >= 6 )
            }
            .assign(to: \.isButtonEnabled, on: self)
    }
    
    private func subscribeToAll4() {
        Publishers.CombineLatest($mail, $password) // CombineLatest struct
            .map { mail, password in
                return ( mail.contains("@gmail.com") &&  password.count >= 6 )
            }
            .sink { [weak self] value in
                self?.isButtonEnabled = value
            }
            .store(in: &cancellables)
    }
    
}
