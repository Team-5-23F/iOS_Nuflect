//
//  FeedbackView.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 4/3/24.
//

import UIKit
import SnapKit

class FeedbackView: UIView, UIScrollViewDelegate {
    //MARK: - Properties
    //will get from API
    lazy var currentSentenceNum: Int = 0
    lazy var feedbacks: [[String:String]] = []
    lazy var isReflected: [Bool] = []
    
    weak var delegate: feedbackViewDelegate?
    
    lazy var resizedreflect = UIImage()
    lazy var resizedUndo = UIImage()
    
    //MARK: - UI ProPerties
    //feedback subtitle
    lazy var feedbackSubtitle: UILabel = {
        let label = UILabel()
        label.text = "피드백"
        label.font = UIFont.Nuflect.subtitleSemiBold
        
        return label
    }()
    
    //other feedback button
    lazy var otherFeedbackButton: UIButton = {
        let button = UIButton()
        let other = UIImage(systemName: "ellipsis.bubble.fill")
        let coloredOther = other?.withTintColor(UIColor.Nuflect.mainBlue ?? .systemBlue)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:24, height: 24), false, 0.0)
        coloredOther?.draw(in: CGRect(x: 0, y: 0, width: 24, height: 24))
        let resizedOther = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        button.setImage(resizedOther, for: .normal)
        button.backgroundColor = UIColor.Nuflect.white
        
        button.setTitle(" 다른 피드백 요청", for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.subheadMedium
        button.setTitleColor(UIColor.Nuflect.black, for: .normal)
        
        button.addTarget(self, action: #selector(otherFeedbackButtonTapped), for: .touchUpInside)
        
        button.isEnabled = false
        button.isHidden = true
        
        return button
    }()
    
    //reflect feedback button
    lazy var reflectFeedbackButton: UIButton = {
        let button = UIButton()
        
//        button.tintColor = UIColor.Nuflect.mainBlue
        button.backgroundColor = UIColor.Nuflect.white
        
//        button.setTitle(" 피드백 적용", for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.subheadMedium
        button.setTitleColor(UIColor.Nuflect.black, for: .normal)
        
        button.addTarget(self, action: #selector(reflectFeedbackButtonTapped), for: .touchUpInside)
        
        button.isEnabled = false
        button.isHidden = true
        
        return button
    }()
    
    //feedback scroll view
    lazy var feedbackScrollView = UIScrollView()
    
    lazy var feedbackContentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Nuflect.infoYellow
        view.layer.cornerRadius = 12
        
        
        return view
    }()
    
    //feedback prev button
    lazy var prevFeedbackButton: UIButton = {
        let button = UIButton()
        let prev = UIImage(systemName: "chevron.backward")
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:30, height: 30), false, 0.0)
        prev?.draw(in: CGRect(x: 0, y: 0, width: 30, height: 30))
        let resizedPrev = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        button.tintColor = UIColor.Nuflect.black
        button.setBackgroundImage(resizedPrev, for: .normal)
        button.backgroundColor = UIColor.clear
        
        button.addTarget(self, action: #selector(prevFeedbackButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //feedback next button
    lazy var nextFeedbackButton: UIButton = {
        let button = UIButton()
        let next = UIImage(systemName: "chevron.right")
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:30, height: 30), false, 0.0)
        next?.draw(in: CGRect(x: 0, y: 0, width: 30, height: 30))
        let resizedNext = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        button.tintColor = UIColor.Nuflect.black
        button.setBackgroundImage(resizedNext, for: .normal)
        button.backgroundColor = UIColor.clear
        
        button.addTarget(self, action: #selector(nextFeedbackButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //original subtitle label
    lazy var originalSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "피드백 불러오는 중"
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        
        return label
    }()
    
    //original text label
    lazy var originalTextLabel: UILabel = {
        let label = UILabel()
        label.text = "문장별로 피드백을 불러오는 중입니다.\n잠시만 기다려주세요"
        label.numberOfLines = 0
        label.font = UIFont.Nuflect.smallMedium
        label.textColor = UIColor.Nuflect.black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    //ambiguity subtitle label
    lazy var ambiguitySubtitleLabel: UILabel = {
        let label = UILabel()
//        label.text = "< Ambiguity >"
        label.text = ""
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        
        return label
    }()
    
    //ambiguity text label
    lazy var ambiguityTextLabel: UILabel = {
        let label = UILabel()
//        label.text = "ambiguity text"
        label.text = ""
        label.numberOfLines = 0
        label.font = UIFont.Nuflect.smallMedium
        label.textColor = UIColor.Nuflect.black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    //alternative subtitle label
    lazy var alternativeSubtitleLabel: UILabel = {
        let label = UILabel()
//        label.text = "< Alternative >"
        label.text = ""
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        
        return label
    }()
    
    //alternative text label
    lazy var alternativeTextLabel: UILabel = {
        let label = UILabel()
//        label.text = "alternative text"
        label.text = ""
        label.numberOfLines = 0
        label.font = UIFont.Nuflect.smallMedium
        label.textColor = UIColor.Nuflect.black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    //nuance subtitle label
    lazy var nuanceSubtitleLabel: UILabel = {
        let label = UILabel()
//        label.text = "< Nuance >"
        label.text = ""
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        
        return label
    }()
    
    //nuance text label
    lazy var nuanceTextLabel: UILabel = {
        let label = UILabel()
//        label.text = "nuance text"
        label.text = ""
        label.numberOfLines = 0
        label.font = UIFont.Nuflect.smallMedium
        label.textColor = UIColor.Nuflect.black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    
    //MARK: - Define Method
    func updateFeedback() {
        print("update to " + String(currentSentenceNum))
        originalTextLabel.text = feedbacks[currentSentenceNum]["Sentence"]
        ambiguityTextLabel.text = feedbacks[currentSentenceNum]["Task1"]
        alternativeTextLabel.text = feedbacks[currentSentenceNum]["Task2"]
        nuanceTextLabel.text = feedbacks[currentSentenceNum]["Task3"]
        
        //undo
        if isReflected[currentSentenceNum] {
            reflectFeedbackButton.tintColor = UIColor.Nuflect.black
            reflectFeedbackButton.setImage(resizedUndo, for: .normal)
            reflectFeedbackButton.setTitle(" 되돌리기", for: .normal)
        }
        //reflect
        else {
            reflectFeedbackButton.tintColor = UIColor.Nuflect.mainBlue
            reflectFeedbackButton.setImage(resizedreflect, for: .normal)
            reflectFeedbackButton.setTitle(" 반영하기", for: .normal)
        }
        
    }
    
    @objc func otherFeedbackButtonTapped() {
        print("other feedback tapped")
        callAPI()
    }
    
    @objc func reflectFeedbackButtonTapped() {
        print("reflect feedback tapped")
        if feedbacks[self.currentSentenceNum]["Task2"] == "No improvement needed." {
            print("No improvement needed.")
            return
        }
        //undo
        if isReflected[currentSentenceNum] {
            delegate?.undoFeedback(alternative: alternativeTextLabel.text ?? "", original: originalTextLabel.text ?? "")
            isReflected[currentSentenceNum] = false
        }
        //reflect
        else {
            delegate?.reflecfFeedback(original: originalTextLabel.text ?? "", alternative: alternativeTextLabel.text ?? "")
            isReflected[currentSentenceNum] = true
        }
        
        updateFeedback()
    }
    
    @objc func prevFeedbackButtonTapped() {
        print("prev feedback tapped")
        if currentSentenceNum == 0 {
            print("1st sentence")
            return
        }
        currentSentenceNum -= 1
        updateFeedback()
        feedbackScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc func nextFeedbackButtonTapped() {
        print("next feedback tapped")
        if currentSentenceNum >= feedbacks.count - 1 {
            print("last sentence")
            return
        }
        currentSentenceNum += 1
        updateFeedback()
        feedbackScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func callAPI() {
        let sentence = PostFeedbackLine(Sentence: self.feedbacks[currentSentenceNum]["Sentence"] ?? "Sentence error occured")
        let newFeedbackSentenceNum = currentSentenceNum + 1
        print(sentence)
        
        let body = [
            "Sentence": sentence.Sentence as Any
        ] as [String: Any]
        
        APIManger.shared.callPostRequest(baseEndPoint: .feedbackLine, addPath: "", parameters: body) { JSON in
            print(JSON)
            do {
                // Convert JSON data to Swift objects
                if let jsonArray = try JSONSerialization.jsonObject(with: JSON.rawData(), options: []) as? [String] {
                    
                    let newFeedback = ["Sentence": jsonArray[0],
                                       "Task1": jsonArray[1],
                                       "Task2": jsonArray[2],
                                       "Task3": jsonArray[3]
                                   ]
                    
                    print(newFeedback)
                    self.feedbacks.insert(newFeedback, at: newFeedbackSentenceNum)
                    self.isReflected.insert(false, at: newFeedbackSentenceNum)
                    
                    self.currentSentenceNum += newFeedbackSentenceNum
                    self.updateFeedback()
                    
                }
            } catch {
                print("Error converting JSON to Swift objects: \(error)")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraint()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setscrollview() {
        feedbackScrollView.delegate = self
    }
    
    //MARK: - Set Ui
    func setView() {
        //reflect button icon
        let reflect = UIImage(systemName: "checkmark.circle.fill")
        let coloredreflect = reflect?.withTintColor(UIColor.Nuflect.mainBlue ?? .systemBlue)
        UIGraphicsBeginImageContextWithOptions(CGSize(width:24, height: 24), false, 0.0)
        coloredreflect?.draw(in: CGRect(x: 0, y: 0, width: 24, height: 24))
        self.resizedreflect = UIGraphicsGetImageFromCurrentImageContext() ?? coloredreflect!
        UIGraphicsEndImageContext()
        
        //undo button icon
        let undo = UIImage(systemName: "arrow.uturn.backward.circle.fill")
        let coloredUndo = undo?.withTintColor(UIColor.Nuflect.black ?? .black)
        UIGraphicsBeginImageContextWithOptions(CGSize(width:24, height: 24), false, 0.0)
        coloredUndo?.draw(in: CGRect(x: 0, y: 0, width: 24, height: 24))
        self.resizedUndo = UIGraphicsGetImageFromCurrentImageContext() ?? coloredUndo!
        UIGraphicsEndImageContext()
        
        print(isReflected)
        addSubView()
        self.backgroundColor = UIColor.Nuflect.white
    }
    
    func addSubView() {
        [feedbackSubtitle, otherFeedbackButton, reflectFeedbackButton, feedbackScrollView, prevFeedbackButton, nextFeedbackButton].forEach { view in
            self.addSubview(view)
        }
        
        [feedbackContentView].forEach { view in
            feedbackScrollView.addSubview(view)
        }
        
        [originalSubtitleLabel, originalTextLabel,
        ambiguitySubtitleLabel, ambiguityTextLabel,
        alternativeSubtitleLabel, alternativeTextLabel,
        nuanceSubtitleLabel, nuanceTextLabel].forEach { view in
            feedbackContentView.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
        let offset = 6
        let top = 10
        
        feedbackSubtitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(offset)
            make.top.equalToSuperview()
        }
        
        otherFeedbackButton.snp.makeConstraints { make in
            make.trailing.equalTo(reflectFeedbackButton.snp.leading).offset(-16)
            make.centerY.equalTo(feedbackSubtitle)
        }
        
        reflectFeedbackButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-offset)
            make.centerY.equalTo(feedbackSubtitle)
        }
        
        prevFeedbackButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(20)
            make.centerY.equalTo(feedbackScrollView)
        }

        nextFeedbackButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.width.equalTo(20)
            make.centerY.equalTo(feedbackScrollView)
        }
        
        feedbackScrollView.snp.makeConstraints { make in
            make.top.equalTo(feedbackSubtitle.snp.bottom).offset(top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        feedbackContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(self.snp.width)
            make.top.equalToSuperview()
            make.bottom.equalTo(nuanceTextLabel.snp.bottom).offset(18)
        }
        
        originalSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(feedbackContentView.snp.top).offset(18)
            make.leading.equalTo(prevFeedbackButton.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(nextFeedbackButton.snp.leading).offset(-8)
        }
        
        originalTextLabel.snp.makeConstraints { make in
            make.top.equalTo(originalSubtitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(prevFeedbackButton.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(nextFeedbackButton.snp.leading).offset(-8)
        }
        
        ambiguitySubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(originalTextLabel.snp.bottom).offset(18)
            make.leading.equalTo(prevFeedbackButton.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(nextFeedbackButton.snp.leading).offset(-8)
        }
        
        ambiguityTextLabel.snp.makeConstraints { make in
            make.top.equalTo(ambiguitySubtitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(prevFeedbackButton.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(nextFeedbackButton.snp.leading).offset(-8)
        }
        
        alternativeSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(ambiguityTextLabel.snp.bottom).offset(18)
            make.leading.equalTo(prevFeedbackButton.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(nextFeedbackButton.snp.leading).offset(-8)
        }
        
        alternativeTextLabel.snp.makeConstraints { make in
            make.top.equalTo(alternativeSubtitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(prevFeedbackButton.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(nextFeedbackButton.snp.leading).offset(-8)
        }
        
        nuanceSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(alternativeTextLabel.snp.bottom).offset(18)
            make.leading.equalTo(prevFeedbackButton.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(nextFeedbackButton.snp.leading).offset(-8)
        }
        
        nuanceTextLabel.snp.makeConstraints { make in
            make.top.equalTo(nuanceSubtitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(prevFeedbackButton.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(nextFeedbackButton.snp.leading).offset(-8)
        }
        
    }
  

}


protocol feedbackViewDelegate: AnyObject {
    func reflecfFeedback(original: String, alternative: String)
    func undoFeedback(alternative: String, original: String)
}
