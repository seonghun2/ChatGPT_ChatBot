//
//  Router.swift
//  ChatGPT
//
//  Created by user on 2023/02/16.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case sendMessage(message: String, apiKey: String)
    
    var url: URL {
        return URL(string: "https://api.openai.com/v1/completions")!
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .post
        }
    }
    
    var header: HTTPHeaders {
        switch self {
        case .sendMessage(_, let apiKey):
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(apiKey)"]
        }
    }
    
    var parameter: Parameters {
        switch self {
        case .sendMessage(let message, _):
            return [
                "model": "text-davinci-003",
                "prompt": "\(message)",
                "temperature": 0,
                "max_tokens": 10
                ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        
        request.method = method
        
        request.headers = header
        
        request.httpBody = try JSONEncoding.default.encode(request, with: parameter).httpBody
        
        return request
    }
}
