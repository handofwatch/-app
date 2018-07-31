//
//  CommendBoardViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/21.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class CommendBoardViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //设置代理
    weak var pageDelegate: UIPageViewControllerDelegate?
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = allViewControllers.index(of:viewController) else {
            return nil
        }
        
        //翻到顶时返回最后一张图片
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return allViewControllers.last
        }
        
        guard allViewControllers.count > previousIndex else {
            return nil
        }
        
        return allViewControllers[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = allViewControllers.index(of: viewController)else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = allViewControllers.count
        
        //翻到底时返回第一张图片
        guard orderedViewControllersCount != nextIndex else {
            return allViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return allViewControllers[nextIndex]
    }
    
    private func getViewController(identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(identifier)")
    }
    
    //所有页面的视图控制器
    //TODO::添加推荐页面时需要改变
    private(set) lazy var allViewControllers: [UIViewController] = {
        return [self.getViewController(identifier: "firstVC"),
                self.getViewController(identifier: "secondVC"),
                self.getViewController(identifier: "thirdVC")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        if let firstViewController = allViewControllers.first {
            setViewControllers([firstViewController], direction: .forward,animated: true,completion: nil)
        }
    }
}


