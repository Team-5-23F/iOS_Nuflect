//
//  OutlineCell.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/20/24.
//

import UIKit
import SnapKit

class OutlineCell: UICollectionViewCell {
    //delegate for more button
    weak var delegate: outlineCollectionViewCellDelegate?
    
    lazy var cellNum: Int = 0
    
    //MARK: - UI ProPerties
    lazy var paragraphTitle: UILabel = {
        let label = UILabel()
        label.text = "Paragraph"
        label.font = UIFont.Nuflect.subtitleBold
        label.textColor = UIColor.Nuflect.black
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        let more = UIImage(systemName: "ellipsis.circle")
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:24, height: 24), false, 0.0)
        more?.draw(in: CGRect(x: 0, y: 0, width: 24, height: 24))
        let resizedMore = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        button.tintColor = UIColor.Nuflect.black
        button.setBackgroundImage(resizedMore, for: .normal)
        button.backgroundColor = UIColor.Nuflect.white
        
        let selectedMenu = {(action: UIAction) in
            print(action.title)
            //delegate func to OutlineVC
            self.delegate?.moreOptionTapped(cellNum: self.cellNum, selectedOption: action.title)
        }
        
        button.menu = UIMenu(children: [
            UIAction(title: "단락 쓰기", state: .off, handler: selectedMenu),
            UIAction(title: "이름 변경", state: .off, handler: selectedMenu),
            UIAction(title: "순서 변경", state: .off, handler: selectedMenu),
            UIAction(title: "단락 삭제", attributes: .destructive, state: .off, handler: selectedMenu),
        ])
        
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = false
        
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
        self.layer.cornerRadius = 12
        self.backgroundColor = .Nuflect.white
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.Nuflect.mainBlue?.cgColor
        addsubview()
        
        
    }
    
    func addsubview() {
        [paragraphTitle, moreButton].forEach { view in
            self.addSubview(view)
        }
    }
    
    func setConstraint(){
        paragraphTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(moreButton).offset(-25)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-25)
            make.centerY.equalToSuperview()
        }
        
    }
}


protocol outlineCollectionViewCellDelegate: AnyObject {
    func moreOptionTapped(cellNum: Int, selectedOption: String)
}

