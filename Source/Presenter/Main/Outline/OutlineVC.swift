//
//  OutlineVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/19/24.
//

import UIKit
import SnapKit

class OutlineVC: UIViewController {
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    //MARK: - Set Ui
    func setView() {
        setNavigationBar()
        addsubview()
        self.view.backgroundColor = UIColor.Nuflect.white
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        
        //title (center)
        navigationItem.title = "Nuflect"
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.Nuflect.headtitleSemiBold
        ]
        
//                //logo (left)
//                let logo = UIImage(named: "img_logo")
//                UIGraphicsBeginImageContextWithOptions(CGSize(width: 33, height: 33), false, 0.0)
//                logo?.draw(in: CGRect(x: 0, y: 0, width: 33, height: 33))
//                let resizedLogo = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//                let logoImage = resizedLogo?.withRenderingMode(.alwaysOriginal)
//        
//                let leftButton = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: #selector(logoButtonTapped))
//        
//                //mypage button (right)
//                let mypage = UIImage(systemName: "person.circle")
//                UIGraphicsBeginImageContextWithOptions(CGSize(width: 33, height: 33), false, 0.0)
//                mypage?.draw(in: CGRect(x: 0, y: 0, width: 33, height: 33))
//                let resizedMypage = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//        
//                let rightButton = UIBarButtonItem(image: resizedMypage, style: .plain, target: self, action: #selector(mypageButtonTapped))
//                rightButton.tintColor = UIColor.Nuflect.black
//        
//        
//                navigationItem.leftBarButtonItem = leftButton
//                navigationItem.rightBarButtonItem = rightButton
        
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = .Nuflect.white // 배경색 변경
        navigationBar.tintColor = .clear
        navigationBar.shadowImage = UIImage() // 테두리 없애기
    }
    
    func addsubview() {
        [navigationBar, collectionView].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
        let leading = 16
        let titleLeading = 35
        let top = 40
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(800)
        }
    }
}

//set collectionView
extension OutlineVC: UICollectionViewDataSource, UICollectionViewDelegate {
    //set collectionView
    func setCollectionView() {
        collectionView.backgroundColor = .Nuflect.white
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
    }
    
    func registerCells() {
        let cellIdentifiers = [
            "CellIdentifier1": OutlineCell.self,
            "CellIdentifier2": OutlineCell.self,
            "CellIdentifier3": OutlineCell.self,
            "CellIdentifier4": OutlineCell.self
        ]

        cellIdentifiers.forEach { identifier, cellClass in
            collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        //각 인덱스에 대한 cell 등록
        switch indexPath.item {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier1", for: indexPath) as! OutlineCell
            
            return cell
            
        default:
            fatalError("Invalid cell index")
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        switch indexPath.item {
            //1번 cell에 대한 크기 지정, 가로는 뷰 크기와 동일 세로는 임의 지정
        case 0:
            let width = collectionView.frame.width
            let height: CGFloat = 68
            return CGSize(width: width, height: height)
            //2번 cell에 대한 크기 지정, 가로 세로 동일
        case 1:
            let width = collectionView.frame.width
            let heightRatio: CGFloat = 256 / 852
            let viewHeight = UIScreen.main.bounds.height
            return CGSize(width: width, height: viewHeight * heightRatio)
            //3번 cell에 대한 크기 지정, 뷰의 가로 값을 2로 나눈뒤 중간 여백을 뺀 값을 가로, 세로에 할당
        default:
            let width = (collectionView.frame.width / 2 - 5)
            let height = width
            return CGSize(width: width, height: height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        // 셀 클릭에 대한 액션
        case 0:
            break
        default:
            break
        }
    }
}
