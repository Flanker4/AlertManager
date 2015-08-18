//
//  ViewController.swift
//  AlertPresenterViewController
//
//  Created by Boyko Andrey on 8/18/15.
//  Copyright (c) 2015 LOL. All rights reserved.
//

import UIKit

class ViewController: AlertPresenterViewController {
    override func viewWillAppear(animated: Bool) {
        self.presentAlertController(self.tmpAlertController(1))
        self.presentAlertController(self.tmpAlertController(2)).cancel()
        self.presentAlertController(self.tmpAlertController(3)).completionBlock = {
            self.presentViewController(ViewControllerWithoutSubclass(), animated: true, completion: nil)
        }
        
    }
    
    func tmpAlertController(number: Int) -> UIAlertController {
        let alertController = UIAlertController(title: "Some title \(number)", message: "Some message", preferredStyle: .Alert)
        let action = UIAlertAction (title: "Ok", style: .Cancel, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}

