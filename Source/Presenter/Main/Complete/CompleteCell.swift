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
    lazy var paragraphTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Paragraph"
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var paragraphTextLabel: UILabel = {
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
        addsubview()
        setConstraint()
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
        [paragraphTitleLabel, paragraphTextLabel].forEach { view in
            self.addSubview(view)
        }
    }
    
    func setConstraint(){
        let top = 18
        let leading = 23
        
        paragraphTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        paragraphTextLabel.snp.makeConstraints { make in
            make.top.equalTo(paragraphTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.bottom.equalToSuperview().offset(-top)
        }
        
    }
}
