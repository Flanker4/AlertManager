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
    var defaultPresenterViewController:UIViewController?{
        var rootViewController = UIApplication.sharedApplication().delegate?.window??.rootViewController;
        
        while let topVC = rootViewController?.presentedViewController {
            rootViewController = topVC;
        }
        return rootViewController;
    }
    //
    //MARK: - Private
    //
    private lazy var presentAlertQueue: NSOperationQueue = {
        var temporaryQueue = NSOperationQueue()
        temporaryQueue.underlyingQueue = dispatch_get_main_queue()
        return temporaryQueue
    }()
    
    final func addDependecysForOperation(oper: PresentAlertOperation) {
        self.iterateAlertOperations { (operation) -> Void in
            if oper.isEqualPresenter(operation) {
                oper.addDependency(operation);
            }
        }

    }
    
    final func iterateAlertOperations(enumerateBlock:((operation: PresentAlertOperation) -> Void)) {
        for item in presentAlertQueue.operations {
            if let operation = item as? PresentAlertOperation {
                enumerateBlock(operation: operation)
            }
        }
    }
    
    //
    //MARK: - Public
    //
    final func presentAlertController(alertController: UIAlertController,
                                             animated: Bool = true,
                                           completion: (() -> Void)? = nil) -> NSOperation
    {
        if let presenter = self.defaultPresenterViewController {
            return self.presentAlertController(alertController, inViewController:presenter,
                animated: animated,
                completion: completion);
        }else{
            assert(false, "Default presenter not found. Please set default presenter. See defaultPresenterViewController");
            return NSOperation();
        }
    }
    final func presentAlertController(alertController: UIAlertController,
                                     inViewController: UIViewController,
                                             animated: Bool = true,
                                           completion: (() -> Void)? = nil) -> NSOperation
    {
        let operation = PresentAlertOperation(alertController: alertController, presenter: inViewController, animated: animated, completionAnimationBlock: completion);
        self.addDependecysForOperation(operation);
        self.presentAlertQueue.addOperation(operation);
        return operation;
    }
    
    final func didDissmissAlertController(alertController: UIAlertController) {
        self.iterateAlertOperations { (operation) -> Void in
            operation.tryFinishOperation(alertController)
        }
    }
}
