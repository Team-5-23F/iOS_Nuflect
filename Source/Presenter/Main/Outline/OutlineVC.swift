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
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        return view
    }()
    
    //MARK: - Define Method
    @objc func backButtonTapped() {
        print("back tapped")
    }
    
    @objc func mypageButtonTapped() {
        print("mypage tapped")
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
        setCollectionView()
        self.view.backgroundColor = UIColor.Nuflect.white
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        
        //back (left)
        let back = UIImage(systemName: "chevron.backward")
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 24, height: 24), false, 0.0)
        back?.draw(in: CGRect(x: 0, y: 0, width: 24, height: 24))
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
extension OutlineVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, outlineCollectionViewCellDelegate {
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
        switch indexPath.item {
        case paragraphs.count - 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addCell", for: indexPath) as! AddCell
            
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "outlineCell", for: indexPath) as! OutlineCell
            cell.delegate = self
            cell.cellNum = indexPath.item + 1
            cell.paragraphTitle.text = String(indexPath.item + 1) + ". " + paragraphs[indexPath.item]
            
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
    
    //More option button
    func moreOptionTapped(cellNum: Int, selectedOption: String) {
        print(String(cellNum) + " " + selectedOption)
    }
}
