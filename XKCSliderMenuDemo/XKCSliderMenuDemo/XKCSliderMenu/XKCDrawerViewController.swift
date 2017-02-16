//
//  XKCDrawerViewController.swift
//  Delorean
//
//  Created by DIS on 2017/2/2.
//  Copyright © 2017年 DIS. All rights reserved.
//

import UIKit

class XKCDrawerViewController: UIViewController {

    //创建单例
    static let shareDrawerViewController = XKCDrawerViewController()
    
    var leftViewController: XKCLeftViewController?
    var mainViewController: XKCMainViewController?
    var maxWidth: CGFloat?
    var switchViewController: UIViewController?
    var coverView: UIView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setCoverView()
        self.leftViewController?.view.transform = CGAffineTransform.init(translationX: -maxWidth!, y: 0)
        
        let edgePan = UIPanGestureRecognizer.init(target: mainViewController, action: #selector(mainViewController?.edgePanGrstureRacognizer(edgePan:)))
        mainViewController?.view.addGestureRecognizer(edgePan)
    }
    
    //创建抽屉效果所需要的控制器
    func drawerWithViewController(leftViewController:XKCLeftViewController,mainViewController:XKCMainViewController, DrawerMaxWidth:CGFloat) -> XKCDrawerViewController {
        
        let drawerViewController = XKCDrawerViewController.shareDrawerViewController
        drawerViewController.leftViewController = leftViewController
        drawerViewController.mainViewController = mainViewController
        maxWidth  = DrawerMaxWidth
        
        drawerViewController.view.addSubview(leftViewController.view)
        drawerViewController.addChildViewController(leftViewController)
        
        drawerViewController.view.addSubview(mainViewController.view)
        drawerViewController.addChildViewController(mainViewController)
        
        return drawerViewController
    }
    
    //打开抽屉
    func openDrawer(openDrawerWithDuration:CGFloat) {
        UIView.animate(withDuration: TimeInterval.init(openDrawerWithDuration), delay: 0, options: .curveLinear, animations: {
            self.mainViewController?.view.transform = CGAffineTransform.init(translationX: self.maxWidth!, y: 0)
            self.leftViewController?.view.transform = CGAffineTransform.identity
            
        }) { (Bool) in
            self.setCoverView()
            self.mainViewController?.view.addSubview(self.coverView!)
        }
    }
    
    /// 关闭抽屉
    func closeDrawer(closeDrawerWithDuration: CGFloat) {
        UIView.animate(withDuration: TimeInterval(closeDrawerWithDuration), delay: 0, options: .curveLinear, animations: {
            self.leftViewController?.view.transform = CGAffineTransform.init(translationX: -self.maxWidth!, y: 0)
            self.mainViewController?.view.transform = CGAffineTransform.identity
        }) { (Bool) in
            self.coverView?.removeFromSuperview()
            self.coverView = nil
        };
    }
    
    
    //创建当图像显示left视图后，遮盖剩余的mainView的视图
    func setCoverView() {
        guard self.coverView != nil else {
            let coverView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            self.coverView = coverView
            
            addPanAndTapGestureRecognizer(view: coverView)
            return
        }
    }
    
    /// - parameter view: 遮罩视图
    func addPanAndTapGestureRecognizer(view: UIView) {
        let pan = UIPanGestureRecognizer.init(target: mainViewController, action: (#selector(mainViewController?.panGestureRecognizer(pan:))))
        let tapGesture = UITapGestureRecognizer.init(target: mainViewController, action: #selector(mainViewController?.tapGestureRecognizer(tap:)))
        tapGesture.numberOfTapsRequired = 1
        
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(pan)
    }
    
    
    
    //main界面效边缘拖拽打开抽屉手势 回调
    func edgePanGrstureRacognizer(edgePan: UIPanGestureRecognizer) {
        
        let offSetX = edgePan.translation(in: edgePan.view).x
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            if edgePan.state == UIGestureRecognizerState.changed && offSetX < self.maxWidth! {
                self.mainViewController?.view.transform = CGAffineTransform.init(translationX: offSetX, y: 0)
                self.leftViewController?.view.transform = CGAffineTransform.init(translationX: -self.maxWidth! + offSetX, y: 0)
            }else if edgePan.state == .cancelled || edgePan.state == .ended || edgePan.state == .failed{
                if offSetX > UIScreen.main.bounds.width * 0.5{
                    self.openDrawer(openDrawerWithDuration: 0.2)
                }else{
                    self.closeDrawer(closeDrawerWithDuration: 0.2)
                }
            }
        });
    }
    
    /// 拖动手势处理
    func panGestureRecognizer(pan: UIPanGestureRecognizer) {
        let offsetX = pan.translation(in: pan.view).x
        
        if pan.state == .cancelled || pan.state == .failed || pan.state == .ended {
            
            if offsetX < 0 , UIScreen.main.bounds.width - self.maxWidth! + abs(offsetX) > UIScreen.main.bounds.width * 0.5{
                closeDrawer(closeDrawerWithDuration: (self.maxWidth! + offsetX) / self.maxWidth! * 0.2)
            }else{
                openDrawer(openDrawerWithDuration:abs(offsetX) / self.maxWidth! * 0.2)
            }
            
        }else if pan.state == .changed{
            if offsetX < 0 , offsetX > -self.maxWidth! {
                mainViewController?.view.transform = CGAffineTransform.init(translationX: self.maxWidth! + offsetX, y: 0)
                leftViewController?.view.transform = CGAffineTransform.init(translationX: offsetX, y: 0)
            }
        }
        
    }
    
    // 单击手势处理
    func tapGestureRecognizer(tap: UITapGestureRecognizer) {
        closeDrawer(closeDrawerWithDuration: 0.2)
    }
    
    
    //跳转到选择的界面
    func switchViewController(viewController: UIViewController) {
        switchViewController = viewController

        addChildViewController(switchViewController!)
        switchViewController?.view.transform = CGAffineTransform.init(translationX: UIScreen.main.bounds.width, y: 0)
        view.addSubview((switchViewController?.view)!)
        
        UIView.animate(withDuration: 0.2) {
            self.switchViewController?.view.transform = CGAffineTransform.identity
        }
    }
    
    // 返回到左侧控制器
    func switchBackLeftViewController() {
        UIView.animate(withDuration: 0.2, animations: {
            self.switchViewController?.view.transform = CGAffineTransform.init(translationX: UIScreen.main.bounds.width, y: 0)
        }) { (Bool) in
            self.switchViewController?.removeFromParentViewController()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
