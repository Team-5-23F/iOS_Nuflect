//
//  CompleteVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/19/24.
//

import UIKit
import SnapKit

class CompleteVC: UIViewController, UIScrollViewDelegate {
    //MARK: - Properties
    //will get from OutlineVC
    lazy var formatText : String = ""
    lazy var purposeText : String = ""
    lazy var paragraphs : [[String]] = []
    lazy var isBokkmarked : [Bool] = []

    
//    lazy var formatText : String = "format\nformat"
//    lazy var purposeText : String = "purpose\n\npurpose"
//    lazy var paragraphsTitles : [String] = ["Paragraph 1", "Paragraph 2", "Paragraph 3", "Paragraph 4", "Paragraph 5", "Paragraph 6", "Paragraph 7", "Paragraph 8", "Paragraph 9"]
//    lazy var paragraphsText : [String] = ["Paragraph 1\n\n\n\nParagraph 1Paragraph 1", "Paragraph 2\n\n\nParagraph 1Paragraph 1Paragraph 2", "Paragraph 3\n\n\nParagraph 3Paragraph 3Paragraph 3", "Paragraph 4\n\n\nParagraph 3Paragraph 3Paragraph 4", "Paragraph 5\n\n\nParagraph 3Paragraph 3Paragraph 5", "Paragraph 6\n\n\nParagraph 6", "Paragraph 7\n\n\nParagraph 3Paragraph 3Paragraph 7", "Paragraph 8\n\n\nParagraph 3Paragraph 3Paragraph 8", "Paragraph 9\n\n\nParagraph 9"]
//    lazy var isBokkmarked : [Bool] = [false,false,false,false]
    
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //scroll view
    lazy var scrollView:UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    //container for scroll view
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    //writing title
    lazy var completeTitle: UILabel = {
        let label = UILabel()
        label.text = "완성된 글을 최종 검토하고\n저장하세요"
        label.numberOfLines = 2
        label.font = UIFont.Nuflect.headtitlebold
        
        return label
    }()
    
    //format subtitle
    lazy var formatSubtitle: UILabel = {
        let label = UILabel()
        label.text = "글의 형식"
        label.font = UIFont.Nuflect.subtitleSemiBold
        
        return label
    }()
    
    //format label
    lazy var formatLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = formatText
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        label.backgroundColor = UIColor.Nuflect.infoYellow
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        
        return label
    }()
    
    //purpose subtitle
    lazy var purposeSubtitle: UILabel = {
        let label = UILabel()
        label.text = "글의 목적"
        label.font = UIFont.Nuflect.subtitleSemiBold
        
        return label
    }()
    
    //purpose label
    lazy var purposeLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = purposeText
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.Nuflect.baseSemiBold
        label.textColor = UIColor.Nuflect.black
        label.backgroundColor = UIColor.Nuflect.infoYellow
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        
        return label
    }()
    
    //complete writing subtitle
    lazy var completeWritingSubtitle: UILabel = {
        let label = UILabel()
        label.text = "완성된 글"
        label.font = UIFont.Nuflect.subtitleSemiBold
        
        return label
    }()
    
    //copy all button
    lazy var copyAllButton: UIButton = {
        let button = UIButton()
        let other = UIImage(systemName: "doc.on.doc")
        let coloredOther = other?.withTintColor(UIColor.Nuflect.black ?? .systemBlue)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:24, height: 24), false, 0.0)
        coloredOther?.draw(in: CGRect(x: 0, y: 0, width: 24, height: 24))
        let resizedOther = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        button.setImage(resizedOther, for: .normal)
//        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = UIColor.Nuflect.white
        
        button.setTitle(" 전체 복사", for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.subheadMedium
        button.setTitleColor(UIColor.Nuflect.black, for: .normal)
        
        button.addTarget(self, action: #selector(copyAllButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //complete writing collectionView
    lazy var completeWritingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        
        collectionView.backgroundColor = .Nuflect.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CompleteCell.self, forCellWithReuseIdentifier: "completeCell")
        
        return collectionView
    }()
    
    //save button
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.Nuflect.mainBlue
        button.layer.cornerRadius = 11
        
        button.setTitle("저장 및 메인으로", for: .normal)
        button.setTitleColor(UIColor.Nuflect.white, for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.subheadMedium
        
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    //MARK: - Define Method
    @objc func backButtonTapped() {
        print("back tapped")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func copyAllButtonTapped() {
        print("copy all tapped")
        var wrting = ""
        
//        for i in 0 ..< self.paragraphsTitles.count {
        for i in 0 ..< self.paragraphs.count {
//            wrting += "\(i + 1). " + paragraphsTitles[i] + "\n" + paragraphsText[i]
            wrting += "\(i + 1). " + paragraphs[i][0] + "\n" + paragraphs[i][1]
            
//            if i >= self.paragraphsTitles.count - 1 {
            if i >= self.paragraphs.count - 1 {
                break
            }
            else {
                wrting += "\n\n"
            }
        }
        
        copyToClipboardAndShowToast(text: wrting, viewController: self)
    }
    
    @objc func saveButtonTapped() {
        print("save tapped")
        callPostAPI()
    }
    
    func callPatchAPI() {
        print("patch bookmark")
        let pkWriting = 0
        let pkParagraph = 0
        // ?writing_id{pk:int}&?paragraph_id{pk:int}
        APIManger.shared.callPatchRequest(baseEndPoint: .myParagraph, addPath: "?writing_id\(pkWriting)&?paragraph_id\(pkParagraph)") { JSON in
            
            //Todo : 에러 안뜨면 성공. 북마크 등록/해제 알림 보여주기
            //Todo : isBookmarked로 more 버튼 팝업에 등록 | 해제 로 보여주기 가능?
        }
    }
    
    func callPostAPI() {
        print("post writing")
        let postMyWriting = PostMyWriting(format: formatText, purpose: purposeText, paragraphs: paragraphs)
        
        let body = [
            "format": postMyWriting.format as Any,
            "purpose" : postMyWriting.purpose as Any,
            "paragraphs" : postMyWriting.paragraphs as Any
        ] as [String: Any]
        
        APIManger.shared.callPostRequest(baseEndPoint: .myWriting, addPath: "", parameters: body) { JSON in
            print(JSON["pk"])
            print(JSON["format"])
            print(JSON["purpose"])
            print(JSON["paragraphs"])
            
            if let VC = self.navigationController?.viewControllers.first(where: {$0 is MainVC}) {
                self.navigationController?.popToViewController(VC, animated: true)
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    //Set scrollview size to fit contentView
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(calculateContentViewHeight())
        }
        scrollView.contentSize = contentView.frame.size
    }
    
    //MARK: - Set Ui
    func setView() {
        setNavigationBar()
        addSubView()
        setScrollview()
        view.backgroundColor = UIColor.Nuflect.white
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

        [completeTitle, formatSubtitle, formatLabel, purposeSubtitle, purposeLabel, completeWritingSubtitle, copyAllButton, completeWritingCollectionView, saveButton].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    //scroll view
    func setScrollview() {
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.Nuflect.white
        scrollView.isScrollEnabled = true
    }
    
    //auto layout
    func setConstraint() {
        let leading = 16
        let titleLeading = 35
        let subtitleLeading = 22
        let top = 20
        
        navigationBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
//        contentView.snp.makeConstraints { make in
//            make.width.equalTo(view.snp.width)
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.height.equalTo(calculateContentViewHeight())
//        }
        
        completeTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(top)
            make.leading.equalToSuperview().offset(titleLeading)
        }
        
        formatSubtitle.snp.makeConstraints { make in
            make.top.equalTo(completeTitle.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(subtitleLeading)
        }
        
        formatLabel.snp.makeConstraints { make in
            make.top.equalTo(formatSubtitle.snp.bottom).offset(top / 2)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        purposeSubtitle.snp.makeConstraints { make in
            make.top.equalTo(formatLabel.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(subtitleLeading)
        }
        
        purposeLabel.snp.makeConstraints { make in
            make.top.equalTo(purposeSubtitle.snp.bottom).offset(top / 2)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        completeWritingSubtitle.snp.makeConstraints { make in
            make.top.equalTo(purposeLabel.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(subtitleLeading)
        }
        
        copyAllButton.snp.makeConstraints { make in
            make.bottom.equalTo(completeWritingSubtitle.snp.bottom)
            make.trailing.equalToSuperview().offset(-subtitleLeading)
        }
        
        completeWritingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(completeWritingSubtitle.snp.bottom).offset(top / 2)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(calculateCollectionViewHeight())
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(53)
            make.bottom.equalToSuperview().offset(-top)
        }
    }
  

}

//set collectionView
extension CompleteVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, moreOptionDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return paragraphsTitles.count
        return paragraphs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "completeCell", for: indexPath) as! CompleteCell
        cell.delegate = self
        cell.paragraphNum = indexPath.item
//        cell.paragraphTitleLabel.text = "\(indexPath.item + 1). " + paragraphsTitles[indexPath.item]
//        cell.paragraphTextLabel.text = paragraphsText[indexPath.item]
        cell.paragraphTitleLabel.text = "\(indexPath.item + 1). " + paragraphs[indexPath.item][0]
        cell.paragraphTextLabel.text = paragraphs[indexPath.item][1]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
//        let height = heightForText(paragraphsTitles[indexPath.item], width: width - 46) +  heightForText(paragraphsText[indexPath.item], width: width - 46) + 46
        let height = heightForText(paragraphs[indexPath.item][0], width: width - 46) +  heightForText(paragraphs[indexPath.item][1], width: width - 46) + 46
        
        return CGSize(width: width, height: height)
    }
    
    private func heightForText(_ text: String, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.Nuflect.baseSemiBold
        label.text = text
        label.sizeToFit()
        return label.frame.height
        }
    
    private func calculateContentViewHeight() -> CGFloat {
        var totalHeight: CGFloat = 0
        // Add heights of all UI elements in contentView
        totalHeight += completeTitle.frame.height + formatSubtitle.frame.height + formatLabel.frame.height + purposeSubtitle.frame.height + purposeLabel.frame.height + completeWritingSubtitle.frame.height + saveButton.frame.height + 110 + calculateCollectionViewHeight()
        
        return totalHeight
    }
    
    private func calculateCollectionViewHeight() -> CGFloat {
        var collectionViewHeight: CGFloat = 0
        
//        for i in 0 ..< paragraphsText.count {
        for i in 0 ..< paragraphs.count {
            let indexPath = IndexPath(row: i, section: 0)
            let width = completeWritingCollectionView.frame.width
//            let cellHeight = heightForText(paragraphsTitles[indexPath.item], width: width - 46) +  heightForText(paragraphsText[indexPath.item], width: width - 46) + 46
            let cellHeight = heightForText(paragraphs[indexPath.item][0], width: width - 46) +  heightForText(paragraphs[indexPath.item][1], width: width - 46) + 46
            
            collectionViewHeight += cellHeight + 16
        }
        return collectionViewHeight
    }
    
    //for more option button
    func moreOptionTapped(cellNum: Int, selectedOption: String) {
        print(String(cellNum) + " " + selectedOption)
        switch selectedOption {
        case "북마크 등록/해제":
            callPatchAPI()
            break
        case "단락 복사":
            print("copy")
//            var wrting = paragraphsTitles[cellNum] + "\n" + paragraphsText[cellNum]
            var wrting = paragraphs[cellNum][0] + "\n" + paragraphs[cellNum][1]
            
            copyToClipboardAndShowToast(text: wrting, viewController: self)
        default:
            print("error")
        }
    }
}
