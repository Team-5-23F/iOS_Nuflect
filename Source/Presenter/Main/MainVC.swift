//
//  MainVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/18/24.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    //MARK: - Properties
    lazy var placeholderFormat = "작성할 글의 형식을 입력해주세요."
    lazy var placeholderPurpose = "작성할 글의 목적을 입력해주세요.\n구체적으로 작성할 수록\n더욱 적합한 글의 개요가 제공됩니다."
    
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
    
    //purpose title
    lazy var purposeTitle: UILabel = {
        let label = UILabel()
        label.text = "작성할 글의\n형식과 목적을 입력해주세요"
        label.numberOfLines = 2
        label.font = UIFont.Nuflect.headtitlebold
        
        return label
    }()
    
    //format textView
    lazy var formatTextView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.text = placeholderFormat
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
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(formatDoneButtonTapped))
        toolbar.items = [flexSpace, doneButton]
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar
        
        return textView
    }()
    
    //purpose textView
    lazy var purposeTextView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.text = placeholderPurpose
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
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(purposeDoneButtonTapped))
        toolbar.items = [flexSpace, doneButton]
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar
        
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
    @objc func formatDoneButtonTapped() {
        formatTextView.resignFirstResponder()
    }
    
    @objc func purposeDoneButtonTapped() {
        purposeTextView.resignFirstResponder()
    }

    @objc func logoButtonTapped() {
        print("logo tapped")
    }
    
    @objc func mypageButtonTapped() {
        print("mypage tapped")
        let VC = MypageVC()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func introductionButtonTapped() {
        print("introduction tapped")
        let VC = IntroductionVC()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func startButtonTapped() {
        self.showToast(message: "Outline 요청", duration: 1, delay: 0.5)
        callPostAPI()
    }
    
    func callPostAPI() {
        let postOutline = PostOutline(Task: self.formatTextView.text, Context: self.purposeTextView.text)
        print(postOutline)
        
        let body = [
            "Task": postOutline.Task,
            "Context": postOutline.Context
        ] as [String: Any]
            
        APIManger.shared.callPostRequest(baseEndPoint: .outline, addPath: "", parameters: body) { JSON in
            let numOfIndex = JSON["NumOfIndex"].intValue
            print(numOfIndex)
            var outline: [[String:String]] = []
            for i in 1 ... numOfIndex {
                let index = JSON["Index"]["para\(i)"].stringValue
                print(i)
                print(index)
                outline.append(["index": index, "content": ""])
            }
            print(outline)
            
            let VC = OutlineVC()
            VC.formatText = self.formatTextView.text
            VC.purposeText = self.purposeTextView.text
            VC.paragraphs = outline
            self.navigationController?.pushViewController(VC, animated: true)
            
            self.formatTextView.text = ""
            self.purposeTextView.text = ""
            self.textViewDidEndEditing(self.purposeTextView)
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
        
//        //title (center)
//        navigationItem.title = "Nuflect"
//        navigationBar.titleTextAttributes = [
//            .foregroundColor: UIColor.black,
//            .font: UIFont.Nuflect.headtitleSemiBold
//        ]
        
        //logo (left)
        let logo = UIImage(named: "img_logo")
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
    
    func addSubView() {
        [navigationBar, introductionButton, purposeTitle, formatTextView, purposeTextView, startButton].forEach { view in
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
        let top = 20
        
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
            make.top.equalToSuperview().offset(top)
            make.centerX.equalToSuperview()
        }
        
        introductionContent.snp.makeConstraints { make in
            make.top.equalTo(introductionTitle.snp.bottom).offset(top / 2)
            make.centerX.equalToSuperview()
        }
        
        introductionMore.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-top)
            make.trailing.equalToSuperview().offset(-top)
        }
        
        
        purposeTitle.snp.makeConstraints { make in
            make.top.equalTo(introductionButton.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(titleLeading)
        }
        
        formatTextView.snp.makeConstraints { make in
            make.top.equalTo(purposeTitle.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(56)
        }
        
        purposeTextView.snp.makeConstraints { make in
            make.top.equalTo(formatTextView.snp.bottom).offset(top / 2)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.bottom.equalTo(startButton.snp.top).offset(-top)
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-top)
        }
    }
  

}

//MARK: - extension
extension MainVC: UITextViewDelegate {
    //TextView
    func textViewDidBeginEditing(_ textView: UITextView) {
        //placeholder
        if textView.text == placeholderFormat {
            self.formatTextView.textColor = .Nuflect.black
            self.formatTextView.text = nil
        }
        
        if textView.text == placeholderPurpose {
            self.purposeTextView.textColor = .Nuflect.black
            self.purposeTextView.text = nil
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //set placeholder
        if formatTextView.text.isEmpty {
            self.formatTextView.textColor = UIColor.Nuflect.darkGray
            self.formatTextView.text = placeholderFormat
        }
        
        if purposeTextView.text.isEmpty {
            self.purposeTextView.textColor = UIColor.Nuflect.darkGray
            self.purposeTextView.text = placeholderPurpose
        }
        
        //get inputs in textview, activate the button
        if formatTextView.text == placeholderFormat || purposeTextView.text == placeholderPurpose {
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
