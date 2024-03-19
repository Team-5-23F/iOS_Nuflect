//
//  MainVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/18/24.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //introduction button
    lazy var introductionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = UIColor.Nuflect.mainBlue
        
        return view
    }()
    
    lazy var introductionTitle: UILabel = {
        let label = UILabel()
        label.text = "What is Nuflect?"
        label.font = UIFont.Nuflect.headtitlebold
        
        return label
    }()
    
    lazy var introductionContent: UILabel = {
        let label = UILabel()
        label.text = "번역으로 인해 발생하는\n뉘양스 차이를 찾아드릴게요"
        label.numberOfLines = 2
        label.font = UIFont.Nuflect.subtitleRegular
        
        return label
    }()
    
    lazy var introductionMore: UILabel = {
        let label = UILabel()
        label.text = "더 알아보기 >"
        label.font = UIFont.Nuflect.tinyRegular
        
        return label
    }()
    
    //perpose title
    lazy var perposeTitle: UILabel = {
        let label = UILabel()
        label.text = "글쓰기에 앞서\n글의 목적을 입력해주세요"
        label.numberOfLines = 2
        label.font = UIFont.Nuflect.headtitlebold
        
        return label
    }()
    
    //perpose textView
    
    //start button
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.Nuflect.lightGray
        button.layer.cornerRadius = 11
        
        button.setTitle("글쓰기 시작", for: .normal)
        button.setTitleColor(UIColor.Nuflect.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.subheadMedium
        
        // Highlighted
        let iamge = image(withColor: .Nuflect.mainBlue!)
        button.setBackgroundImage(iamge, for: .highlighted)
        button.setTitleColor(UIColor.Nuflect.white, for: .highlighted)
        button.isEnabled = false
        
//        button.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    @objc func logoButtonTapped() {
        print("logo tapped")
    }
    
    @objc func mypageButtonTapped() {
        print("mypage tapped")
    }
    
    //MARK: - Properties
    
    
    //MARK: - Set Ui
    func setView() {
        setNavigationBar()
        addsubview()
        self.view.backgroundColor = UIColor.Nuflect.white
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        
//        //title (center)
//        navigationItem.title = "Nuflect"
//        navigationBar.titleTextAttributes = [
//            .foregroundColor: UIColor.black,
//            .font: UIFont.Nuflect.headtitleSemiBold
//        ]
        
        //logo (left)
        let logo = UIImage(named: "Logo")
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 33, height: 33), false, 0.0)
        logo?.draw(in: CGRect(x: 0, y: 0, width: 33, height: 33))
        let resizedLogo = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let logoImage = resizedLogo?.withRenderingMode(.alwaysOriginal)
        
        let leftButton = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: #selector(logoButtonTapped))
        
        //mypage button (right)
        let mypage = UIImage(systemName: "person.circle")
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 33, height: 33), false, 0.0)
        mypage?.draw(in: CGRect(x: 0, y: 0, width: 33, height: 33))
        let resizedMypage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let rightButton = UIBarButtonItem(image: resizedMypage, style: .plain, target: self, action: #selector(mypageButtonTapped))
        rightButton.tintColor = UIColor.Nuflect.black
        
        
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = .Nuflect.white // 배경색 변경
        navigationBar.tintColor = .clear
        navigationBar.shadowImage = UIImage() // 테두리 없애기
    }
    
    func addsubview() {
        [navigationBar, introductionView, perposeTitle, /*textView,*/ startButton].forEach { view in
            self.view.addSubview(view)
        }
        
        [introductionTitle, introductionContent, introductionMore].forEach { view in
            self.introductionView.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
        let leading = 16
        let titleLeading = 35
        let top = 40
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        introductionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(170)
        }
        
        perposeTitle.snp.makeConstraints { make in
            make.top.equalTo(introductionView.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(titleLeading)
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
    }
  

}
