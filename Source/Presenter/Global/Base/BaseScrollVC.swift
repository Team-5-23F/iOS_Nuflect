//
//  BaseScrollVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/18/24.
//
import UIKit
import SnapKit

class BaseScrollVC: UIViewController, UIScrollViewDelegate {
    //MARK: - UI ProPerties
    lazy var navigationBar = UINavigationBar()
    
    //scroll view
    lazy var scrollview:UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    //container for scroll view
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
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
        addsubview()
        setscrollview()
    }
    
    func setNavigationBar() {
        let navigationItem = UINavigationItem()
        
        
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.barTintColor = .Nuflect.white // 배경색 변경
        navigationBar.shadowImage = UIImage() // 테두리 없애기
    }
    
    func addsubview() {
        [navigationBar, scrollview].forEach { view in
            self.view.addSubview(view)
        }
        
        [contentView].forEach { view in
            scrollview.addSubview(view)
        }

        [].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    //scroll view
    func setscrollview() {
        scrollview.delegate = self
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
