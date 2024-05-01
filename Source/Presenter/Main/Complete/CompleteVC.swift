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
    lazy var formatText : String = "format\nformat"
    lazy var purposeText : String = "purpose\n\npurpose"
    lazy var paragraphsTitle : [String] = ["Paragraph 1", "Paragraph 2", "Paragraph 3", "Paragraph 4", "Paragraph 5", "Paragraph 6", "Paragraph 7", "Paragraph 8", "Paragraph 9"]
    lazy var paragraphsText : [String] = ["Paragraph 1\n\n\n\nParagraph 1Paragraph 1", "Paragraph 2\n\n\nParagraph 1Paragraph 1Paragraph 2", "Paragraph 3\n\n\nParagraph 3Paragraph 3Paragraph 3", "Paragraph 4\n\n\nParagraph 3Paragraph 3Paragraph 4", "Paragraph 5\n\n\nParagraph 3Paragraph 3Paragraph 5", "Paragraph 6\n\n\nParagraph 6", "Paragraph 7\n\n\nParagraph 3Paragraph 3Paragraph 7", "Paragraph 8\n\n\nParagraph 3Paragraph 3Paragraph 8", "Paragraph 9\n\n\nParagraph 9"]
    
    
//    lazy var collectionViewHeight: CGFloat = 0
    
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
        
        button.setTitle("저장 및 내보내기", for: .normal)
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
    
    @objc func mypageButtonTapped() {
        print("mypage tapped")
    }
    
    @objc func saveButtonTapped() {
        print("save tapped")
        if let VC = navigationController?.viewControllers.first(where: {$0 is MainVC}) {
            navigationController?.popToViewController(VC, animated: true)
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

        [completeTitle, formatSubtitle, formatLabel, purposeSubtitle, purposeLabel, completeWritingSubtitle, completeWritingCollectionView, saveButton].forEach { view in
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
        
        completeWritingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(completeWritingSubtitle.snp.bottom).offset(top / 2)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(calculateCollectionViewHeight())
//            make.height.equalTo(150)
//            make.bottom.equalTo(saveButton.snp.top).offset(-top)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(53)
//            make.top.equalTo(completeWritingCollectionView.snp.bottom).offset(top)
            make.bottom.equalToSuperview().offset(-top)
//            make.top.equalTo(completeWritingCollectionView.snp.bottom).offset(top)
        }
    }
  

}

//set collectionView
extension CompleteVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paragraphsTitle.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "completeCell", for: indexPath) as! CompleteCell
        
        cell.paragraphTitleLabel.text = paragraphsTitle[indexPath.item]
        cell.paragraphTextLabel.text = paragraphsText[indexPath.item]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = heightForText(paragraphsTitle[indexPath.item], width: width - 46) +  heightForText(paragraphsText[indexPath.item], width: width - 46) + 46
        
//        self.collectionViewHeight += height + 16
        print(height)
        print("CV")
        
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
        
        for i in 0 ..< paragraphsText.count {
            let indexPath = IndexPath(row: i, section: 0)
            let width = completeWritingCollectionView.frame.width
            let cellHeight = heightForText(paragraphsTitle[indexPath.item], width: width - 46) +  heightForText(paragraphsText[indexPath.item], width: width - 46) + 46
            
            collectionViewHeight += cellHeight + 16
        }
        return collectionViewHeight
    }
}
