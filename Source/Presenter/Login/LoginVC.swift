//
//  LoginVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/18/24.
//

import UIKit
import SnapKit

class LoginVC: UIViewController {
    //MARK: - UI ProPerties
    //logo
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        
        return imageView
    }()
    
    //app name title
    lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nuflect"
        label.textColor = UIColor.Nuflect.black
        label.font = UIFont.Nuflect.headtitlebold
        
        return label
    }()
    
    //kakao login btn
    lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Btn_login_kakao"), for: .normal)
        button.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
        
        return button
    }()

    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        SetView()
        Constraint()
    }
    
    @objc func kakaoLoginButtonTapped(_ sender: UIButton) {
        print("kakao login button tapped")
        let VC = MainVC()
        navigationController?.pushViewController(VC, animated: true)
    }
    
    //MARK: - Properties
    
    
    //MARK: - Set Ui
    func SetView() {
        [logoImageView, appNameLabel, kakaoLoginButton].forEach { view in
            self.view.addSubview(view)
        }
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.Nuflect.white
    }
    
    func Constraint() {
        let leading = 30
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(240)
            make.height.equalTo(170)
            make.width.equalTo(170)
            make.centerX.equalToSuperview()
        }
        
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(150)
            make.leading.equalToSuperview().offset(leading)
            make.trailing.equalToSuperview().offset(-leading)
            make.height.equalTo(kakaoLoginButton.snp.width).multipliedBy(0.15)
        }
    }
  

}
