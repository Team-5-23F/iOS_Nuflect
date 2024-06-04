//
//  PaddingLabel.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 4/29/24.
//

import Foundation
import UIKit

class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 18.0, left: 23.0, bottom: 23.0, right: 18.0)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
