//
//  ReasonViewController.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-06-27.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class ReasonViewController: UIViewController {
    
    var selectedInfo:[String:Any] = [:]
    
    let customAlert = CustomAlert()
    
    let notificationCenter = NotificationCenter.default
    
    
    let headingLabel:UILabel = {
        
        let label = UILabel()
        label.text = "Give reason for \nthe leave "
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightSemibold)
        label.numberOfLines = 2
        label.textColor = CustomColor.whiteCream
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.text = "You must be give  a reason, why you are request the leave.Reason must be well exaplane and clear the point."
        label.textColor = CustomColor.whiteCream
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var reasonTextView:UITextView = {
        
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = CustomColor.ash
        tv.text = "Write your reason...."
        tv.backgroundColor = CustomColor.whiteCream
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
        
    }()
    
    var reasonTextViewBottomAnchor:NSLayoutConstraint?
    
    let nextButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Reason"
        
        setupKeyBoardObservers()
        configureTextView()
        
        layoutSubviews()
        
        view.backgroundColor = CustomColor.darkGreen
        
        configNavbarBtn()
        
        nextButton.isEnabled = false
        
    }
    
    fileprivate func configNavbarBtn(){
        
        let icoSize = CGSize(width: 22, height: 22)
        nextButton.setImageButton(of: #imageLiteral(resourceName: "next_ico"), in: icoSize, shapeUsingButtonRadius: 0)
        nextButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        nextButton.addTarget(target: self, action: #selector(segueToNextPage))
        nextButton.isEnabled = false
        
        let barBtnItem = UIBarButtonItem(customView: nextButton)
        navigationItem.rightBarButtonItem = barBtnItem
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationCenter.removeObserver(self)
    }
    
    fileprivate func configureTextView(){
        reasonTextView.keyboardDismissMode = .onDrag
        reasonTextView.alwaysBounceVertical = true
        reasonTextView.layer.cornerRadius = 3
        reasonTextView.clipsToBounds = true
    }
    
    
    
    
    //MARK: - Layout Sub views
    
    fileprivate func layoutSubviews(){
        
        view.addSubview(headingLabel)
        headingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        
        view.addSubview(descriptionLabel)
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 8).isActive = true
        
        view.addSubview(reasonTextView)
        
        reasonTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant:8).isActive = true
        reasonTextView.leftAnchor.constraint(equalTo: view.leftAnchor,constant:8).isActive = true
        reasonTextView.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-8).isActive = true
        reasonTextViewBottomAnchor = reasonTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant:-16)
        reasonTextViewBottomAnchor?.isActive = true
        
    }
    
    
    //MARK: - Handle the keyboard observes
    
    fileprivate func setupKeyBoardObservers(){
        
        notificationCenter.addObserver(self, selector: #selector(keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(KeyBoardWllHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
    }
    
    @objc func keyBoardWillShow(notification:Notification){
        
        let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGRect
        let keyboardAnimationKey = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate(withDuration: keyboardAnimationKey) {
            
            self.reasonTextViewBottomAnchor?.constant = -(keyboardFrame.height + 8)
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    @objc func KeyBoardWllHide(notification:Notification){
        
        let keyboardAnimationKey = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate(withDuration: keyboardAnimationKey) {
            
            self.reasonTextViewBottomAnchor?.constant = -16
            self.view.layoutIfNeeded()
            
        }
    }
    
    
    // MARK: - Navigation
    
    
    
    @objc func segueToNextPage(){
        guard let destinationViewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardID.finalRequestForm) as? FilledFormViewController else{
            customAlert.pop(with: "System error happend.Error code is VC_Null:FINAL_FORM.Please connect with softwear provider.", "will concern", "Opps..!", #imageLiteral(resourceName: "system_error"))
            return
        }
        guard selectedInfo[dbAttributename.reqReason] != nil else{
            customAlert.pop(with: "Please Give a Reason for why you are requesting leave.", "goes empty", "give one", #imageLiteral(resourceName: "empty_buket"))
            return
        }
        destinationViewController.selectedInfo = selectedInfo
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
}

extension ReasonViewController:UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        guard textView.textColor == CustomColor.ash else{return}
        textView.text = ""
        textView.textColor = CustomColor.darkAsh
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView.text == "Write your reason...."{
            textView.text = ""
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        guard textView.text != "", textView.text != "Write your reason...." else{
            textView.textColor = CustomColor.ash
            textView.text = "Write your reason...."
            nextButton.isEnabled = false
            return
        }
        nextButton.isEnabled = true
        selectedInfo[dbAttributename.reqReason] = textView.text
        
    }
    
    
}
