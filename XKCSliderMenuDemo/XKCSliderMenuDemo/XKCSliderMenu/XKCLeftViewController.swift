//
//  XKCLeftViewController.swift
//  Delorean
//
//  Created by DIS on 2017/2/2.
//  Copyright © 2017年 DIS. All rights reserved.
//

import UIKit

class XKCLeftViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var headView: UIView{
        let headView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 260))
        headView.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "bg_headView")!)
        
        let headImage = UIImageView.init(image: UIImage.init(named: "my_headImg")!)
        headImage.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        headImage.center = CGPoint.init(x: 150, y: 100)
        headImage.layer.masksToBounds = true
        headImage.layer.cornerRadius = headImage.bounds.width*0.5
        headView.addSubview(headImage)

        return headView
    }
    
    var dataArray:[slidetModel] {
        let modArrs = NSMutableArray()
      
        let menuItem1 = slidetModel()
        menuItem1.imgae = "my_headImg"
        menuItem1.name = "NO1"
        menuItem1.withIdentifier = 1
        modArrs.add(menuItem1)
        
        let menuItem2 = slidetModel()
        menuItem2.imgae = "my_headImg"
        menuItem2.name = "NO2"
        menuItem2.withIdentifier = 2
        modArrs.add(menuItem2)
        
        let menuItem3 = slidetModel()
        menuItem3.imgae = "my_headImg"
        menuItem3.name = "NO3"
        menuItem3.withIdentifier = 3
        modArrs.add(menuItem3)
        
        let menuItem4 = slidetModel()
        menuItem4.imgae = "my_headImg"
        menuItem4.name = "NO4"
        menuItem4.withIdentifier = 4
        modArrs.add(menuItem4)
        
        let menuItem5 = slidetModel()
        menuItem5.imgae = "my_headImg"
        menuItem5.name = "NO5"
        menuItem5.withIdentifier = 5
        modArrs.add(menuItem5)
        
        let menuItem6 = slidetModel()
        menuItem6.imgae = "my_headImg"
        menuItem6.name = "NO6"
        menuItem6.withIdentifier = 6
        modArrs.add(menuItem6)
        
        return modArrs as! [slidetModel]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 200, width: headView.bounds.width, height: UIScreen.main.bounds.height - 200), style: .plain)
        tableView.separatorStyle = .none
        
        view.backgroundColor = UIColor.white
        view.addSubview(headView)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }

    
    //MARK---UITableViewDataSource,UITableViewDelegate
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if !(cell != nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.clear
        }
        cell?.textLabel?.text = dataArray[indexPath.row].name
        
        return cell!
    }
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootViewController = XKCSwitchViewController.initWithTitle(title: dataArray[indexPath.row].name)
        XKCDrawerViewController.shareDrawerViewController.switchViewController(viewController: rootViewController)
    }
}


