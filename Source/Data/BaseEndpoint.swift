//
//  BaseEndpoint.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 4/26/24.
//

import Foundation

enum BaseEndpoint {
    
    case login
    case outline
    case translate
    case feedbackAll
    case feedbackOne

    var requestURL:String {
        switch self {
        case.login: return URL.getEndpointString("/api/login")
        case.outline: return URL.getEndpointString("/api/outline")
        case.translate: return URL.getEndpointString("/api/translate")
        case.feedbackAll: return URL.getEndpointString("/api/feedback/all")
        case.feedbackOne: return URL.getEndpointString("/api/feedback")
        }
    }
}
