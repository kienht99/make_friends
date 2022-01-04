//
//  MessageCellViewModel.swift
//  DatingApp
//
//  Created by Radley Hoang on 03/01/2022.
//

import SwiftUI

class MessageCellViewModel: ObservableObject {
    @Published var message: Message
    @Published var fromCurrentUser: Bool = .random()
    
    init(_ message: Message) {
        self.message = message
    }
}