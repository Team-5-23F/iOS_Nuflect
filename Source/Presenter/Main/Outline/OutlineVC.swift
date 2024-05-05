//
//  OutlineVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/19/24.
//

import UIKit
import SnapKit

class OutlineVC: UIViewController {
    //MARK: - Properties
    lazy var formatText : String = ""
    lazy var purposeText : String = ""
    //will get from API
    lazy var paragraphsTitle : [String] = []
    //is each paragrapgh written
    lazy var isWritten : [Bool] = []
    
    //will save written paragraph's text
    lazy var writtenParagraphsText : [String] = []
    
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //outline title
    lazy var outlineTitle: UILabel = {
        let label = UILabel()
        label.text = "추천받은 Outline을 기반으로\n단락별로 글을 작성해주세요"
        label.numberOfLines = 2
        label.font = UIFont.Nuflect.headtitlebold
        
        return label
    }()
    
    //outline collectionView
    lazy var outlineCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    //complete button
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.Nuflect.lightGray
        button.layer.cornerRadius = 11
        
        button.setTitle("작성 완료", for: .normal)
        button.setTitleColor(UIColor.Nuflect.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.Nuflect.subheadMedium
        
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
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
    
    @objc func completeButtonTapped() {
        print("complete tapped")
        //To do
        let VC = CompleteVC()
        VC.formatText = formatText
        VC.purposeText = purposeText
        VC.paragraphsTitle = paragraphsTitle
        VC.paragraphsText = writtenParagraphsText
        navigationController?.pushViewController(VC, animated: true)
    }
    
    func checkAllparagraphsIsWritten() {
        print("check all")
        for bool in isWritten {
            if !bool {
                print("false")
                return
            }
        }
        print("true")
        completeButton.backgroundColor = .Nuflect.mainBlue
        completeButton.setTitleColor(.Nuflect.white, for: .normal)
        completeButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
        for _ in 0 ..< paragraphsTitle.count {
            self.isWritten.append(false)
            self.writtenParagraphsText.append("")
        }
    }
    
    //MARK: - Set Ui
    func setView() {
        setNavigationBar()
        addSubView()
        setCollectionView()
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
        [outlineTitle, navigationBar, outlineCollectionView, completeButton].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
        let leading = 35
        let top = 20
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        outlineTitle.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        outlineCollectionView.snp.makeConstraints { make in
            make.top.equalTo(outlineTitle.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.bottom.equalTo(completeButton.snp.top).offset(-top)
        }
        
        completeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(53)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-top)
        }
    }
}

//set collectionView and delegates
extension OutlineVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, outlineCollectionViewCellDelegate, returnToOutlineVCDelegate {
    //set collectionView
    func setCollectionView() {
        outlineCollectionView.backgroundColor = .Nuflect.white
        outlineCollectionView.dataSource = self
        outlineCollectionView.delegate = self
        registerCells()
    }
    
    func registerCells() {
        let cellIdentifiers = [
            "outlineCell": OutlineCell.self,
            "addCell": AddCell.self,
        ]

        cellIdentifiers.forEach { identifier, cellClass in
            outlineCollectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        paragraphsTitle.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case paragraphsTitle.count:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath) as! AddCell
            
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "outlineCell", for: indexPath) as! OutlineCell
            cell.delegate = self
            cell.paragraphNum = indexPath.item
            cell.paragraphTitleLabel.text = String(indexPath.item + 1) + ". " + paragraphsTitle[indexPath.item]
            
            return cell
        }
        
        
    }
    
    //cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.width / 4
        return CGSize(width: width, height: height)
    }
    
    
    
    //cell touch action
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        //last cell, add button
        case paragraphsTitle.count:
            print("Add")
            //To do
            break
        default:
            print(indexPath.item)
            let VC = WritingVC()
            VC.paragraphNum = indexPath.item
            VC.paragraphTitle = paragraphsTitle[indexPath.item]
            navigationController?.pushViewController(VC, animated: true)
            break
        }
    }
    
    //for more option button
    func moreOptionTapped(paragraphNum: Int, selectedOption: String) {
        print(String(paragraphNum) + " " + selectedOption)
        switch selectedOption {
        case "단락 작성":
            let VC = WritingVC()
            VC.paragraphNum = paragraphNum
            VC.paragraphTitle = paragraphsTitle[paragraphNum]
            VC.writingTextView.text = writtenParagraphsText[paragraphNum]
            navigationController?.pushViewController(VC, animated: true)
            break
        
        //To do "이름 변경", "순서 변경", "단락 삭제"
            
        default:
            print("error")
        }
    }
    
    //for end writing a paragraph
    func returnToOutlineVC(paragraghNum: Int, paragraphContents: String) {
        print(String(paragraghNum))
        print(paragraphContents)
        
        self.isWritten[paragraghNum] = true
        self.writtenParagraphsText[paragraghNum] = paragraphContents
        
        //get cell, change color
        guard let cell = outlineCollectionView.cellForItem(at: IndexPath(item: paragraghNum, section: 0)) as? OutlineCell else {
            print("Failed to get cell at index \(String(paragraghNum))")
                    return
            }
        cell.backgroundColor = UIColor.Nuflect.inputBlue
        
        checkAllparagraphsIsWritten()
    }
}
