//
//  MessageViewModel.swift
//  DatingApp
//
//  Created by Radley Hoang on 03/01/2022.
//

import UIKit
import Combine

class MessageViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var keyboardIsShowing: Bool = false
    @Published var match: Match
    
    var cancellable: AnyCancellable? = nil
        
    init(match: Match) {
        self.match = match
        getHistoryChat()
        setupPublishers()
//        messages = mockMessages()
    }
    
    func sendMessage(_ message: Message) {
        // Networking
        messages.append(message)
        // if networking failure, then show an error with some retry options
    }
    
    private let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map({ _ in true })
    
    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map({ _ in true })
    
    private func setupPublishers() {
        cancellable = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: DispatchQueue.main)
            .assign(to: \.keyboardIsShowing, on: self)
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func mockMessage(_ content: String) -> Message {
        var message = Message()
        message.messageContent = content
        return message
    }
    
//    func mockMessages() -> [Message] {
//        var message1 = Message()
//        message1.messageContent = "Siêu phẩm quần jean nam lưng thun theo phong cách Hàn Quốc đang làm mưa làm gió nay về rồi ạ."
//
//        var message2 = Message()
//        message2.messageContent = "Lên form cực chuẩn luôn nè 🥰🥰🥰. Đủ size cho anh em luôn nha."
//
//        return [message1, message2, message1, message2, message1, message2]
//    }
}

// MARK: - API
extension MessageViewModel {
    private func getHistoryChat() {
        Helper.showProgress()
        ChatAPIManager.shared.getHistoryChat(withMatchId: match.id) { [weak self] messages, error in
            Helper.dismissProgress()
            guard let self = self else { return }
            if let error = error {
                Helper.showProgressError(error.localizedDescription)
            } else if let messages = messages {
                self.messages = messages
            }
        }
    }
}

// MARK: - Helper
extension MessageViewModel {
    func getImageUrl() -> URL? {
        guard !match.likedUser.images.isEmpty else { return nil }
        for image in match.likedUser.images {
            if let imageUrl = URL(string: image) {
                return imageUrl
            }
        }
        
        return nil
    }
    
    func getLikedName() -> String {
        return match.likedUser.name
    }
}
