//
//  ViewControllerWithoutSubclass.swift
//  AlertPresenterViewController
//
//  Created by Boyko Andrey on 8/19/15.
//  Copyright (c) 2015 LOL. All rights reserved.
//

import UIKit

class ViewControllerWithoutSubclass: UIViewController {

    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.redColor()
    }
    override func viewWillAppear(animated: Bool) {
        let alertManager = AlertControllerManager.sharedAlertManager;
        alertManager.presentAlertController(self.tmpAlertController(1), inViewController: self);
        alertManager.presentAlertController(self.tmpAlertController(2)).completionBlock = {
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    
    func tmpAlertController(number: Int) -> UIAlertController {
        let alertController = UIAlertController(title: "Some title \(number)", message: "Some message", preferredStyle: .Alert)
        
        let action = UIAlertAction (title: "Ok", style: .Cancel) { action in
            AlertControllerManager.sharedAlertManager.didDissmissAlertController(alertController)
        }
        
        alertController.addAction(action)
        return alertController
    }

}
