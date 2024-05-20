//
//  CompleteCell.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 4/7/24.
//
import UIKit
import SnapKit

class CompleteCell: UICollectionViewCell {
    //delegate for more button
    weak var delegate: moreOptionDelegate?
    
    lazy var paragraphNum: Int = 0
    
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
            //delegate func to CompleteVC
            self.delegate?.moreOptionTapped(cellNum: self.paragraphNum, selectedOption: action.title)
        }
        
        button.menu = UIMenu(children: [
            UIAction(title: "북마크 등록/해제", state: .off, handler: selectedMenu),
            UIAction(title: "단락 복사", state: .off, handler: selectedMenu)
        ])
        
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = false
        
        return button
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
        [paragraphTitleLabel, paragraphTextLabel, moreButton].forEach { view in
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
        
        moreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(top)
            make.trailing.equalToSuperview().offset(-leading)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
    }
}
