//
//  ShowToast.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 5/12/24.
//

import UIKit

extension UIViewController {
    static let shared = UIViewController()
    
    public func showToast(message: String, duration: TimeInterval = 2.0, delay: TimeInterval = 0.5) {
        let height = self.view.frame.size.height
        let width = self.view.frame.size.width
        
        // 토스트 메시지를 표시할 레이블 생성
        let toastLabel = UILabel()
        toastLabel.numberOfLines = 0 // 여러 줄로 표시 가능하도록 설정
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.Nuflect.subheadMedium
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        // 토스트 메시지 레이블의 크기 계산
        let maxSize = CGSize(width: width - 40, height: height - 100)
        let expectedSize = toastLabel.sizeThatFits(maxSize)
        
        // 토스트 메시지 레이블의 위치 및 크기 설정
        toastLabel.frame = CGRect(x: (width - expectedSize.width - 20) / 2,
                                   y: height - expectedSize.height - 50,
                                   width: expectedSize.width + 20,
                                   height: expectedSize.height + 10)
        
        // 레이블을 뷰에 추가
        self.view.addSubview(toastLabel)
        
        // 토스트 메시지가 나타나고 사라지는 애니메이션
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

func copyToClipboardAndShowToast(text: String, viewController: UIViewController) {
    // UIPasteboard 인스턴스 생성
    let pasteboard = UIPasteboard.general
    
    // 클립보드에 문자열 복사
    pasteboard.string = text
    
    // 토스트 메시지 표시
    viewController.showToast(message: "클립보드에 복사되었습니다")
}
