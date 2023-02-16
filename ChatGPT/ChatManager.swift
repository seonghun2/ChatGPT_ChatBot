//
//  GPTManager.swift
//  ChatGPT
//
//  Created by user on 2023/02/15.
//

import Foundation
import RxSwift
import RxRelay

class ChatManager {
    static let shared = ChatManager()
    
    private init() {}
    
    var receivedMessage = PublishRelay<String>()
    
    let disposeBag = DisposeBag()
    
    func sendMessage(message: String) {
        ChatAPI.sendMessage(message: message)
            .compactMap{ $0.choices?[0].text }
            .subscribe { messageString in
                self.receivedMessage.accept(messageString)
            }.disposed(by: disposeBag)
    }
}
