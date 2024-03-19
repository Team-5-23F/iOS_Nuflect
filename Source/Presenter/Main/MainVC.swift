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
    lazy var introductionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.Nuflect.mainBlue
        button.layer.cornerRadius = 18
        button.addTarget(self, action: #selector(introductionButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var introductionTitle: UILabel = {
        let label = UILabel()
        label.text = "What is Nuflect?"
        label.font = UIFont.Nuflect.headtitlebold
        label.textColor = UIColor.Nuflect.white
        
        return label
    }()
    
    lazy var introductionContent: UILabel = {
        let label = UILabel()
        label.text = "번역으로 인해 발생하는 뉘양스 차이를\nNuflect가 찾아서 교정해드려요"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.Nuflect.subheadMedium
        label.textColor = UIColor.Nuflect.white
        
        return label
    }()
    
    lazy var introductionMore: UILabel = {
        let label = UILabel()
        label.text = "더 알아보기 >"
        label.font = UIFont.Nuflect.smallRegular
        label.textColor = UIColor.Nuflect.white
        
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
    lazy var perposeTextView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.text = placeholder
        textView.font = UIFont.Nuflect.baseMedium
        textView.textColor = UIColor.Nuflect.darkGray
        textView.backgroundColor = UIColor.Nuflect.inputBlue
        textView.layer.cornerRadius = 8
        textView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        textView.textContainerInset = .init(top: 18, left: 23, bottom: 18, right: 23)
        textView.scrollIndicatorInsets = .init(top: 18, left: 10, bottom: 18, right: 23)
        
        return textView
    }()
    
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
        
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
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
    
    @objc func introductionButtonTapped() {
        print("introduction tapped")
    }
    
    @objc func startButtonTapped() {
        print("start tapped")
    }
    
    //MARK: - Properties
    lazy var placeholder = "구체적으로 작성할 수록\n적절한 번역이 제공됩니다."
    
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
        [navigationBar, introductionButton, perposeTitle, perposeTextView, startButton].forEach { view in
            self.view.addSubview(view)
        }
        
        [introductionTitle, introductionContent, introductionMore].forEach { view in
            self.introductionButton.addSubview(view)
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
        
        introductionButton.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(160)
        }
        
        introductionTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        introductionContent.snp.makeConstraints { make in
            make.top.equalTo(introductionTitle.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        introductionMore.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        
        perposeTitle.snp.makeConstraints { make in
            make.top.equalTo(introductionButton.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(titleLeading)
        }
        
        perposeTextView.snp.makeConstraints { make in
            make.top.equalTo(perposeTitle.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(200)
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
    }
  

}

//MARK: - extension
extension MainVC: UITextViewDelegate {
    //TextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        ///placeholder
        if textView.text == placeholder {
            self.perposeTextView.textColor = .Nuflect.black
            self.perposeTextView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //set placeholder
        if perposeTextView.text.isEmpty {
            self.perposeTextView.textColor = UIColor.Nuflect.darkGray
            self.perposeTextView.text = placeholder
        }
        
        //get inputs in textview, activate the button
        if perposeTextView.text.isEmpty || perposeTextView.text == placeholder {
            startButton.backgroundColor = .Nuflect.lightGray
            startButton.setTitleColor(.Nuflect.darkGray, for: .normal)
            startButton.isEnabled = false
        } else {
            startButton.backgroundColor = .Nuflect.mainBlue
            startButton.setTitleColor(.Nuflect.white, for: .normal)
            startButton.isEnabled = true
        }
    }
}
