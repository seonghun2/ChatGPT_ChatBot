//
//  GPT_API.swift
//  ChatGPT
//
//  Created by user on 2023/02/15.
//

import Foundation
import RxSwift
import RxAlamofire

enum ChatAPI {
    
    static let apiKey = "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"

    static func sendMessage(message: String) -> Observable<MessageResponse> {
        let request = Router.sendMessage(message: message, apiKey: ChatAPI.apiKey)
        return RxAlamofire.requestData(request)
            .map { response, data in
                do {
                    let data = try JSONDecoder().decode(MessageResponse.self, from: data)
                    return data
                } catch {
                    print("decoding error!")
                    throw error
                }
            }
    }
}

//
//curl https://api.openai.com/v1/completions \
//-H "Content-Type: application/json" \
//-H "Authorization: Bearer YOUR_API_KEY" \
//-d '{"model": "text-davinci-003", "prompt": "Say this is a test", "temperature": 0, "max_tokens": 7}'
