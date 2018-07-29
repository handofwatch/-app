//
//  DecorateViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/29.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class DecorateViewController: UIViewController {
    
    @IBOutlet weak var selectToolBar: UIToolbar!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var viewButton: UIButton!
    
    @IBOutlet weak var banshiButton: UIBarButtonItem!
    
    @IBOutlet weak var zhizhangButton: UIBarButtonItem!
    
    @IBOutlet weak var zhuangshiButton: UIBarButtonItem!
    
    @IBOutlet weak var yinzhangButton: UIBarButtonItem!
    
    @IBOutlet weak var finalView: UIView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var borderImage: UIImageView!
    
    @IBOutlet weak var wordView: UIView!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var poemTextView: UITextView!
    
    @IBOutlet weak var sealImage: UIImageView!
    
    var paintedImage: UIImage!
    
    var order : Int!
    
    var getWord : String!
    
    var ImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        banshiButton.setBackgroundImage(UIImage(named: "2-3_版式"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        banshiButton.tintColor = UIColor.clear
        zhizhangButton.setBackgroundImage(UIImage(named: "2-3_纸张"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        zhizhangButton.tintColor = UIColor.clear
        zhuangshiButton.setBackgroundImage(UIImage(named: "2-3_装饰"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        zhuangshiButton.tintColor = UIColor.clear
        yinzhangButton.setBackgroundImage(UIImage(named: "2-3_印章"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        yinzhangButton.tintColor = UIColor.clear
        
        self.view.bringSubview(toFront: selectToolBar)
        self.view.bringSubview(toFront: viewButton)
        self.view.bringSubview(toFront: backButton)
        
        switch order
        {
        case -1:
            paintedImage = paintedImage.reSizeImage(reSize: CGSize(width: wordView.frame.size.width, height: wordView.frame.size.height))
            ImageView = UIImageView(frame: CGRect(x: wordView.frame.midX, y: wordView.frame.midY, width: wordView.frame.size.width, height: wordView.frame.size.height))
            print(wordView.frame.midX,wordView.frame.midY,wordView.frame.size.width,wordView.frame.size.height)
             ImageView.image = paintedImage
            self.wordView.addSubview(ImageView)
            wordLabel.text = ""
        case 0:
            wordLabel.text = getWord
        //TODO::fontFamily字体改变
        case 1:
            wordLabel.text = getWord
        case 2:
            wordLabel.text = getWord
        case 3:
            wordLabel.text = getWord
        case 4:
            wordLabel.text = getWord
        case 5:
            wordLabel.text = getWord
        case 6:
            wordLabel.text = getWord
        case 7:
            wordLabel.text = getWord
        case 8:
            wordLabel.text = getWord
        case 9:
            wordLabel.text = getWord
        default:
            print("Wrong")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UIGraphicsBeginImageContext(CGSize(width: self.finalView.bounds.size.width,
                                           height: self.finalView.bounds.size.height))
        self.finalView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        print("getImage!")
        
        if segue.identifier == "GoPreview"
        {
            let vc = segue.destination as! PreviewViewController
            vc.getImage = image
        }
    }
    
    @IBAction func close(Segue:UIStoryboardSegue)
    {
    }
}
