//
//  NewLoginViewModel.swift
//  Medium
//
//  Created by Glny Gl on 02/12/2024.
//

import Foundation
import Combine

@Observable
final class NewLoginViewModel {
    
    //    MARK: @ObservationIgnored
    //    @ObservationIgnored
    //    @Published
    //    var mail: String = ""
    
    @ObservationIgnored
    @Published
    var loginCount: Int = 0
    
    var mail: String = "" {
        didSet {
            guard oldValue != mail else { return }
            mailPublisher.send(mail)
        }
    }
    
    var password: String = "" {
        didSet {
            guard oldValue != password else { return }
            passwordPublisher.send(password)
        }
    }
    
    private let mailPublisher = PassthroughSubject<String, Never>()
    private let passwordPublisher = PassthroughSubject<String, Never>()
    
    
    private var cancellables = Set<AnyCancellable>()
    
    var mailWarning: String = ""
    var passwordWarning: String = ""
    
    var isButtonEnabled = false
    
    init() {
        subscribeToMail()
        subscribeToPassword()
        subscribeToAll()
    }
    
    private func subscribeToMail() {
        mailPublisher
            .map { mail in
                return mail.isEmpty || mail.contains("@gmail.com") ? "" : "Enter your gmail address"
            }
            .sink { [weak self] mailWarning in
                self?.mailWarning = mailWarning
            }
            .store(in: &cancellables)
    }
    
    private func subscribeToPassword() {
        passwordPublisher
            .map { password in
                return password.isEmpty || password.count >= 6 ? "" : "Password should be at least 6 characters"
            }
            .sink { [weak self] passwordWarning in
                self?.passwordWarning = passwordWarning
            }
            .store(in: &cancellables)
    }
    
    private func subscribeToAll() {
        mailPublisher
            .combineLatest(passwordPublisher)
            .map { mail, password in
                return ( mail.contains("@gmail.com") &&  password.count >= 6 )
            }
            .assign(to: \.isButtonEnabled, on: self)
            .store(in: &cancellables)
    }
    
    // MARK: Other examples
    
    private func subscribeToLoginCount() {
        $loginCount
            .sink { value in
                print(value)
            }
            .store(in: &cancellables)
    }
    
    // Create CurrentValueSubject
    
    var userName: String = "" {
        didSet {
            guard oldValue != userName else { return }
            userNamePublisher.send(userName)
        }
    }
    
    private let userNamePublisher = CurrentValueSubject<String, Never>("")
    
    var userNameWarning: String = ""
    
    private func subscribeToUserName() {
        userNamePublisher
            .map { userName in
                return userName.isEmpty || userName.count > 6 ? "" : "Enter valid userName"
            }
            .sink { [weak self] userNameWarning in
                self?.userNameWarning = userNameWarning
            }
            .store(in: &cancellables)
    }
    
    // Send completion status
    
    enum CustomError: Error {
        case failed
    }
    
    private let customPublisher = PassthroughSubject<String, Error>()
    
    private func sendCompletion() {
        customPublisher.send(completion: .finished)
    }
    
    private func sendError() {
        customPublisher.send(completion: .failure(CustomError.failed))
    }
    
    private func sendValueWithFunction() {
        userNamePublisher.send("Mary")
    }
    
    private func sendValueDirectly() {
        userNamePublisher.value = "Jane"
    }
}
