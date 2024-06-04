//
//  KakaoAuthVM.swift
//  iOS_Nuflect
//
//  Created by Jiwoong's MacBook Air on 4/28/24.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuthVM: ObservableObject {
    var socialID: String = ""
    var nickname: String = ""
    
    var subscriptions = Set<AnyCancellable>()
    
    @Published var isLoggedIn : Bool = false
    
    init() {
        print("KakaoAuthVM - init() called")
    }
    
    // 카카오톡 앱으로 로그인 인증
    func kakaoLoginWithApp() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    //do something
                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
        
    }
    
    // 카카오 계정으로 로그인
    func kakaoLoginWithAccount() async -> Bool {
        
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    
                    //do something
                    print(oauthToken)
//                    _ = oauthToken
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    @MainActor
    func KakaoLogin() async -> Bool {
        print("KakaoAuthVM - handleKakaoLogin() called")
        
        return await withCheckedContinuation { continuation in
            Task {
                let loginSuccess: Bool
                // 카카오톡 실행 가능 여부 확인
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    // 카카오톡 앱으로 로그인 인증
                    loginSuccess = await kakaoLoginWithApp()
                } else { // 카카오톡 계정으로 로그인 인증
                    loginSuccess = await kakaoLoginWithAccount()
                }
                // 처리 결과 반환
                continuation.resume(returning: loginSuccess)
            }
        }
    } // KakaoLogin()
    
    @MainActor
    func kakaoLogout() {
        Task {
            if await handleKakaoLogOut() {
                self.isLoggedIn = false
            }
        }
    }
    
    func handleKakaoLogOut() async -> Bool {
        await withCheckedContinuation { continuation in
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
} // class KakaoAuthVM
