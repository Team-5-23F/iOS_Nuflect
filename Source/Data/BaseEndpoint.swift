//
//  BaseEndpoint.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 4/26/24.
//

import Foundation

enum BaseEndpoint {
    case user
    
    case outline
    
    case translate
    
    case feedback
    
    case myWriting
    case myParagraph
    
    
    var requestURL:String {
        switch self {
        case.user: return URL.getEndpointString("/users/")
            
        case.outline: return URL.getEndpointString("/apis/gpt/outline/")
            
        case.translate: return URL.getEndpointString("/apis/gpt/translate/")
            
        case.feedback: return URL.getEndpointString("/apis/gpt/feedback/")
            
        case.myWriting: return URL.getEndpointString("/mywriting/")
        case.myParagraph: return URL.getEndpointString("/myparagraph/")
        }
    }
}
