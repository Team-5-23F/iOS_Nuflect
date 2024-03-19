//
//  MainVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/18/24.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    @objc func logoButtonTapped() {
        print("logo tapped")
    }
    
    @objc func mypageButtonTapped() {
        print("mypage tapped")
    }
    
    //MARK: - Properties
    
    
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
            .font: UIFont.Nuflect.subheadBold
        ]
        
        //logo (left)
        let logo = UIImage(named: "Logo")
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
    
    func addsubview() {
        [navigationBar, ].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
        let leading = 16
        let top = 40
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
        }
    }
  

}
