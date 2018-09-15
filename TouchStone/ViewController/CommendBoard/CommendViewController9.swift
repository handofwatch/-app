//
//  CommendViewController9.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/9/15.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class CommendViewController9: UIViewController {
    
    //场景切换
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? CommendBoardViewController9 {
            //设置委托（当页面数量、索引改变时当前视图控制器能触发页控件的改变）
            pageViewController.pageDelegate = self as? UIPageViewControllerDelegate
        }
    }
    
    @IBAction func close(Segue:UIStoryboardSegue)
    {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
