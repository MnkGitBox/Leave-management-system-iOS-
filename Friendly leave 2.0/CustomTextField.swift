//
//  CustomTextField.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-08-02.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += leftViewLeftMargin
        return leftViewRect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= rightViewRightMargin
        return rightViewRect
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(textFiledDidChangeText), for: UIControlEvents.editingChanged)
        self.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControlEvents.editingDidEnd)
        self.addTarget(self, action: #selector(textFieldDidBeganEditing), for: UIControlEvents.editingDidBegin)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(textFiledDidChangeText), for: UIControlEvents.editingChanged)
        self.addTarget(self, action: #selector(textFieldDidEndEditing), for: UIControlEvents.editingDidEnd)
        self.addTarget(self, action: #selector(textFieldDidBeganEditing), for: UIControlEvents.editingDidBegin)
    }
    
    override func draw(_ rect: CGRect) {
        
        if isWithBottomLine{
            
            line.strokeColor = itemTintColor?.cgColor ?? UIColor.lightGray.cgColor
            
            self.layer.addSublayer(withBottomLine())
            
        }
        
        super.draw(rect)
    }
    
    var leftViewLeftMargin:CGFloat = 0
    var rightViewRightMargin:CGFloat = 0
    fileprivate let imageView = UIImageView()
    fileprivate let clearBtn = CustomButton()
    fileprivate let line = CAShapeLayer()
    fileprivate var isBtnShowAnimation:Bool = true
    
    var isWithBottomLine:Bool = false{
        didSet{
            guard isWithBottomLine else{return}
            leftViewLeftMargin = 0
            rightViewRightMargin = 0
        }
    }
    
    
    var itemTintColor:UIColor?{
        didSet{
            guard let tintColor = itemTintColor else{
                imageView.tintColor = .blue
                clearBtn.imageTintColor = .blue
                //                line.strokeColor = UIColor.lightGray.cgColor
                return
            }
            imageView.tintColor = tintColor
            clearBtn.imageTintColor = tintColor
            //            line.strokeColor = tintColor.cgColor
        }
    }
    
    func setImage(_ image:UIImage,with renderingMode:UIImageRenderingMode){
        
        imageView.image = image.withRenderingMode(renderingMode)
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height:20)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        if let tintColor = itemTintColor{
            imageView.tintColor = tintColor
        }
        
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 36, height: 20)
        view.addSubview(imageView)
        
        leftViewMode = .always
        leftView = view
        
    }
    
    func setClearButton(_ image:UIImage,with renderingMode:UIImageRenderingMode ,_ isAnimated:Bool){
        isBtnShowAnimation = isAnimated
        
        let size = CGSize(width: 16, height: 16)
        clearBtn.setImageButton(of: image.withRenderingMode(renderingMode), in: size, shapeUsingButtonRadius: 10)
        clearBtn.addTarget(target: self, action: #selector(clearText))
        clearBtn.isShowShadow = false
        clearBtn.frame = CGRect(x: 8, y: 0, width: 16, height: 16)
        clearBtn.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        clearBtn.alpha = 0
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 24, height: 16)
        view.backgroundColor = .clear
        view.addSubview(clearBtn)
        
        rightViewMode = .always
        rightView = view
    }
    
    @objc func clearText(){
        guard text != "" else{return}
        text = ""
        performBtnAnimation(in: self)
    }
    
    fileprivate func performBtnAnimation(in textField:UITextField,isDefaultState isHide:Bool = false){
        
        guard isBtnShowAnimation else {return}
        
        var transformState:CGAffineTransform!
        var btnAlpha:CGFloat!
        if textField.text == "" || textField.text == nil || isHide{
            transformState = CGAffineTransform(scaleX: 0.001, y: 0.001)
            btnAlpha = 0
        }else{
            transformState = CGAffineTransform.identity
            btnAlpha = 1
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.clearBtn.transform = transformState
            self.clearBtn.alpha = btnAlpha
        }, completion: nil)
        
    }
    
    fileprivate func withBottomLine()->CAShapeLayer{
        
        
        let path = UIBezierPath()
        let startPoint = CGPoint(x: 0, y: self.frame.size.height)
        let endPoint = CGPoint(x: self.frame.size.width, y: self.frame.size.height)
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        
        line.path = path.cgPath
        line.lineWidth = 1
        line.lineCap = kCALineCapRound
        line.opacity = 0.6
        return line
    }
    
    @objc func textFiledDidChangeText(){
        performBtnAnimation(in: self)
    }
    
    @objc func textFieldDidEndEditing(){
        performBtnAnimation(in: self, isDefaultState: true)
    }
    
    @objc func textFieldDidBeganEditing(){
        performBtnAnimation(in:self)
    }
    
}


