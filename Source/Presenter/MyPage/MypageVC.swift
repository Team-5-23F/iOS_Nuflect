//
//  MypageVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/19/24.
//

import Foundation
import UIKit

class MypageVC: UIViewController, UIScrollViewDelegate {
    //MARK: - Properties
    
    // MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //스크롤을 위한 스크롤 뷰
    lazy var scrollView:UIScrollView = {
        let view = UIScrollView()
        
        // 필요시 true로 수정
        view.isScrollEnabled = false
        
        return view
    }()
    
    //스크롤 뷰 안에 들어갈 내용을 표시할 뷰
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // User name label
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nuflect님"
        label.textColor = UIColor.Nuflect.black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.Nuflect.headtitleSemiBold
        
        return label
    }()
    
    // Line
    lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Nuflect.lightGray
        
        return view
    }()
    
    // History Subtitle Label
    lazy var historySubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "저장 내역"
        label.textColor = UIColor.Nuflect.black
        label.textAlignment = .left
        label.font = UIFont.Nuflect.subheadBold
        
        return label
    }()
    
    // History collectionView 선언
    lazy var historyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        
        return view
    }()
    
    // App Subtitle Label
    lazy var appSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 정보 및 문의"
        label.textColor = UIColor.Nuflect.black
        label.textAlignment = .left
        label.font = UIFont.Nuflect.subheadBold
        
        return label
    }()
    
    // App collectionView 선언
    lazy var appCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        
        return view
    }()
    
    // User Subtitle Label
    lazy var userSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "계정"
        label.textColor = UIColor.Nuflect.black
        label.textAlignment = .left
        label.font = UIFont.Nuflect.subheadBold
        
        return label
    }()
    
    // User collectionView 선언
    lazy var userCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        
        return view
    }()
    
    //MARK: - Define Method
    @objc func backButtonTapped() {
        print("back tapped")
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    //VC의 view 관련 설정
    func setView() {
        setNavigationBar()
        addSubView()
        setCollectionView()
        self.view.backgroundColor = UIColor.Nuflect.white
    }
    
    //Set scrollview size to fit contentView
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(700)
        }
        scrollView.contentSize = contentView.frame.size
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
        
        [userNameLabel, underLine, historySubtitleLabel, historyCollectionView, appSubtitleLabel, appCollectionView, userSubtitleLabel, userCollectionView].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
        let leading = 16
        let top = 15
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
//        contentView.snp.makeConstraints { make in
//            make.width.equalTo(view.snp.width)
//            make.height.equalTo(700)
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(top)
            make.leading.equalToSuperview().offset(leading)
        }
        
        underLine.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(8)
            make.top.equalTo(userNameLabel.snp.bottom).offset(top)
            make.centerX.equalToSuperview()
        }
        
        historySubtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(underLine.snp.bottom).offset(top * 2)
        }
        
        historyCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(historySubtitleLabel.snp.bottom).offset(top / 2)
            make.height.equalTo(100)
        }
        
        appSubtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(historyCollectionView.snp.bottom).offset(top * 2)
        }
        
        appCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(appSubtitleLabel.snp.bottom).offset(top / 2)
            make.height.equalTo(166)
        }
        
        userSubtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(appCollectionView.snp.bottom).offset(top * 2)
        }
        
        userCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(userSubtitleLabel.snp.bottom).offset(top / 2)
            make.height.equalTo(100)
        }
    }
}

//set collectionView
//MARK: - extension
extension MypageVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func setCollectionView() {
        [historyCollectionView, appCollectionView, userCollectionView].forEach { collectionView in
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.isScrollEnabled = false
            collectionView.register(MypageCell.self, forCellWithReuseIdentifier: "mypageCell")
//            collectionView.contentOffset
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == historyCollectionView {
            return 2
        } else if collectionView == appCollectionView {
            return 3
        } else if collectionView == userCollectionView {
            return 2
        }
        return 0
    }
    
    // cell에 들어갈 data 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let historyCellText = ["전체 글 저장 내역", "단락별 저장 내역"]
        let infoCellText = ["앱 버전", "약관 및 정책", "문의하기"]
        let accountCellText = ["로그아웃", "탈퇴하기"]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mypageCell", for: indexPath) as! MypageCell
        
        if collectionView == historyCollectionView{
            cell.textLabel.text = historyCellText[indexPath.row]
            
        } else if collectionView == appCollectionView {
            cell.textLabel.text = infoCellText[indexPath.row]
            
        } else if collectionView == userCollectionView{
            cell.textLabel.text = accountCellText[indexPath.row]
        }
        
        return cell
    }
    
    // cell 크기 및 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case historyCollectionView:
            let width: CGFloat = historyCollectionView.frame.width
            let height = historyCollectionView.frame.height / 2
            let size = CGSize(width: width, height: height)
            return size
        case appCollectionView:
            let width: CGFloat = appCollectionView.frame.width
            let height = appCollectionView.frame.height / 3
            let size = CGSize(width: width, height: height)
            return size
        case userCollectionView:
            let width: CGFloat = userCollectionView.frame.width
            let height = userCollectionView.frame.height / 2
            let size = CGSize(width: width, height: height)
            return size
        default:
            return CGSize.zero
        }
    }
    
    
    // -> cell 액션 이벤트(눌렀을 때 페이지 이동)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == historyCollectionView {
            switch indexPath.row {
            case 0:
                let VC = WritingHistoryVC()
                VC.writingFormats = ["F1", "F2", "F3"]
                VC.writingpurposes = ["P1", "P2", "P3"]
                self.navigationController?.pushViewController(VC, animated: true)
            case 1:
                let VC = BookmarkParagraphVC()
                self.navigationController?.pushViewController(VC, animated: true)
                VC.paragraphFormats = ["F1", "F2", "F3"]
                VC.paragraphpurposes = ["P1", "P2", "P3"]
                VC.paragraphtitles = ["PP1", "PP2", "PP3"]
            default :
                return
            }
        } else if collectionView == appCollectionView {
            switch indexPath.row {
            case 0:
                self.showToast(message: "Beta 1.0", duration: 2, delay: 1)
            case 1:
                self.showToast(message: "구현 예정", duration: 1, delay: 0.5)
            case 2:
                self.showToast(message: "구현 예정", duration: 1, delay: 0.5)
            default :
                return
            }
        } else if collectionView == userCollectionView {
            switch indexPath.row {
            case 0:
                navigationController?.popToRootViewController(animated: true)
            case 1:
                self.showToast(message: "구현 예정", duration: 1, delay: 0.5)
            default :
                return
            }
        } else {
            return
        }
    }
}
