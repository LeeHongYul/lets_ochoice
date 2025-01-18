//
//  ViewController.swift
//  lets_ochoice
//
//  Created by homechoic on 1/13/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    // UI Elements
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true // 비밀번호 입력 필드
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("앱 시작하기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        
        // ViewController 배경 색상 설정
        view.backgroundColor = .white
        
        // UI 요소들을 뷰에 추가
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        // 오토 레이아웃 설정
        setupConstraints()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // UI 요소들의 제약 조건 설정
    private func setupConstraints() {
        // 아이디 텍스트 필드
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            usernameTextField.widthAnchor.constraint(equalToConstant: 250),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // 비밀번호 텍스트 필드
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 250),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // 로그인 버튼
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // 로그인 버튼 클릭 처리 함수
       @objc private func handleLogin() {
           guard let username = usernameTextField.text, !username.isEmpty,
                 let password = passwordTextField.text, !password.isEmpty else {
               // 아이디나 비밀번호가 비어있는 경우 경고 표시
               let alert = UIAlertController(title: "경고", message: "아이디와 비밀번호를 입력해주세요.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "확인", style: .default))
               present(alert, animated: true)
               return
           }
           
           // 로그인 처리 (아이디와 비밀번호가 맞는지 확인)
           if username == "1" && password == "1" {
               // 로그인 성공 시, 다른 화면으로 이동 (예: Main 화면)
               let alert = UIAlertController(title: "로그인 성공", message: "앱을 시작합니다!", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                   // 로그인 성공 후 이동 (Main 화면으로 가는 예시)
                 
                   self.navigateToMainScreen()
               }))
               present(alert, animated: true)
           } else {
               // 로그인 실패 시, 경고 메시지
               let alert = UIAlertController(title: "로그인 실패", message: "아이디나 비밀번호가 틀렸습니다.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "확인", style: .default))
               present(alert, animated: true)
           }
       }
    
    // Main 화면으로 이동
        private func navigateToMainScreen() {
            // MainViewController 생성
            let mainViewController = MainViewController()
            
            // 내비게이션 컨트롤러를 통해 화면 전환
            navigationController?.pushViewController(mainViewController, animated: true)
        }
}
