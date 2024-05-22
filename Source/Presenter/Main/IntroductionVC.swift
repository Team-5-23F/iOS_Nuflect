//
//  IntroductionVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 5/21/24.
//

import Foundation
import UIKit

class IntroductionVC: UIViewController, UIScrollViewDelegate {
    //MARK: - Properties
    
    // MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //스크롤을 위한 스크롤 뷰
    lazy var scrollView:UIScrollView = {
        let view = UIScrollView()
        
        // 필요시 true로 수정
//        view.isScrollEnabled = false
        
        return view
    }()
    
    //스크롤 뷰 안에 들어갈 내용을 표시할 뷰
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img_logo"))
        
        return imageView
    }()
    
    //introduction title
    lazy var introductionTitle: UILabel = {
        let label = UILabel()
        label.text = "뉘앙스까지 섬세하게 번역\nNuflect"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.Nuflect.headtitlebold
        
        return label
    }()
    
    //abstraction label
    lazy var abstractionLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Abstraction of our service...\n...\n..."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.Nuflect.subtitleSemiBold
        label.textColor = UIColor.Nuflect.black
        label.backgroundColor = UIColor.Nuflect.infoYellow
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        
        return label
    }()
    
    //detail label
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Detailed introduction of our service...\n.\n..\n...\n....\n.....\n......\n..\n..\n..\n..\n..\n..\n..\n..\n..\n.."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.Nuflect.subheadMedium
        label.textColor = UIColor.Nuflect.black
        
        return label
    }()
    
    //to main button
    lazy var toMainButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.Nuflect.mainBlue
        button.layer.cornerRadius = 11
        
        button.setTitle("메인으로", for: .normal)
        button.setTitleColor(UIColor.Nuflect.white, for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.subheadMedium
        
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Define Method
    @objc func backButtonTapped() {
        print("back tapped")
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    //VC의 view 관련 설정
    func setView() {
        setNavigationBar()
        addSubView()
        self.view.backgroundColor = UIColor.Nuflect.white
    }
    
    //Set scrollview size to fit contentView
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = logoImageView.frame.height + introductionTitle.frame.height + abstractionLabel.frame.height + detailLabel.frame.height + toMainButton.frame.height + 780
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(height)
        }
        scrollView.contentSize = contentView.frame.size
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        
        //back (left)
        let back = UIImage(systemName: "chevron.backward")
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 20, height: 20), false, 0.0)
        back?.draw(in: CGRect(x: 0, y: 0, width: 20, height: 20))
        let resizedBack = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let backImage = resizedBack?.withRenderingMode(.alwaysOriginal)

        let leftButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))

        navigationItem.leftBarButtonItem = leftButton
        
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = .Nuflect.white // 배경색 변경
        navigationBar.tintColor = .clear
        navigationBar.shadowImage = UIImage() // 테두리 없애기
    }

    func addSubView() {
        [navigationBar, scrollView].forEach { view in
            self.view.addSubview(view)
        }
        
        [contentView].forEach { view in
            scrollView.addSubview(view)
        }
        
        [logoImageView, introductionTitle, abstractionLabel, detailLabel, toMainButton].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
        let leading = 16
        let textLeading = 35
        let top = 30
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
//        contentView.snp.makeConstraints { make in
//            make.width.equalTo(view.snp.width)
//            make.height.equalTo(height)
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(top)
            make.height.equalTo(170)
            make.width.equalTo(170)
            make.centerX.equalToSuperview()
        }
        
        introductionTitle.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(top)
            make.centerX.equalToSuperview()
        }
        
        abstractionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(introductionTitle.snp.bottom).offset(top)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(textLeading)
            make.trailing.equalToSuperview().offset(-textLeading)
            make.top.equalTo(abstractionLabel.snp.bottom).offset(top)
        }
        
        toMainButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(53)
            make.top.equalTo(detailLabel.snp.bottom).offset(50)
        }
    }
}
