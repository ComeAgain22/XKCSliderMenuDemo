//
//  XKCSwitchViewController.swift
//  XKCSliderMenuDemo
//
//  Created by DIS on 2017/2/3.
//  Copyright © 2017年 ComeAgain22. All rights reserved.
//

import UIKit

class XKCSwitchViewController: UIViewController {

    class func initWithTitle(title: String) -> UIViewController {
        let rootViewController = XKCSwitchViewController.init()
        let navigationViewController = UINavigationController.init(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        return navigationViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.green
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(switchBackLeftViewController))
    }
    
    func switchBackLeftViewController() {
        XKCDrawerViewController.shareDrawerViewController.switchBackLeftViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
