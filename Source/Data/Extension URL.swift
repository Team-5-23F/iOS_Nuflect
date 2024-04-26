//
//  Extension URL.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 4/26/24.
//

import Foundation

extension URL {
    static let baseURL = "192.168.0.1:8000"
    
    static func getEndpointString(_ endpoint:String) -> String {
        return baseURL + endpoint
    }
}
