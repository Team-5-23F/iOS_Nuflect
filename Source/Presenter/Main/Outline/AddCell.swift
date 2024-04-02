//
//  AddCell.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/30/24.
//

import UIKit
import SnapKit

class AddCell: UICollectionViewCell {
    //MARK: - UI ProPerties
    lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = UIColor.Nuflect.darkGray
        
        return imageView
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
        self.layer.cornerRadius = 12
        self.backgroundColor = .Nuflect.lightGray
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.Nuflect.darkGray?.cgColor
        addsubview()
        
        
    }
    
    func addsubview() {
        [plusImageView].forEach { view in
            self.addSubview(view)
        }
    }
    
    func setConstraint(){
        plusImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
    }
}
