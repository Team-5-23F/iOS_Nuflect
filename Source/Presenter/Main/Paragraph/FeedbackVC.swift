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
    lazy var translatedRawText: String = "번역 결과를 받아오는 중입니다.\n잠시만 기다려 주세요."
    lazy var translatedText = NSMutableAttributedString(string: translatedRawText, attributes: [
        .font: UIFont.Nuflect.baseMedium,
        .foregroundColor: UIColor.Nuflect.black ?? .black])
    
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
        textView.attributedText = translatedText
        textView.font = UIFont.Nuflect.baseMedium
        textView.textColor = UIColor.Nuflect.darkGray
        textView.backgroundColor = UIColor.Nuflect.inputBlue
        textView.layer.cornerRadius = 8
        textView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        textView.textContainerInset = .init(top: 18, left: 23, bottom: 18, right: 23)
        textView.scrollIndicatorInsets = .init(top: 18, left: 10, bottom: 18, right: 23)
        
        //add Done button
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [flexSpace, doneButton]
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar
        
//        textView.isEditable = false
        
        return textView
    }()
    
    //feedback subview
    lazy var feedbackSubView: FeedbackView = {
        let feedbackView = FeedbackView()
        feedbackView.delegate = self
        
        return feedbackView
    }()
    
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
    
    
    //MARK: - Define Method
    @objc func doneButtonTapped() {
        translationTextView.resignFirstResponder()
    }
    
    @objc func backButtonTapped() {
        print("back tapped")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func mypageButtonTapped() {
        print("mypage tapped")
        let VC = MypageVC()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func endWritingParagraghButtonTapped() {
        print("end writing paragragh button tapped")
        
        self.delegate?.returnToOutlineVC(paragraghNum: paragraphNum, paragraphContents: translationTextView.text)
        
        if let VC = navigationController?.viewControllers.first(where: {$0 is OutlineVC}) {
            navigationController?.popToViewController(VC, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
        translationTextView.textColor = UIColor.Nuflect.black
    }
    
    func callAPI() {
        let postFeedbackWriting = PostFeedbackWriting(Writing: self.translatedRawText)
        print(postFeedbackWriting)
        
        let body = [
            "Writing": postFeedbackWriting.Writing as Any
        ] as [String: Any]
        
        APIManger.shared.callPostRequest(baseEndPoint: .feedback, addPath: "writing/", parameters: body) { JSON in
            let numOfFeedbacks = JSON.count
            print(numOfFeedbacks)
            print(JSON)
            print(JSON.arrayValue)
            
            do {
                // Convert JSON data to Swift objects
                if let jsonArray = try JSONSerialization.jsonObject(with: JSON.rawData(), options: []) as? [[String: String]] {
                    print(jsonArray)
                    // Now jsonArray is of type [[String: String]]
                    self.feedbackSubView.feedbacks = jsonArray
                    for _ in 0 ..< self.feedbackSubView.feedbacks.count {
                        self.feedbackSubView.isReflected.append(false)
                    }
                }
            } catch {
                print("Error converting JSON to Swift objects: \(error)")
            }
            
            self.feedbackSubView.updateFeedback()
            self.feedbackSubView.originalSubtitleLabel.text = "< Original >"
            self.feedbackSubView.ambiguitySubtitleLabel.text = "< Ambiguity >"
            self.feedbackSubView.alternativeSubtitleLabel.text = "< Alternative >"
            self.feedbackSubView.nuanceSubtitleLabel.text = "< Nuance >"
            self.feedbackSubView.otherFeedbackButton.isHidden = false
            self.feedbackSubView.otherFeedbackButton.isEnabled = true
            self.feedbackSubView.reflectFeedbackButton.isHidden = false
            self.feedbackSubView.reflectFeedbackButton.isEnabled = true
        }
        
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


extension FeedbackVC: feedbackViewDelegate {
    
    func reflecfFeedback(original: String, alternative: String) {
        print("apply feedback called")
        
        if alternative == "No improvements needed." {
            self.showToast(message: "반영할 피드백이 없습니다.", duration: 1, delay: 0.5)
            return
        }
        
        let range = (translatedText.string as NSString).range(of: original)
        
        guard range.location != NSNotFound else {
                print("Original string not found")
                return
            }
        
        translatedText.replaceCharacters(in: range, with: NSAttributedString(string: alternative, attributes: [
            .font: UIFont.Nuflect.baseBold,
            //.foregroundColor: UIColor.red
                ]))
        
        translationTextView.attributedText = translatedText
    
    }
    
    func undoFeedback(alternative: String, original: String) {
        print("undo feedback called")
        
        let range = (translatedText.string as NSString).range(of: alternative)
        
        guard range.location != NSNotFound else {
                print("alternative string not found")
                return
            }
        
        translatedText.replaceCharacters(in: range, with: NSAttributedString(string: original, attributes: [
            .font: UIFont.Nuflect.baseMedium,
            //.foregroundColor: UIColor.red
                ]))
        
        translationTextView.attributedText = translatedText
    
    }
    
}

protocol returnToOutlineVCDelegate: AnyObject {
    func returnToOutlineVC(paragraghNum: Int, paragraphContents: String)
}
