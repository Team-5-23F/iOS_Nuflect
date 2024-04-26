//
//  GetModel.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 4/26/24.
//

import Foundation

// GetOutline
struct GetOutline: Codable {
    let paragrahps: [String]
}

// GetFeedback
struct GetFeedback: Codable {
    let translation: String
    let feedbacks: [[String]]
}
