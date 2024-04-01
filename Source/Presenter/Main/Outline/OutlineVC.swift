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
    //will get from API
//    lazy var paragraphs : [String] = []
    lazy var paragraphs : [String] = ["Paragraph 1", "Paragraph 2", "Paragraph 3", "Paragraph 4", "Paragraph 5", "Paragraph 6", "Paragraph 7", "Paragraph 8", "Paragraph 9"]
    
    //check each paragrapgh is written
//    lazy var isWritten : [Bool] = []
    lazy var isWritten : [Bool] = [false, false, false, false, false, false, false, false, false]
    
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 8.0
//        layout.minimumInteritemSpacing = 8.0
//        layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 0.25)
//        let width = collectionView.frame.width
//        let height: CGFloat = width * 0.25
//        let size = CGSize(width: width, height: height)
//        layout.itemSize = size
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
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
        addSubView()
        setCollectionView()
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
    
    func addSubView() {
        [navigationBar, collectionView].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
        let leading = 35
        let top = 40
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(top)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
}

//set collectionView
extension OutlineVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //set collectionView
    func setCollectionView() {
        collectionView.backgroundColor = .Nuflect.white
        collectionView.dataSource = self
        collectionView.delegate = self
        registerCells()
    }
    
    func registerCells() {
        let cellIdentifiers = [
            "outlineCell": OutlineCell.self,
            "addCell": AddCell.self,
        ]

        cellIdentifiers.forEach { identifier, cellClass in
            collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        paragraphs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        //각 인덱스에 대한 cell 등록
        switch indexPath.item {
        case paragraphs.count - 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath) as! AddCell
            return cell
            
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "outlineCell", for: indexPath) as! OutlineCell
            return cell
//            fatalError("Invalid cell index")
        }
        
        
    }
    
    //cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
//        let width: CGFloat = 333
        let height = collectionView.frame.width / 4
        return CGSize(width: width, height: height)
    }
    
    
    
    //cell touch action
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case paragraphs.count - 1:
            print("Add")
            break
        default:
            print(indexPath.item)
            break
        }
    }
}
