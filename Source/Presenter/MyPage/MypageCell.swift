//
//  MypageCell.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 5/7/24.
//

import Foundation
import UIKit

class MypageCell: UICollectionViewCell {
    //MARK: - UI ProPerties
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor.Nuflect.black
        label.numberOfLines = 1
        label.font = UIFont.Nuflect.baseMedium
        
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        let next = UIImage(systemName: "chevron.right")
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:16, height: 16), false, 0.0)
        next?.draw(in: CGRect(x: 0, y: 0, width: 16, height: 16))
        let resizedNext = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        button.tintColor = UIColor.Nuflect.black
        button.setBackgroundImage(resizedNext, for: .normal)
        button.backgroundColor = UIColor.clear
        
        button.isEnabled = false
        
        return button
    }()
    
    //MARK: - Define Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set Ui
    func setView(){
//        self.backgroundColor = .Nuflect.white
        addsubview()
        
        
    }
    
    func addsubview() {
        [textLabel, nextButton].forEach { view in
            self.addSubview(view)
        }
    }
    
    func setConstraint(){
        textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
}
