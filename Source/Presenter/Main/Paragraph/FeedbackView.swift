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
    lazy var feedbakcs: [[String]] = [
        ["If you can prioritize responses, you can deepen connections with individual customers, whether through one-off interactions or through more meaningful connections.",
         "deepen connections with individual customers라는 구문에서 전치사 with가 어색하게 사용되었습니다. 왜냐하면 prioritize responses를 individual customers와 함께 하는 것이 아니라 individual customers를 향한 prioritize responses라는 의미를 전달하기 때문입니다.",
         "If you can prioritize responses directed towards individual customers, you can deepen connections, whether through one-off interactions or through more meaningful connections.",
         "원래의 문장에서 individual customers와 함께 prioritize responses를 하는 것으로 오해될 수 있는 부분을 수정하여, prioritize responses가 individual customers를 향한 것임을 명확하게 보여줍니다."],
        ["Generally, people post comments because they want their words to be acknowledged.",
         "to be acknowledged 뒤의 전치사 \"to\"가 불필요하며, \"acknowledged\"가 동사가 아닌 형용사로 사용되었습니다. \n이유: \"want\" 뒤에는 동사 원형이 올 수 있으므로, \"to be acknowledged\" 대신 \"acknowledgement\"로 수정할 필요가 있습니다.",
         "Generally, people post comments because they want acknowledgment of their words.",
         "\"to be acknowledged\" 대신 \"acknowledgment of their words\"로 수정되어, 원래의 문장보다 좀 더 명확하고 간결한 의미를 전달합니다."],
        ["Particularly when people post positive comments, it is an expression of gratitude.",
         "post 뒤에 붙은 positive comments가 전치사인데, 올바른 표현은 post positive comments라고 해야 합니다.\n이유: post는 전치사가 필요하지 않은 동사이기 때문에, positive comments가 post 뒤에 붙어야 합니다.",
         "Particularly when people post positive comments, it is an expression of gratitude.",
         "원래 문장에서 어색한 부분을 수정하여, 사람들이 긍정적인 코멘트를 남길 때 표현되는 감사의 표현에 대해 강조하는 내용이 더 명확해졌습니다."]
    ]
    
    lazy var isReflected: [Bool] = [false, false, false]
    
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
        label.text = "< Original >"
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        
        return label
    }()
    
    //original text label
    lazy var originalTextLabel: UILabel = {
        let label = UILabel()
        label.text = "original sentence\n\noriginal sentence"
        label.numberOfLines = 0
        label.font = UIFont.Nuflect.smallMedium
        label.textColor = UIColor.Nuflect.black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    //ambiguity subtitle label
    lazy var ambiguitySubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "< Ambiguity >"
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        
        return label
    }()
    
    //ambiguity text label
    lazy var ambiguityTextLabel: UILabel = {
        let label = UILabel()
        label.text = "ambiguity text\n\nambiguity text"
        label.numberOfLines = 0
        label.font = UIFont.Nuflect.smallMedium
        label.textColor = UIColor.Nuflect.black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    //alternative subtitle label
    lazy var alternativeSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "< Alternative >"
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        
        return label
    }()
    
    //alternative text label
    lazy var alternativeTextLabel: UILabel = {
        let label = UILabel()
        label.text = "alternative text\n\nalternative text"
        label.numberOfLines = 0
        label.font = UIFont.Nuflect.smallMedium
        label.textColor = UIColor.Nuflect.black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    //nuance subtitle label
    lazy var nuanceSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "< Nuance >"
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        
        return label
    }()
    
    //nuance text label
    lazy var nuanceTextLabel: UILabel = {
        let label = UILabel()
        label.text = "nuance text\n\nnuance text"
        label.numberOfLines = 0
        label.font = UIFont.Nuflect.smallMedium
        label.textColor = UIColor.Nuflect.black
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    
    //MARK: - Define Method
    func updateFeedback() {
        print("update to " + String(currentSentenceNum))
        originalTextLabel.text = feedbakcs[currentSentenceNum][0]
        ambiguityTextLabel.text = feedbakcs[currentSentenceNum][1]
        alternativeTextLabel.text = feedbakcs[currentSentenceNum][2]
        nuanceTextLabel.text = feedbakcs[currentSentenceNum][3]
        
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
    }
    
    @objc func reflectFeedbackButtonTapped() {
        print("reflect feedback tapped")
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
        if currentSentenceNum >= feedbakcs.count - 1 {
            print("last sentence")
            return
        }
        currentSentenceNum += 1
        updateFeedback()
        feedbackScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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
        updateFeedback()
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
