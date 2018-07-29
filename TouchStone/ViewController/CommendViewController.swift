//
//  CommendViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/22.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class CommendViewController: UIViewController {
    
    @IBOutlet weak var image: UIView!
    
    //场景切换
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? CommendBoardViewController {
            //设置委托（当页面数量、索引改变时当前视图控制器能触发页控件的改变）
            pageViewController.pageDelegate = self as? UIPageViewControllerDelegate
        }
    }
    @objc func onCompleteCapture(image: UIImage, error:NSError?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            //保存成功
            let alertController1 = UIAlertController(title: "", message: "保存成功", preferredStyle: .alert)
            self.present(alertController1,animated: true,completion: nil)
            //显示一秒后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            }else {
            //保存失败
            let alertController2 = UIAlertController(title: "", message: "保存失败", preferredStyle: .alert)
            self.present(alertController2,animated: true,completion: nil)
            //显示一秒后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    //点击下载按钮
    @IBAction func tapDownloadButton(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(self.image.frame.size,false,UIScreen.main.scale)
        
        self.image.layer.render(in:UIGraphicsGetCurrentContext()!)
        
        let image1 = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        //保存完后调用的方法
        let selector = #selector(CommendViewController.onCompleteCapture(image:error:contextInfo:))
        //保存
        UIImageWriteToSavedPhotosAlbum(image1!, self, selector, nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
