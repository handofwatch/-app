//
//  PreviewViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/30.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    //装载传入图片的容器
    @IBOutlet weak var imageVIew: UIImageView!
    
    //分享按钮
    @IBOutlet weak var shareButton: UIButton!
    
    //获得的图片
    var getImage : UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //分享按钮设置样式
        shareButton.setBackgroundImage(UIImage(named: "Share"), for: UIControlState.normal)
        
        //将图片装入容器
        imageVIew.image = getImage
    }
    
    //点击分享按钮，进行分享
    @IBAction func shareButtonTapped(_ sender: Any) {
        let myWeb = NSURL(string: "http://www.touchStone.com")
        let shareString = "一起来用触墨创造作品吧！"
        let activity = UIActivity()
        let activityItems = [getImage, shareString, myWeb as Any] as [Any]
        let activities = [activity]
        let activityController = UIActivityViewController(activityItems: activityItems,            applicationActivities: activities)
        activityController.excludedActivityTypes = [UIActivityType.copyToPasteboard,UIActivityType.assignToContact]
        self.present(activityController, animated: true, completion: {()-> Void in})
    }
    
    //点击下载按钮，保存至相册
    @IBAction func downloadButtonTapped(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(self.imageVIew.frame.size,false,UIScreen.main.scale)
        
        self.imageVIew.layer.render(in:UIGraphicsGetCurrentContext()!)
        
        let image1 = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        //保存完后调用的方法
        let selector = #selector(PreviewViewController.onCompleteCapture(image:error:contextInfo:))
        //保存
        UIImageWriteToSavedPhotosAlbum(image1!, self, selector, nil)
    }
    
    //保存之后调用方法，用于提示用户
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
    
    //点击收藏按钮
    @IBAction func collectButtonTapped(_ sender: Any) {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let url = urlForDocument[0] as URL
        print(url)
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let filePath = NSHomeDirectory() + "/Documents/\(timeStamp).jpg"
        let image = getImage
        let data:Data = UIImagePNGRepresentation(image!)!
        try? data.write(to: URL(fileURLWithPath: filePath))
//        performSegue(withIdentifier: "collectPaint", sender: nil)
    }
    
    //返回方法
    @IBAction func close(Segue:UIStoryboardSegue)
    {
    }
}
