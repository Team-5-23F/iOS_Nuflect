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
    lazy var scrollview:UIScrollView = {
        let view = UIScrollView()
        
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
        [navigationBar, scrollview].forEach { view in
            self.view.addSubview(view)
        }
        
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }
        
        [userNameLabel, underLine, historySubtitleLabel, historyCollectionView, appSubtitleLabel, appCollectionView, userSubtitleLabel, userCollectionView].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
        let leading = 16
        let top = 20
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        scrollview.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(700)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(navigationBar.snp.bottom).offset(top)
        }
        
        underLine.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(8)
            make.top.equalTo(userNameLabel.snp.bottom).offset(top * 2)
            make.centerX.equalToSuperview()
        }
        
        historySubtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(underLine.snp.bottom).offset(top * 3)
        }
        
        historyCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(historySubtitleLabel.snp.bottom).offset(top)
            make.height.equalTo(100)
        }
        
        appSubtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(historyCollectionView.snp.bottom).offset(top * 3)
        }
        
        appCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(appSubtitleLabel.snp.bottom).offset(top)
            make.height.equalTo(150)
        }
        
        userSubtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.top.equalTo(appCollectionView.snp.bottom).offset(top * 3)
        }
        
        userCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.top.equalTo(userSubtitleLabel.snp.bottom).offset(top)
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
            let height = appCollectionView.frame.height / 2
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
        print("1")
//        if collectionView == collectionView1 {
//            switch indexPath.row {
//            case 0:
//                let VC = ReportDoneViewController()
//                VC.fromVC = "MyPage"
//                navigationController?.pushViewController(VC, animated: true)
//            case 1:
//                let VC = CalculateHistoryViewController()
//                navigationController?.pushViewController(VC, animated: true)
//            default :
//                return
//            }
//        } else if collectionView == collectionView2 {
//            switch indexPath.row {
//            case 0:
//                showCustomAlert(alertType: .done,
//                                alertTitle: "앱 버전",
//                                alertContext: "ver 1.0 Demo",
//                                confirmText: "확인")
//            case 1:
//                let url:String = "https://www.naver.com/"
//                openURL(url)
//            case 2:
//                let VC = InquiryViewController()
//                navigationController?.pushViewController(VC, animated: true)
//            default :
//                return
//            }
//        } else if collectionView == collectionView3 {
//            switch indexPath.row {
//            case 0:
//                showCustomAlert(alertType: .canCancel,
//                                alertTitle: "로그아웃",
//                                alertContext: "정말로 로그아웃 하시겠습니까?",
//                                cancelText: "취소",
//                                confirmText: "로그아웃")
//            case 1:
//                let VC = WithdrawViewController()
//                navigationController?.pushViewController(VC, animated: true)
//            default :
//                return
//            }
//        } else {
//            return
//        }
        
    }
}
