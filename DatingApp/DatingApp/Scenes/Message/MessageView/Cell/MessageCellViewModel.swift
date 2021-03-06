//
//  MessageCellViewModel.swift
//  DatingApp
//
//  Created by Radley Hoang on 03/01/2022.
//

import SwiftUI

class MessageCellViewModel: ObservableObject {
    @Published var message: Message
    @Published var fromCurrentUser: Bool = false
    @Published var isShowCreatedTime = false
    @Published var isShowPhotoFullView = false
    @Published var isShowVideoFullView = false
    
    init(_ message: Message) {
        self.message = message
        fromCurrentUser = message.userId == AppData.shared.user.id
    }
    
    func toggleShowCreatedTime() {
        isShowCreatedTime.toggle()
    }
}
