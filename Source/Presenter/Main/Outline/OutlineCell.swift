//
//  OutlineCell.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/20/24.
//

import UIKit
import SnapKit

class OutlineCell: UICollectionViewCell {
    //MARK: - UI ProPerties
    lazy var paragraphTitle: UILabel = {
        let label = UILabel()
        label.text = "1. Paragraph"
        label.font = UIFont.Nuflect.subtitleBold
        label.textColor = UIColor.Nuflect.black
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        let more = UIImage(systemName: "ellipsis.circle")
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 25, height: 25), false, 0.0)
        more?.draw(in: CGRect(x: 0, y: 0, width: 25, height: 25))
        let resizedMypage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        button.backgroundColor = UIColor.Nuflect.white
        button.tintColor = UIColor.Nuflect.black
        button.setBackgroundImage(more, for: .normal)
        button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        let menu = PullDownMenu(frame: .zero) // Set frame later
          menu.configure(with: ["단락 쓰기", "이름 변경", "순서 변경", "단락 삭제"])
          menu.isHidden = true
          addSubview(menu)
        
        return button
    }()
    
    //MARK: - Define Method
    override init(frame: CGRect) {
        super.init(frame: frame)
        SetView()
        setConstraint()
    }
    
    @objc func moreButtonTapped(_ sender: UIButton) {
        print("more tapped")
        let menu = sender.superview?.subviews.compactMap { $0 as? PullDownMenu }.first
          menu?.isHidden.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set Ui
    func SetView(){
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
            make.trailing.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
        }
        
    }
}

//pull down button
class PullDownMenu: UIView {

  private var buttons: [UIButton] = []

  func configure(with items: [String]) {
    buttons.removeAll()
    for (index, item) in items.enumerated() {
      let button = UIButton(type: .system)
      button.setTitle(item, for: .normal)
      button.tag = index // Set tag to identify button index
      button.addTarget(self, action: #selector(menuItemTapped(_:)), for: .touchUpInside)
      addSubview(button)
      buttons.append(button)
      // Layout the buttons here (e.g., using a stack view)
    }
  }

  @objc func menuItemTapped(_ sender: UIButton) {
    // Handle menu item tap here (e.g., dismiss menu, perform action)
    print("Menu item \(sender.tag) tapped")
    self.isHidden = true // Hide the menu
  }
}
