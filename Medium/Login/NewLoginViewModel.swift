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
    
    var isButtonDisabled = true
    
    init() {
        subscribeToMail()
        subscribeToPassword()
        subscribeToAll()
    }
    
    private func subscribeToMail() {

    }
    
    private func subscribeToPassword() {
        
    }
    
    private func subscribeToAll() {
        
    }
    
}
