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
        label.text = "Nuflect는 영어 작문에 어려움을 겪는 사람들을 위해 개발되었습니다.\n번역 과정에서 발생할 수 있는 뉘앙스 차이나 의미적 모호성을 파악해 오류 없이 글을 작성할 수 있도록 돕습니다."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.Nuflect.subheadMedium
        label.textColor = UIColor.Nuflect.black
        label.backgroundColor = UIColor.Nuflect.infoYellow
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        
        return label
    }()
    
    //detail label
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.text = "* 글의 형식과 목적에 맞는 Outline 추천\n* 번역과 취약 문장 성분 위주의 대체 표현 제공\n* 다채로운 표현을 위한 문장 별 대안 제공\n\n이런 상황 없었나요?\n번역기를 이용했지만, 번역된 결과가 내가 의도한 뉘앙스를 잘 담고 있을까 고민해보셨나요? 번역된 글에 적절치 못한 표현이 포함되어 오해가 생기진 않을까 걱정하셨나요? 아쉽게도 원어민이 아닌 우리는 모든 문장에 대해 분석하며 글을 쓰기 어렵습니다. 세심한 부분까지 모두 판단할 수 있는 영어 실력자라면, 번역기를 이용하지 않을거에요. 우리는 그러지 못한 사람을 위해 서비스를 제공합니다. 자세한 뉘앙스와 다채로운 표현까지도 여러분의 영작에 녹여내세요.\n\nNuflect는 다음과 같은 순서로 동작합니다.\n작성할 글의 형식과 목적을 입력하면 글의 개요를 추천해줍니다. 단락별로 글을 작성하시면 초기 번역 후 번역된 글을 모두 검사합니다. 이 단계에서 NLTK를 활용하여, 조동사나 시제, 전치사와 같이 뉘앙스의 차이를 크게 좌우할 수 있는 지점을 추출하여 프롬프트를 작성하는 것으로 뉘앙스 차이의 원인과 대체 표현, 달라진 부분들을 보다 정확하게 제공합니다.\n\n사용자가 또 다른 분석을 요청하는 경우, 선택한 문장을 단위로 하여, 동일한 의미를 가지는 문장을 생성하는 것으로, 관용표현이나 비유 은유적인 표현까지 반영할 수 있게 하여 더 다채로운 글의 구성을 가능합니다."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.Nuflect.baseMedium
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
        let height = logoImageView.frame.height + introductionTitle.frame.height + abstractionLabel.frame.height + detailLabel.frame.height + toMainButton.frame.height + 1030
        
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
            make.top.equalTo(detailLabel.snp.bottom).offset(30)
        }
    }
}
