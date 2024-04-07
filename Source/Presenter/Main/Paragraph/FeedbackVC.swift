//
//  FeedbackVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/19/24.
//

import UIKit
import SnapKit

class FeedbackVC: UIViewController {
    //delegate for end button
    weak var delegate: returnToOutlineVCDelegate?
    
    //MARK: - Properties
    //will get from WritingVC
    lazy var paragraphNum: Int = 1
    
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //feedback title
    lazy var feedbackTitle: UILabel = {
        let label = UILabel()
        label.text = "피드백을 참고하며\n번역된 단락을 완성하세요"
        label.numberOfLines = 2
        label.font = UIFont.Nuflect.headtitlebold
        
        return label
    }()
    
    //translation subtitle
    lazy var translationSubtitle: UILabel = {
        let label = UILabel()
        label.text = "번역 초안"
        label.font = UIFont.Nuflect.subtitleSemiBold
        
        return label
    }()
    
    //translation textView
    lazy var translationTextView: UITextView = {
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
    
    //feedback subview
    lazy var feedbackSubView = FeedbackView()
    
    //end writing paragraph button
    lazy var endWritingParagraghButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.Nuflect.mainBlue
        button.layer.cornerRadius = 11
        
        button.setTitle("단락 작성 완료", for: .normal)
        button.setTitleColor(UIColor.Nuflect.white, for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.subheadMedium
        
        button.addTarget(self, action: #selector(endWritingParagraghButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    //MARK: - Properties
    lazy var placeholder = "번역 결과를 받아오는 중입니다.\n잠시만 기다려 주세요."
    
    
    //MARK: - Define Method
    @objc func backButtonTapped() {
        print("back tapped")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func mypageButtonTapped() {
        print("mypage tapped")
    }
    
    @objc func feedbackRefreshButtonTapped() {
        print("feedback refresh tapped")
    }
    
    @objc func feedbackPrevButtonTapped() {
        print("feedback prev tapped")
    }
    
    @objc func feedbackNextButtonTapped() {
        print("feedback next tapped")
    }
    
    @objc func endWritingParagraghButtonTapped() {
        print("end writing paragragh button tapped")
        
        self.delegate?.returnToOutlineVC(paragraghNum: paragraphNum, paragraphContents: translationTextView.text)
        
        if let VC = navigationController?.viewControllers.first(where: {$0 is OutlineVC}) {
            navigationController?.popToViewController(VC, animated: true)
        }
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
        [navigationBar, feedbackTitle, translationSubtitle, translationTextView, feedbackSubView, endWritingParagraghButton].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
        let leading = 16
        let titleLeading = 35
        let subtitleLeading = 22
        let top = 20
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        feedbackTitle.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(top / 2)
            make.leading.equalToSuperview().offset(titleLeading)
        }
        
        translationSubtitle.snp.makeConstraints { make in
            make.top.equalTo(feedbackTitle.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(subtitleLeading)
        }
        
        translationTextView.snp.makeConstraints { make in
            make.top.equalTo(translationSubtitle.snp.bottom).offset(top / 2)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(220)
        }
        
        feedbackSubView.snp.makeConstraints { make in
            make.top.equalTo(translationTextView.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.bottom.equalTo(endWritingParagraghButton.snp.top).offset(-top)
        }
        
        endWritingParagraghButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-top)
        }
    }
  

}

//MARK: - extension
extension FeedbackVC: UITextViewDelegate {
    //TextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        ///placeholder
        if textView.text == placeholder {
            self.translationTextView.textColor = .Nuflect.black
            self.translationTextView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //set placeholder
        if translationTextView.text.isEmpty {
            self.translationTextView.textColor = UIColor.Nuflect.darkGray
            self.translationTextView.text = placeholder
        }
        
        //get inputs in textview, activate the button
        if translationTextView.text.isEmpty || translationTextView.text == placeholder {
            endWritingParagraghButton.backgroundColor = .Nuflect.lightGray
            endWritingParagraghButton.setTitleColor(.Nuflect.darkGray, for: .normal)
            endWritingParagraghButton.isEnabled = false
        } else {
            endWritingParagraghButton.backgroundColor = .Nuflect.mainBlue
            endWritingParagraghButton.setTitleColor(.Nuflect.white, for: .normal)
            endWritingParagraghButton.isEnabled = true
        }
    }
}

protocol returnToOutlineVCDelegate: AnyObject {
    func returnToOutlineVC(paragraghNum: Int, paragraphContents: String)
}
