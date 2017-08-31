//
//  StartPageViewController.swift
//  Friendly leave 2.0
//
//  Created by Malith Nadeeshan on 2017-08-21.
//  Copyright © 2017 Malith Nadeeshan. All rights reserved.
//

import UIKit

class StartPageViewController: UIViewController {
    
    let customTransition = CircularTransmission()
    
    @IBOutlet weak var itemContainerSV: UIStackView!
    @IBOutlet weak var goButton: UIButton!
    var goButtonCenterY:CGFloat{
        
        return goButton.center.y + itemContainerSV.frame.origin.y
    }
    var goButtonCenter:CGPoint{
        return CGPoint(x: goButton.center.x + 16, y: goButtonCenterY)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destinationVC = segue.destination as? ApplyLeaveNavigationController else{return}
        destinationVC.transitioningDelegate = self
        destinationVC.modalPresentationStyle = .custom
        
    }
    
    
    
}

extension StartPageViewController:UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        customTransition.transmissionMode = .present
        customTransition.startPoint = goButtonCenter
        customTransition.circlColour = goButton.backgroundColor!
        return customTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        customTransition.transmissionMode = .dismiss
        customTransition.startPoint = goButtonCenter
        customTransition.circlColour = goButton.backgroundColor!
        
        return customTransition
    }
    
}
