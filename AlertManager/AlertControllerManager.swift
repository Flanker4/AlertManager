//
//  AlertPresenterViewController.swift
//  AlertPresenterViewController
//
//  Created by Boyko Andrey on 8/18/15.
//  Copyright (c) 2015 LOL. All rights reserved.
//

import UIKit

final class AlertControllerManager {
    static let sharedAlertManager = AlertControllerManager()

    //
    //MARK: - Private
    //
    private lazy var presentAlertQueue: NSOperationQueue = {
        var temporaryQueue = NSOperationQueue()
        temporaryQueue.maxConcurrentOperationCount = 1
        temporaryQueue.underlyingQueue = dispatch_get_main_queue()
        return temporaryQueue
    }()
    
    
    final func presentAlertController(alertController: UIAlertController,
                                     inViewController: UIViewController,
                                             animated: Bool = true,
                                           completion: (() -> Void)? = nil) -> NSOperation
    {
        let operation = PresentAlertOperation(alertController: alertController, presenter: inViewController, animated: animated, completionAnimationBlock: completion);
        self.presentAlertQueue.addOperation(operation);
        return operation;
    }
    
    final func didDissmissAlertController(alertController: UIAlertController) {
        for item in presentAlertQueue.operations {
            if let operation = item as? PresentAlertOperation {
                operation.tryFinishOperation(alertController)
            }
        }
      
    }
}
