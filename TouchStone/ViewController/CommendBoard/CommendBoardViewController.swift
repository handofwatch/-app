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
        return [self.getViewController(identifier: "1"),
                self.getViewController(identifier: "2"),
                self.getViewController(identifier: "3"),
                self.getViewController(identifier: "4"),
                self.getViewController(identifier: "5"),
                self.getViewController(identifier: "6"),
                self.getViewController(identifier: "7"),
                self.getViewController(identifier: "8"),
                self.getViewController(identifier: "9"),self.getViewController(identifier: "10"),
                self.getViewController(identifier: "11"),self.getViewController(identifier: "12"),
                self.getViewController(identifier: "13"),self.getViewController(identifier: "14"),
                self.getViewController(identifier: "15"),self.getViewController(identifier: "17"),self.getViewController(identifier: "16"),self.getViewController(identifier: "18"),self.getViewController(identifier: "19"),self.getViewController(identifier: "20"),
                self.getViewController(identifier: "21"),self.getViewController(identifier: "22"),
                self.getViewController(identifier: "23"),self.getViewController(identifier: "24"),
                self.getViewController(identifier: "25"),self.getViewController(identifier: "26"),
                self.getViewController(identifier: "28"),self.getViewController(identifier: "27"),
                self.getViewController(identifier: "29"),self.getViewController(identifier: "30"),
                self.getViewController(identifier: "32"),self.getViewController(identifier: "31"),
                self.getViewController(identifier: "33"),self.getViewController(identifier: "34"),
                self.getViewController(identifier: "35"),self.getViewController(identifier: "36"),
                self.getViewController(identifier: "37"),self.getViewController(identifier: "38"),
                self.getViewController(identifier: "39"),self.getViewController(identifier: "40"),
                self.getViewController(identifier: "41"),self.getViewController(identifier: "42"),
                self.getViewController(identifier: "43"),self.getViewController(identifier: "44"),self.getViewController(identifier: "45"),self.getViewController(identifier: "46"),
                self.getViewController(identifier: "47"),self.getViewController(identifier: "48"),
                self.getViewController(identifier: "50"),self.getViewController(identifier: "49"),
                self.getViewController(identifier: "51")]
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


