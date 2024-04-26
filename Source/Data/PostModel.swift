//
//  PostModel.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 4/26/24.
//

import Foundation

// PostFormatPurpose
struct PostFormat_Purpose: Codable {
    let Format: String
    let purpose: String
}

// PostRawText
struct PostRawText: Codable {
    let rawText: String
}
