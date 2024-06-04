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
    lazy var paragraphNum: Int = 0
    lazy var paragraphTitle : String = "ParagraphTitle"
    
    lazy var placeholder = "문장 끝에 마침표(.)를 꼭 붙여주세요."
    
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //writing title
    lazy var writingTitle: UILabel = {
        let label = UILabel()
        label.text = String(paragraphNum + 1) + ". " + paragraphTitle + "\n단락의 내용을 작성해주세요"
        label.numberOfLines = 0
        label.font = UIFont.Nuflect.headtitlebold
        
        return label
    }()
    
    //writing introduction label
    lazy var writingIntroductionLabel: UILabel = {
        let label = UILabel()
        label.text = "작성한 단락의 번역 초안과\n번역으로 인해 생기는 뉘양스 차이 및\n의미적 모호성을 해소할 피드백을 드릴게요"
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
        textView.sizeToFit()
        
        //add Done button
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [flexSpace, doneButton]
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar
        
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
    
    //sample data button
    lazy var sampleDataButton1: UIButton = {
        let button = UIButton()
        
//        button.backgroundColor = UIColor.Nuflect.white
        button.layer.cornerRadius = 11
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Nuflect.darkGray?.cgColor
        
        button.setTitle(" 샘플 입력 1 ", for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.smallMedium
        button.setTitleColor(UIColor.Nuflect.darkGray, for: .normal)
        
        button.addTarget(self, action: #selector(sampleDataButtonTapped1), for: .touchUpInside)
        
        return button
    }()
    
    //sample data button
    lazy var sampleDataButton2: UIButton = {
        let button = UIButton()
        
//        button.backgroundColor = UIColor.Nuflect.white
        button.layer.cornerRadius = 11
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Nuflect.darkGray?.cgColor
        
        button.setTitle(" 샘플 입력 2 ", for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.smallMedium
        button.setTitleColor(UIColor.Nuflect.darkGray, for: .normal)
        
        button.addTarget(self, action: #selector(sampleDataButtonTapped2), for: .touchUpInside)
        
        return button
    }()
    
    //sample data button
    lazy var sampleDataButton3: UIButton = {
        let button = UIButton()
        
//        button.backgroundColor = UIColor.Nuflect.white
        button.layer.cornerRadius = 11
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Nuflect.darkGray?.cgColor
        
        button.setTitle(" 샘플 입력 3 ", for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.smallMedium
        button.setTitleColor(UIColor.Nuflect.darkGray, for: .normal)
        
        button.addTarget(self, action: #selector(sampleDataButtonTapped3), for: .touchUpInside)
        
        return button
    }()
    
    //sample data button
    lazy var sampleDataButton4: UIButton = {
        let button = UIButton()
        
//        button.backgroundColor = UIColor.Nuflect.white
        button.layer.cornerRadius = 11
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.Nuflect.darkGray?.cgColor
        
        button.setTitle(" 샘플 입력 4 ", for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.smallMedium
        button.setTitleColor(UIColor.Nuflect.darkGray, for: .normal)
        
        button.addTarget(self, action: #selector(sampleDataButtonTapped4), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Define Method
    @objc func sampleDataButtonTapped1() {
        writingTextView.text = "Nuflect는 영어 작문에 어려움을 겪는 사람들을 위해 개발되었습니다. 번역 과정에서 발생할 수 있는 뉘앙스 차이나 의미적 모호성을 파악해 오류 없이 글을 작성할 수 있도록 돕습니다."
        writingTextView.textColor = .black
        textViewDidEndEditing(writingTextView)
    }
    
    @objc func sampleDataButtonTapped2() {
        writingTextView.text = "번역기를 이용했지만, 번역된 결과가 내가 의도한 뉘앙스를 잘 담고 있을까 고민한 경험 있으실겁니다. 번역된 글에 적절치 못한 표현이 포함되어 오해가 생기진 않을까 걱정도 해보셨겠죠. 아쉽게도 원어민이 아닌 우리는 모든 문장에 대해 분석하며 글을 쓰기 어렵습니다. 세심한 부분까지 모두 판단할 수 있는 영어 실력자라면, 번역기를 이용하지 않을거에요. 우리는 그러지 못한 사람을 위해 서비스를 제공합니다. 자세한 뉘앙스와 다채로운 표현까지도 여러분의 영작에 녹여내세요."
        writingTextView.textColor = .black
        textViewDidEndEditing(writingTextView)
    }
    
    @objc func sampleDataButtonTapped3() {
        writingTextView.text = "Nuflect는 작성할 글의 형식과 목적을 입력하면 글의 개요를 추천해줍니다. 단락별로 글을 작성하시면 초기 번역 후 번역된 글을 모두 검사합니다. 이 단계에서 NLTK를 활용하여, 조동사나 시제, 전치사와 같이 뉘앙스의 차이를 크게 좌우할 수 있는 지점을 추출하여 프롬프트를 작성하는 것으로 뉘앙스 차이의 원인과 대체 표현, 달라진 부분들을 보다 정확하게 제공합니다."
        writingTextView.textColor = .black
        textViewDidEndEditing(writingTextView)
    }
    
    @objc func sampleDataButtonTapped4() {
        writingTextView.text = "사용자가 또 다른 분석을 요청하는 경우, 선택한 문장을 단위로 하여, 동일한 의미를 가지는 문장을 생성하는 것으로, 관용표현이나 비유 은유적인 표현까지 반영할 수 있게 하여 더 다채로운 글의 구성을 가능합니다. 글 작성 이후 원하는 단락은 별도로 북마크 처리 해 모아서 보고 쉽게 복사하여 재사용할 수 있습니다."
        writingTextView.textColor = .black
        textViewDidEndEditing(writingTextView)
    }
    
    @objc func doneButtonTapped() {
        writingTextView.resignFirstResponder()
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
    
    @objc func requestButtonTapped() {
        print("request tapped")
        self.showToast(message: "요청 완료", duration: 1, delay: 0.5)
        callAPI()
    }
    
    func callAPI() {
        let postTranslate = PostTranslate(Text: self.writingTextView.text)
        print(postTranslate)
        
        let body = [
            "Text": postTranslate.Text as Any
        ] as [String: Any]
        
        APIManger.shared.callPostRequest(baseEndPoint: .translate, addPath: "", parameters: body) { JSON in
            do {
                var translation = JSON["Text"].stringValue
                print(translation)
                if translation.hasPrefix("[Output]: ") {
                    translation.removeFirst("[Output]: ".count)
                } else if translation.hasPrefix("[Text]: ") {
                    translation.removeFirst("[Text]: ".count)
                }
                            
                
                // Convert JSON data to Swift objects
                if var jsonArray = try JSONSerialization.jsonObject(with: JSON["Result"].rawData(), options: []) as? [[String: String]] {
                    print(jsonArray)
                    // Now jsonArray is of type [[String: String]]
                    for (index, item) in jsonArray.enumerated() {
                        if let original = item["Translation"] {
                            if original.hasPrefix("[Output]: ") {
                                jsonArray[index]["Translation"] = String(original.dropFirst("[Output]: ".count))
                            } else if original.hasPrefix("[Text]: ") {
                                jsonArray[index]["Translation"] = String(original.dropFirst("[Text]: ".count))
                            }
                        }
                    }
                    
                    let VC = FeedbackVC()
                    VC.paragraphNum = self.paragraphNum
                    VC.translatedRawText = translation
                    VC.feedbackSubView.textTuples = jsonArray
                    if let outlineVC = self.navigationController?.viewControllers.first(where: { $0 is OutlineVC }) as? OutlineVC {
                            VC.delegate = outlineVC
                        }
                    self.navigationController?.pushViewController(VC, animated: true)
                }
            } catch {
                print("Error converting JSON to Swift objects: \(error)")
            }
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
        [navigationBar, writingTitle, writingIntroductionLabel, writingTextView, requestButton, sampleDataButton1, sampleDataButton2, sampleDataButton3, sampleDataButton4].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
        let leading = 16
        let titleLeading = 35
        let top = 20
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        writingTitle.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(titleLeading)
            make.trailing.equalToSuperview().offset(-titleLeading)
        }
        
        writingIntroductionLabel.snp.makeConstraints { make in
            make.top.equalTo(writingTitle.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(110)
        }
        
        writingTextView.snp.makeConstraints { make in
            make.top.equalTo(sampleDataButton1.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.bottom.equalTo(requestButton.snp.top).offset(-top)
        }
        
        requestButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-top)
        }
        
        sampleDataButton1.snp.makeConstraints { make in
            make.top.equalTo(writingIntroductionLabel.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(20)
        }
        
        sampleDataButton2.snp.makeConstraints { make in
            make.top.equalTo(writingIntroductionLabel.snp.bottom).offset(top)
            make.leading.equalTo(sampleDataButton1.snp.trailing).offset(16)
        }
        
        sampleDataButton3.snp.makeConstraints { make in
            make.top.equalTo(writingIntroductionLabel.snp.bottom).offset(top)
            make.leading.equalTo(sampleDataButton2.snp.trailing).offset(16)
        }
        
        sampleDataButton4.snp.makeConstraints { make in
            make.top.equalTo(writingIntroductionLabel.snp.bottom).offset(top)
            make.trailing.equalToSuperview().offset(-20)
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
