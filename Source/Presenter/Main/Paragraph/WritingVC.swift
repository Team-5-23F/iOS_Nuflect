//
//  WritingVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/19/24.
//

import UIKit
import SnapKit

class WritingVC: UIViewController {
    //MARK: - Properties
    //will get from OutlineVC
    lazy var paragraphTitle : String = "ParagraphTitle"
    
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //writing title
    lazy var writingTitle: UILabel = {
        let label = UILabel()
        label.text = paragraphTitle + "\n단락의 내용을 작성해주세요"
        label.numberOfLines = 2
        label.font = UIFont.Nuflect.headtitlebold
        
        return label
    }()
    
    //writing introduction label
    lazy var writingIntroductionLabel: UILabel = {
        let label = UILabel()
        label.text = "작성한 단락의 번역 초안과\n번역으로 인해 생기는 뉘양스 차이 및\n의미적 모호성을 해소할 피드백을 드릴게요."
        label.numberOfLines = 3
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        label.backgroundColor = UIColor.Nuflect.infoYellow
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        
        return label
    }()
    
    //writing textView
    lazy var writingTextView: UITextView = {
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
    
    //request button
    lazy var requestButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.Nuflect.lightGray
        button.layer.cornerRadius = 11
        
        button.setTitle("번역 및 피드백 요청", for: .normal)
        button.setTitleColor(UIColor.Nuflect.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.subheadMedium
        
        // Highlighted
        let iamge = image(withColor: .Nuflect.mainBlue!)
        button.setBackgroundImage(iamge, for: .highlighted)
        button.setTitleColor(UIColor.Nuflect.white, for: .highlighted)
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(requestButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    //MARK: - Properties
    lazy var placeholder = paragraphTitle + " 단락의 내용을 작성해주세요"
    
    
    //MARK: - Define Method
    @objc func backButtonTapped() {
        print("back tapped")
    }
    
    @objc func mypageButtonTapped() {
        print("mypage tapped")
    }
    
    @objc func requestButtonTapped() {
        print("request tapped")
        let VC = FeedbackVC()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    //MARK: - Set Ui
    func setView() {
        setNavigationBar()
        addSubView()
        self.view.backgroundColor = UIColor.Nuflect.white
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
        [navigationBar, writingTitle, writingIntroductionLabel, writingTextView, requestButton].forEach { view in
            self.view.addSubview(view)
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
        
        writingTitle.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(top / 2)
            make.leading.equalToSuperview().offset(titleLeading)
        }
        
        writingIntroductionLabel.snp.makeConstraints { make in
            make.top.equalTo(writingTitle.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(110)
        }
        
        writingTextView.snp.makeConstraints { make in
            make.top.equalTo(writingIntroductionLabel.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.bottom.equalTo(requestButton.snp.top).offset(-top)
        }
        
        requestButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }
    }
  

}

//MARK: - extension
extension WritingVC: UITextViewDelegate {
    //TextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        ///placeholder
        if textView.text == placeholder {
            self.writingTextView.textColor = .Nuflect.black
            self.writingTextView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //set placeholder
        if writingTextView.text.isEmpty {
            self.writingTextView.textColor = UIColor.Nuflect.darkGray
            self.writingTextView.text = placeholder
        }
        
        //get inputs in textview, activate the button
        if writingTextView.text.isEmpty || writingTextView.text == placeholder {
            requestButton.backgroundColor = .Nuflect.lightGray
            requestButton.setTitleColor(.Nuflect.darkGray, for: .normal)
            requestButton.isEnabled = false
        } else {
            requestButton.backgroundColor = .Nuflect.mainBlue
            requestButton.setTitleColor(.Nuflect.white, for: .normal)
            requestButton.isEnabled = true
        }
    }
}
