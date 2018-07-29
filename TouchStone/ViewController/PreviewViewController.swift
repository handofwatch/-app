//
//  PreviewViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/30.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var imageVIew: UIImageView!
    
    var getImage : UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageVIew.image = getImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
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

    
    @IBAction func close(Segue:UIStoryboardSegue)
    {
    }
}
