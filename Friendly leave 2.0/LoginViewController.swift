//
//  LoginViewController.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-05-21.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let signinLabel:UILabel = {
        let label = UILabel()
        label.text = "Signin"
        label.textAlignment = .center
        label.textColor = CustomColor.green
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightRegular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userNameTxtField:CustomTextField = {
        let txt = CustomTextField()
        txt.setImage(#imageLiteral(resourceName: "email_ico"), with: .alwaysTemplate)
        txt.placeholder = "Email...."
        txt.leftViewLeftMargin = 4
        txt.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)
        txt.textColor = CustomColor.subHeadingTxtColor
        txt.itemTintColor = CustomColor.shadowBlue
        txt.rightViewRightMargin = 8
        txt.setClearButton(#imageLiteral(resourceName: "clear_ico"), with: .alwaysTemplate, true)
        txt.isWithBottomLine = true
        txt.delegate = self
        
        txt.translatesAutoresizingMaskIntoConstraints = false
        
        return txt
    }()
    
    lazy var passwordTxtField:CustomTextField = {
        let txt = CustomTextField()
        txt.setImage(#imageLiteral(resourceName: "password_ico"), with: .alwaysTemplate)
        txt.placeholder = "Password...."
        txt.leftViewLeftMargin = 4
        txt.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightRegular)
        txt.textColor = CustomColor.subHeadingTxtColor
        txt.itemTintColor = CustomColor.shadowBlue
        txt.rightViewRightMargin = 8
        txt.setClearButton(#imageLiteral(resourceName: "clear_ico"), with: .alwaysTemplate, true)
        txt.isWithBottomLine = true
        txt.isSecureTextEntry = true
        
        
        txt.delegate = self
        txt.translatesAutoresizingMaskIntoConstraints = false
        
        return txt
    }()
    
    lazy var loginBtn:CustomButton = {
        
        let btn = CustomButton()
        btn.addTarget(target: self, action: #selector(loginClick))
        btn.titleLabel.text = "GO..!".uppercased()
        btn.titleLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        btn.backgroundColor = CustomColor.shadowBlue
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.shadowOffset = CGSize(width: 0, height: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let alerView:CustomAlert = {
        let av = CustomAlert()
        av.okButton.titleLabel.text = "ok"
        return av
    }()
    
    let statusBarBackground:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.shadowBlue
        return view
    }()
    
    let signinContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.whiteCream
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
    }
    
    fileprivate func layoutViews(){
        
        let topBottomConstant:CGFloat = (self.view.frame.size.height * 0.6) * 0.1
        guard let mainWindow = (UIApplication.shared.delegate as? AppDelegate)?.window else{return}
        let mainBoundsSize = UIScreen.main.bounds
        
        statusBarBackground.frame = CGRect(x: 0, y: 0, width: mainBoundsSize.width, height: 20)
        mainWindow.addSubview(statusBarBackground)
        
        
        
        view.addSubview(signinContainerView)
        signinContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signinContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        signinContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        signinContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        signinContainerView.addSubview(signinLabel)
        signinLabel.topAnchor.constraint(equalTo: signinContainerView.topAnchor, constant: topBottomConstant).isActive = true
        signinLabel.centerXAnchor.constraint(equalTo: signinContainerView.centerXAnchor).isActive = true
        
        signinContainerView.addSubview(loginBtn)
        loginBtn.centerXAnchor.constraint(equalTo: signinContainerView.centerXAnchor).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 42).isActive = true
        loginBtn.widthAnchor.constraint(equalTo: signinContainerView.widthAnchor, multiplier: 0.6).isActive = true
        loginBtn.bottomAnchor.constraint(equalTo: signinContainerView.bottomAnchor, constant: -topBottomConstant).isActive = true
        
        signinContainerView.addSubview(passwordTxtField)
        passwordTxtField.centerXAnchor.constraint(equalTo: signinContainerView.centerXAnchor).isActive = true
        passwordTxtField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTxtField.widthAnchor.constraint(equalTo: signinContainerView.widthAnchor, multiplier: 0.8).isActive = true
        passwordTxtField.bottomAnchor.constraint(equalTo: loginBtn.topAnchor, constant: -(topBottomConstant * 2.3)).isActive = true
        
        signinContainerView.addSubview(userNameTxtField)
        userNameTxtField.centerXAnchor.constraint(equalTo: signinContainerView.centerXAnchor).isActive = true
        userNameTxtField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        userNameTxtField.widthAnchor.constraint(equalTo: signinContainerView.widthAnchor, multiplier: 0.8).isActive = true
        userNameTxtField.bottomAnchor.constraint(equalTo: passwordTxtField.topAnchor, constant: -(topBottomConstant * 0.3)).isActive = true
        
        
    }
    
    // MARK: - Controll Sign in
    
    @objc func loginClick() {
        
        guard   userNameTxtField.text != "", userNameTxtField.text != nil, passwordTxtField.text != "", passwordTxtField.text != nil else{
            alerView.pop(with: "Password or Username is empty.", "goes empty", "check and fill", #imageLiteral(resourceName: "signin_error"))
            return
        }
        
        guard let email = userNameTxtField.text, let password = passwordTxtField.text else{
            alerView.pop(with: "Something went wrong, please check and do again.", "Opps..!", "try again", #imageLiteral(resourceName: "system_error"))
            return
        }
        
        SigninOutRequest.signin(user: email, for: password) { (data: (isSign:Bool, err:String?)) in
            
            guard data.isSign else{
                self.dosigninErrorTask(with: data.err)
                return
            }
            
            UserDefaults.standard.set(true, forKey: NSUserDefaultKey().isFreshCome)
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardID.mainApp)else{
                fatalError()
            }
            self.present(viewController, animated: true, completion: nil)
        }
        
    }
    
    fileprivate func dosigninErrorTask(with error:String?){
        
        alerView.pop(with: error ?? "Something went wrong.Please try again.", "signin erorr", "try again", #imageLiteral(resourceName: "signin_error"))
        userNameTxtField.text = ""
        passwordTxtField.text = ""
        
    }
    
    
    
}

extension LoginViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
