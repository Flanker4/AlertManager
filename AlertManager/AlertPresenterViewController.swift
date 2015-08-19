//
//  AlertPresenterViewController.swift
//  AlertPresenterViewController
//
//  Created by Boyko Andrey on 8/18/15.
//  Copyright (c) 2015 LOL. All rights reserved.
//

import UIKit

class AlertPresenterViewController: UIViewController {

    lazy private var alertManager = AlertControllerManager()

    //
    //MARK: -Present methods
    //
    final func presentAlertController(alertController: UIAlertController,
                                             animated: Bool = true,
                                  animationCompletion: (() -> Void)? = nil) -> NSOperation
    {
        return alertManager.presentAlertController(alertController, inViewController: self, animated: animated, completion: animationCompletion);
    }
    
    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
        let alertControl = self.presentedViewController as? UIAlertController
        super.dismissViewControllerAnimated(flag) {
            if let aController = alertControl{
                self.alertManager.didDissmissAlertController(aController)
            }
            completion?()
        }
    }

    

}

