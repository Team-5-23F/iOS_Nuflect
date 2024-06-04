//
//  BookmarkParagraphCell.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 5/15/24.
//

import UIKit
import SnapKit

class BookmarkParagraphCell: UICollectionViewCell {
    //delegate for more button
    weak var delegate: moreOptionDelegate?
    
    lazy var bookmarkedParagraphNum: Int = 0
    
    //MARK: - UI ProPerties
    lazy var formatLabel: UILabel = {
        let label = UILabel()
        label.text = "Format : "
        label.font = UIFont.Nuflect.subtitleSemiBold
        label.textColor = UIColor.Nuflect.black
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var purposeLabel: UILabel = {
        let label = UILabel()
        label.text = "Purpose : "
        label.font = UIFont.Nuflect.subtitleSemiBold
        label.textColor = UIColor.Nuflect.black
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var paragraphLabel: UILabel = {
        let label = UILabel()
        label.text = "Paragraph : "
        label.font = UIFont.Nuflect.subtitleSemiBold
        label.textColor = UIColor.Nuflect.black
        label.numberOfLines = 1
        
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
        button.backgroundColor = UIColor.clear
        
        let selectedMenu = {(action: UIAction) in
            print(action.title)
            //delegate func to BookmarkParagraphVC
            self.delegate?.moreOptionTapped(cellNum: self.bookmarkedParagraphNum, selectedOption: action.title)
        }
        
        button.menu = UIMenu(children: [
            UIAction(title: "단락 보기", state: .off, handler: selectedMenu),
            UIAction(title: "단락 복사", state: .off, handler: selectedMenu),
            UIAction(title: "북마크 해제", attributes: .destructive, state: .off, handler: selectedMenu),
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
        [formatLabel, purposeLabel, paragraphLabel, moreButton].forEach { view in
            self.addSubview(view)
        }
    }
    
    func setConstraint(){
        formatLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(18)
            make.trailing.equalTo(moreButton).offset(-25)
        }
        
        purposeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(moreButton).offset(-25)
        }
        
        paragraphLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-18)
            make.trailing.equalTo(moreButton).offset(-25)
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-25)
            make.centerY.equalToSuperview()
        }
        
    }
}
