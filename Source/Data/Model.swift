//
//  Model.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 4/26/24.
//

import Foundation

// Post : outline
struct PostOutline: Codable {
    let Task: String
    let Context: String
}

// Post : translate
struct PostTranslate: Codable {
    let Text: String
}

// Post : feedback line
struct PostFeedbackLine: Codable {
    let Sentence: String
}

// Post : feedback writing
struct PostFeedbackWriting: Codable {
    let Writing: String
}

// Post : my writing
struct PostMyWriting: Codable {
    let format: String
    let purpose: String
    let paragraphs: [[String]]
}
