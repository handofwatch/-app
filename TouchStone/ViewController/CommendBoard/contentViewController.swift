//
//  contentViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/9/14.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class contentViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var text: UITextView!
    var ARButton: UIButton!
    var downloadButton:UIButton!
    var order = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.adjustsImageSizeForAccessibilityContentSizeCategory = true
        let tap = UITapGestureRecognizer()//创建手势的对象
        
        text.alpha = 0
        text.layer.cornerRadius = 15.0
        text.isEditable = false
        text.isSelectable = false
        self.view.addSubview(text)
        self.view.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
        tap.addTarget(self, action: #selector(tapHandler(sender:)))  //添加手势点击事件
        

        
        text.font = UIFont(name: "FZSuXinShiLiuKaiS-R-GB", size: 24)
        
       self.view.bringSubview(toFront: text)
       
        ARButton = UIButton(frame: CGRect(x: self.view.frame.width * 0.66, y: 680, width: 35, height: 35))
        ARButton.setImage(UIImage(named: "AR"), for: UIControlState.normal)
        downloadButton = UIButton(frame: CGRect(x: self.view.frame.width * 0.33, y: 680, width: 35, height: 35))
        downloadButton.setImage(UIImage(named:"download"), for: UIControlState.normal)
        downloadButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(tapDownloadButton(_:))))
            
        self.view.addSubview(ARButton)
        self.view.bringSubview(toFront: ARButton)
        
        ARButton.addTarget(self, action: #selector(ARButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        self.view.bringSubview(toFront: text)
        // Do any additional setup after loading the view.
        self.view.addSubview(downloadButton)
        self.view.bringSubview(toFront: downloadButton)
    }
    
    @IBAction func close(Segue:UIStoryboardSegue)
    {
        
    }
    
    
    //点击下载按钮
    @objc func tapDownloadButton(_ sender: Any) {
        UIGraphicsBeginImageContextWithOptions(self.image.frame.size,false,UIScreen.main.scale)
        
        self.image.layer.render(in:UIGraphicsGetCurrentContext()!)
        
        let image1 = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        //保存完后调用的方法
        let selector = #selector(contentViewController.onCompleteCapture(image:error:contextInfo:))
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
    
    @objc func tapHandler(sender:UIGestureRecognizer)
    {
        if(order == 0)
        {
            text.alpha = 0.7
            text.frame = CGRect(x: 61, y: 190, width: self.view.bounds.width - 122, height: 376)
            order = 1
        }
        else
        {
            text.alpha = 0
            order = 0
        }
    }
    
    
    @objc func ARButtonTapped(_ sender:UIButton)
    {
        performSegue(withIdentifier: "letAR", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "letAR"
        {
            let vc = segue.destination as! ARViewController
            vc.draw = image.image
        }
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
