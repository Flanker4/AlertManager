//
//  AlertPresentOperation.swift
//
//  Created by Boyko Andrey on 8/18/15.
//  Copyright (c) 2015 LOL. All rights reserved.
//

import UIKit

final class PresentAlertOperation: NSOperation {
    
    
    //
    //MARK: - Init
    //
    init(alertController: UIAlertController,
        presenter: UIViewController,
        animated: Bool,
        completionAnimationBlock: (() -> Void)?)
    {
        _alertController            = alertController
        _presenterViewController    = presenter
        _animationFlag              = animated
        _completionAnimationBlock   = completionAnimationBlock
        super.init()
    }
    
    convenience init(alertController: UIAlertController, presenter: UIViewController){
        self.init(alertController: alertController,presenter: presenter, animated:false, completionAnimationBlock:nil)
    }
    
    //
    //MARK: - Private
    //
    private var _finished = false
    private var _executing = false

    private var      _alertController: UIAlertController!
    private weak var _presenterViewController: UIViewController!
    private var      _animationFlag:Bool
    private var      _completionAnimationBlock: (() -> Void)?
    
    
    //
    //MARK: - Override
    //
    override var ready:         Bool { return true }
    override var asynchronous:  Bool { return true }

    override var executing:Bool {
        get { return _executing }
        set {
            willChangeValueForKey("isExecuting")
            _executing = newValue
            didChangeValueForKey("isExecuting")
        }
    }
    
    override var finished:Bool {
        get { return _finished }
        set {
            willChangeValueForKey("isFinished")
            _finished = newValue
            didChangeValueForKey("isFinished")
        }
    }

    override func start() {
        self.executing = true
        
        if (self.cancelled==true){
            self.finish()
            return
        }
        _presenterViewController.presentViewController(_alertController,
            animated: _animationFlag,
            completion: _completionAnimationBlock)
    }
    
    //
    //MARK: - Public methods
    //
    final func finish(){
        if (self.executing){
            self.finished = true;
            self.executing = false;
        }
    }
    
    final func tryFinishOperation(alertController:UIAlertController){
        if  alertController.isEqual(_alertController) {
            self.finish()
        }
    }
    
    
}
