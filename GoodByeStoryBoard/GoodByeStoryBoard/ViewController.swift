//
//  ViewController.swift
//  GoodByeStoryBoard
//
//  Created by Tee Becker on 9/24/20.
//

import UIKit

class ViewController: UIViewController {

    var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(handleLoginTouchUpInside), for: .touchUpInside)
        
        autoLayoutConstraints()
    }


    func autoLayoutConstraints(){
        NSLayoutConstraint.activate([
        
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    @objc func handleLoginTouchUpInside(){
        print("Login has been tapped")
        
//        if nameTextField.isFirstResponder{
//            nameTextField.resignFirstResponder()
//        }
//        if passwordTextField.isFirstResponder {
//            passwordTextField.resignFirstResponder()
//        }
    }
    
    
}

