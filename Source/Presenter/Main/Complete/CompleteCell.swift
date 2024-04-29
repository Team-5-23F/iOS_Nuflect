//
//  CompleteCell.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 4/7/24.
//
import UIKit
import SnapKit

class CompleteCell: UICollectionViewCell {
    //MARK: - UI ProPerties
    lazy var paragraphTitle: UILabel = {
        let label = UILabel()
        label.text = "Paragraph"
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var paragraphContent: UILabel = {
        let label = UILabel()
        label.text = "content\n\ncontent"
        label.font = UIFont.Nuflect.baseMedium
        label.textColor = UIColor.Nuflect.black
        label.numberOfLines = 0
        
        return label
    }()
    
    //MARK: - Define Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
//        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set Ui
    func setView(){
        self.layer.cornerRadius = 12
        self.backgroundColor = .Nuflect.inputBlue
    }
    
    func addsubview() {
        [paragraphTitle, paragraphContent].forEach { view in
            self.addSubview(view)
        }
    }
    
    func setConstraint(){
        paragraphTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
        }
        
        paragraphContent.snp.makeConstraints { make in
            make.top.equalTo(paragraphTitle.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(23)
            make.trailing.equalToSuperview().offset(-23)
        }
        
    }
}
