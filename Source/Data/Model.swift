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
//    let Sentence: String
//    let Writing: String
}

//func callrequest() {
//    
//    guard let buildingprice = buildingPrice else {return}
//    
//    print(buildingprice)
//    
//    let parameters = [
//        
//        "buildingId": buildingprice.buildingId,
//        "collateral": removedecimalPoint(MortgagePrice.textInputTextField.text ?? "00") ?? 0,
//        "deposit": removedecimalPoint(charterPrice.textInputTextField.text ?? "00") ?? 0,
//        "isDangerous": true,
//        
//    ] as [String : Any]
//    
//    print(parameters)
//    
//    APIManger.shared.callPostRequest(baseEndPoint: .calculate, addPath: "", parameters: parameters) { JSON in
//        
//        if JSON["check"].boolValue == false {
//            self.showCustomAlert(alertType: .done,
//                            alertTitle: "오류 발생",
//                            alertContext: "다시 시도해주세요.",
//                            confirmText: "확인")
//            return
//        }
//                    
//        let id = JSON["information"]["id"].intValue
//        let buildingId = JSON["information"]["buildingId"].intValue
//        let collateral = JSON["information"]["collateral"].intValue
//        let deposit = JSON["information"]["deposit"].intValue
//        let isDangerous = JSON["information"]["isDangerous"].boolValue
//        
//        self.postCalculate = PostCalculate(id: id, buildingId: buildingId, collateral: collateral, deposit: deposit, isDangerous: isDangerous)
//        self.showCustomAlert(alertType: .done,
//                             alertTitle: "근저당액, 전세금 입력완료",
//                             alertContext: "정상적으로 제출되었습니다.",
//                             confirmText: "확인")
//    }
//}
