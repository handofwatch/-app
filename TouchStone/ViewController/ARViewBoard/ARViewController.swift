//
//  ARViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/30.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//
import ARKit
import SceneKit
import UIKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sharebutton: UIButton!
    
    @IBOutlet weak var ARView: ARSCNView!
    
    //TODO::ARKit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sharebutton.setBackgroundImage(UIImage(named: "Share"), for: UIControlState.normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        UIGraphicsBeginImageContext(CGSize(width: self.ARView.bounds.size.width,
                                           height: self.ARView.bounds.size.height))
        self.ARView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let ARImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        print("getARImage!")
        
        let myWeb = NSURL(string: "http://www.touchStone.com")
        let shareString = "一起来用触墨创造作品吧！"
        let activity = UIActivity()
        let activityItems = [ARImage, shareString, myWeb as Any] as [Any]
        let activities = [activity]
        let activityController = UIActivityViewController(activityItems: activityItems,            applicationActivities: activities)
        activityController.excludedActivityTypes = [UIActivityType.copyToPasteboard,UIActivityType.assignToContact]
        self.present(activityController, animated: true, completion: {()-> Void in})
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
