//
//  XKCMainViewController.swift
//  Delorean
//
//  Created by DIS on 2017/2/2.
//  Copyright © 2017年 DIS. All rights reserved.
//

import UIKit

class XKCMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        let buttonTest = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 50))
        buttonTest.backgroundColor = UIColor.blue
        buttonTest.setTitle("点击", for: .normal)
        buttonTest.addTarget(self, action: #selector(openDrawer), for: .touchUpInside)
        view.addSubview(buttonTest)
    }
    
    func openDrawer() {
        XKCDrawerViewController.shareDrawerViewController.openDrawer(openDrawerWithDuration: 0.2)
    }

    
    func edgePanGrstureRacognizer(edgePan: UIPanGestureRecognizer) {
        XKCDrawerViewController.shareDrawerViewController.edgePanGrstureRacognizer(edgePan: edgePan)
    }
    
    /// - parameter pan: 手势
    func panGestureRecognizer(pan: UIPanGestureRecognizer) {
        XKCDrawerViewController.shareDrawerViewController.panGestureRecognizer(pan: pan)
    }
    
    func tapGestureRecognizer(tap: UITapGestureRecognizer) {
        XKCDrawerViewController.shareDrawerViewController.tapGestureRecognizer(tap:tap)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
