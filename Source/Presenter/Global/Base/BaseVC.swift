//
//  BaseVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/18/24.
//

import UIKit
import SnapKit

class BaseVC: UIViewController {
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()

    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    //MARK: - Properties
    
    
    //MARK: - Set Ui
    func setView() {
        setNavigationBar()
        addSubView()
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        
        
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = .Nuflect.white // 배경색 변경
        navigationBar.shadowImage = UIImage() // 테두리 없애기
    }
    
    func addSubView() {
        [navigationBar, ].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    //auto layout
    func setConstraint() {
//        let leading = 16
//        let top = 44
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width)
        }
    }
}

