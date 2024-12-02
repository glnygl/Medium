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
    
    var mail: String = ""
    {
        didSet {
            mailPublisher.send(mail)
        }
    }
    
    var password: String = ""
    {
        didSet {
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
