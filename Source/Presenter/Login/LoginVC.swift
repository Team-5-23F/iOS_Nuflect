//
//  LoginVC.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 3/18/24.
//

import UIKit
import SnapKit
import KakaoSDKUser

class LoginVC: UIViewController {
    lazy var kakaoAuthVM = KakaoAuthVM()
    
    //MARK: - UI ProPerties
    //logo
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img_logo"))
        
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
        button.setImage(UIImage(named: "btn_login_kakao"), for: .normal)
        button.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
        
        return button
    }()

    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraint()
    }
    
    @objc func kakaoLoginButtonTapped(_ sender: UIButton) {
        print("kakao login button tapped")
        Task { [weak self] in
            if await kakaoAuthVM.KakaoLogin() {
                DispatchQueue.main.async {
                    UserApi.shared.me() { (user, error) in
                        if let error = error {
                            print(error)
                        }
                        
                        print("카카오로그인 성공")
                        
                        let userID = user?.kakaoAccount?.ci
                        print(userID)

                        let body = [
                            "social_id": userID
                        ]// as [String: Any]
                        
                        APIManger.shared.callPostRequest(baseEndPoint: .login, addPath: "", parameters: body) { JSON in
//                            let outline = JSON["Index"].arrayObject as [String]
//                            print(outline)
                            print(JSON)
                            
                            let VC = MainVC()
                            self?.navigationController?.pushViewController(VC, animated: true)
                        }
                        
//                        let VC = MainVC()
//                        self?.navigationController?.pushViewController(VC, animated: true)
                        
                    }
                }
            } else {
                print("Login failed.")
            }
        }
    }
    
    
    //MARK: - Set Ui
    func setView() {
        [logoImageView, appNameLabel, kakaoLoginButton].forEach { view in
            self.view.addSubview(view)
        }
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.Nuflect.white
    }
    
    func setConstraint() {
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
