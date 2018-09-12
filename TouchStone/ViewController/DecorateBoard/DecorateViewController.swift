//
//  DecorateViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/29.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class DecorateViewController: UIViewController {
    
    //下方的选择ToolBar
    @IBOutlet weak var selectToolBar: UIToolbar!
    
    //返回按钮
    @IBOutlet weak var backButton: UIButton!
    
    //预览按钮
    @IBOutlet weak var viewButton: UIButton!
    
    //上方的ToolBar
    @IBOutlet weak var upSelectBar: UIToolbar!
    
    //上方ToolBar的Item
    @IBOutlet weak var upBanshiButton: UIBarButtonItem!
    
    @IBOutlet weak var upZhizhangButton: UIBarButtonItem!
    
    @IBOutlet weak var upZhuangshiButton: UIBarButtonItem!
    
    @IBOutlet weak var upYinzhangButton: UIBarButtonItem!
    
    //下方ToolBar的四个按钮
    @IBOutlet weak var banshiButton: UIBarButtonItem!
    
    @IBOutlet weak var zhizhangButton: UIBarButtonItem!
    
    @IBOutlet weak var zhuangshiButton: UIBarButtonItem!
    
    @IBOutlet weak var yinzhangButton: UIBarButtonItem!
    
    //最终合成的总效果
    @IBOutlet weak var finalView: UIView!
    
    //背景纸张
    @IBOutlet weak var backgroundImage: UIImageView!
    
    //边框版式
    @IBOutlet weak var borderImage: UIImageView!
    
    //装载文字或初始图片的View
    @IBOutlet weak var wordView: UIView!
    
    //文字文本
    @IBOutlet weak var wordLabel: UILabel!
    
    //诗的TextView
    @IBOutlet weak var poemTextView: UITextView!
    
    //印章图片
    @IBOutlet weak var sealImage: UIImageView!
    
    //装饰图片
    @IBOutlet weak var decorateView: UIImageView!
    
    //传入的初始图片
    var paintedImage: UIImage!
    
    //传入的指令
    var order : Int!
    
    //获得的文字
    var getWord : String!
    
    //为了将初始图片加入文字框的容器
    var ImageView : UIImageView!
    
    //选择的指令
    var selectOrder : Int!
    
    //选择框是否打开
    var isUpSelectorShowed : Bool!
    
    
    
    //TODO::设置诗句
    func changePoem(word:String)->String
    {
        switch(word)
        {
        case"墨":
            return "丰沛曾为社稷臣，赐书名画墨犹新。"
        case"书":
            return "故书不厌百回读，熟读深思子自知。"
        case"笔":
            return "宣城之人采为笔，千万毛中拣一毫。"
        case"真":
            return "真子今将命，苍生福可传。"
        case"情":
            return "暗淡轻黄体性柔，情疏迹远只香留。"
        default:
            return "一笔书画，一份传承。"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //默认选择框为关闭状态
        isUpSelectorShowed = false
        
        //上方和下方的ToolBar全部是初始选项卡，去除系统色
        upBanshiButton.setBackgroundImage(UIImage(named: "2-3_版式"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        upBanshiButton.tintColor = UIColor.clear
        banshiButton.setBackgroundImage(UIImage(named: "2-3_版式"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        banshiButton.tintColor = UIColor.clear
        //为下方的按钮添加响应
        banshiButton.action = #selector(n1ButtonClicked(sender:))
        
        upZhizhangButton.setBackgroundImage(UIImage(named: "2-3_纸张"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        upZhizhangButton.tintColor = UIColor.clear
        zhizhangButton.setBackgroundImage(UIImage(named: "2-3_纸张"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        zhizhangButton.tintColor = UIColor.clear
        zhizhangButton.action = #selector(n2ButtonClicked(sender:))
        
        upZhuangshiButton.setBackgroundImage(UIImage(named: "2-3_装饰"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        upZhuangshiButton.tintColor = UIColor.clear
        zhuangshiButton.setBackgroundImage(UIImage(named: "2-3_装饰"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        zhuangshiButton.tintColor = UIColor.clear
        zhuangshiButton.action = #selector(n3ButtonClicked(sender:))
        
        upYinzhangButton.setBackgroundImage(UIImage(named: "2-3_印章"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        upYinzhangButton.tintColor = UIColor.clear
        yinzhangButton.setBackgroundImage(UIImage(named: "2-3_印章"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        yinzhangButton.tintColor = UIColor.clear
        yinzhangButton.action = #selector(n4ButtonClicked(sender:))
        
        //诗的内容根据文字改变
        poemTextView.text = changePoem(word: getWord)
        
        //将上方选择条隐藏，下方选择条置于顶部
        self.view.bringSubview(toFront: selectToolBar)
        self.view.bringSubview(toFront: viewButton)
        self.view.bringSubview(toFront: backButton)
        self.view.sendSubview(toBack: upSelectBar)
        
        //对于字体指令的响应
        switch order
        {
        //传入初始图片
        case -1:
            ImageView = UIImageView(frame: CGRect(x: wordView.frame.minX * 0.4, y: wordView.frame.minY * 0.6, width: wordView.frame.size.width, height: wordView.frame.size.height))
            ImageView.image = paintedImage
            self.wordView.addSubview(ImageView)
            wordLabel.text = ""
        //传入文字的不同字体
        case 0:
            wordLabel.text = getWord
            //TODO::fontFamily字体改变
        //wordLabel.font.familyName = ""
        case 1:
            wordLabel.text = getWord
        wordLabel.font = UIFont(name: "经典行书简", size: 150)
        case 2:
            wordLabel.text = getWord
        wordLabel.font = UIFont(name: "HYSunWanMinCaoShu", size: 150)
        case 3:
            wordLabel.text = getWord
        wordLabel.font = UIFont(name: "YuWeiLiShuJT", size: 150)
        case 4:
            wordLabel.text = getWord
        wordLabel.font = UIFont(name: "w", size: 150)
        case 5:
            wordLabel.text = getWord
        wordLabel.font = UIFont(name: "FZSuXinShiLiuKaiS-R-GB", size: 150)
        case 6:
            wordLabel.text = getWord
        wordLabel.font = UIFont(name: "zktzbqxst", size: 150)
        case 7:
            wordLabel.text = getWord
        wordLabel.font = UIFont(name: "FZShengShiKaiShuS-EB-GB", size: 150)
        default:
            print("Wrong")
        }
    }
    
    //为进入预览页面搭桥，传入最终画面的截图
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
    
    //响应下方ToolBar按钮的事件
    //点击第一个按钮
    @objc func n1ButtonClicked(sender: UIBarButtonItem)
    {
        //点击版式按钮
        if isUpSelectorShowed == false
        {
            //设置选择命令为1
            selectOrder = 1
            //显示上方ToolBar
            self.view.bringSubview(toFront: upSelectBar)
            //下方的按钮变为边框的图片
            banshiButton.setBackgroundImage(UIImage(named: "边框1")?.scaleImage(scaleSize: 0.1), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            zhizhangButton.setBackgroundImage(UIImage(named: "边框2")?.scaleImage(scaleSize: 0.1), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            zhuangshiButton.setBackgroundImage(UIImage(named: "边框3")?.scaleImage(scaleSize: 0.1), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            //第四个位置空出
            yinzhangButton.setBackgroundImage(UIImage(named: "3_add"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            //选择框状态为打开
            isUpSelectorShowed = true
        }
            //点击了按钮对应的内容，而不是选择版式
        else
        {
            //根据选择指令判断应该进行如何更改
            switch selectOrder
            {
            //版式改变
            case 1:
                borderImage.image = UIImage(named: "边框1")
            //纸张改变
            case 2:
                backgroundImage.image = UIImage(named: "1-白色宣纸")
            //装饰改变
            case 3:
                decorateView.image = UIImage(named: "装饰-圆")
            //印章改变
            case 4:
                sealImage.image = UIImage(named: "pic1")
            default:
                print("Wrong!")
            }
            //把上方ToolBar收起
            self.view.sendSubview(toBack: upSelectBar)
            //选择栏状态为收起
            isUpSelectorShowed = false
            //下方按钮恢复为初始选择
            banshiButton.setBackgroundImage(UIImage(named: "2-3_版式"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            zhizhangButton.setBackgroundImage(UIImage(named: "2-3_纸张"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            zhuangshiButton.setBackgroundImage(UIImage(named: "2-3_装饰"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            yinzhangButton.setBackgroundImage(UIImage(named: "2-3_印章"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        }
    }
    
    //点击第二个按钮
    @objc func n2ButtonClicked(sender: UIBarButtonItem)
    {
        if isUpSelectorShowed == false
        {
            selectOrder = 2
            self.view.bringSubview(toFront: upSelectBar)
            banshiButton.setBackgroundImage(UIImage(named: "1-白色宣纸")?.scaleImage(scaleSize: 0.1), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            zhizhangButton.setBackgroundImage(UIImage(named: "2-浅黄色")?.scaleImage(scaleSize: 0.1), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            zhuangshiButton.setBackgroundImage(UIImage(named: "5-柳叶纸")?.scaleImage(scaleSize: 0.1), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            yinzhangButton.setBackgroundImage(UIImage(named: "3_add"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            isUpSelectorShowed = true
        }
        else
        {
            switch selectOrder
            {
            case 1:
                borderImage.image = UIImage(named: "边框2")
            case 2:
                backgroundImage.image = UIImage(named: "2-浅黄色")
            case 3:
                decorateView.image = UIImage(named: "装饰-山")
            case 4:
                sealImage.image = UIImage(named: "pic2")
            default:
                print("Wrong!")
            }
            self.view.sendSubview(toBack: upSelectBar)
            isUpSelectorShowed = false
            banshiButton.setBackgroundImage(UIImage(named: "2-3_版式"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            zhizhangButton.setBackgroundImage(UIImage(named: "2-3_纸张"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            zhuangshiButton.setBackgroundImage(UIImage(named: "2-3_装饰"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            yinzhangButton.setBackgroundImage(UIImage(named: "2-3_印章"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        }
    }
    
    //点击第三个按钮
    @objc func n3ButtonClicked(sender: UIBarButtonItem)
    {
        if isUpSelectorShowed == false
        {
            selectOrder = 3
            self.view.bringSubview(toFront: upSelectBar)
            banshiButton.setBackgroundImage(UIImage(named: "装饰-圆")?.scaleImage(scaleSize: 0.3), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            zhizhangButton.setBackgroundImage(UIImage(named: "装饰-山")?.scaleImage(scaleSize: 0.2), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            zhuangshiButton.setBackgroundImage(UIImage(named: "装饰-鲤")?.scaleImage(scaleSize: 0.4), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            yinzhangButton.setBackgroundImage(UIImage(named: "3_add"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            isUpSelectorShowed = true
        }
        else
        {
            switch selectOrder
            {
            case 1:
                borderImage.image = UIImage(named: "边框3")
            case 2:
                backgroundImage.image = UIImage(named: "5-柳叶纸")
            case 3:
                decorateView.image = UIImage(named: "装饰-鲤")
            case 4:
                sealImage.image = UIImage(named: "pic3")
            default:
                print("Wrong!")
            }
            self.view.sendSubview(toBack: upSelectBar)
            isUpSelectorShowed = false
            banshiButton.setBackgroundImage(UIImage(named: "2-3_版式"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            zhizhangButton.setBackgroundImage(UIImage(named: "2-3_纸张"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            zhuangshiButton.setBackgroundImage(UIImage(named: "2-3_装饰"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            
            yinzhangButton.setBackgroundImage(UIImage(named: "2-3_印章"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
        }
    }
    
    //点击第四个按钮
    @objc func n4ButtonClicked(sender: UIBarButtonItem)
    {
        if isUpSelectorShowed == false
        {
            selectOrder = 4
            self.view.bringSubview(toFront: upSelectBar)
            banshiButton.setBackgroundImage(UIImage(named: "pic1")?.scaleImage(scaleSize: 0.7), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            zhizhangButton.setBackgroundImage(UIImage(named: "pic2")?.scaleImage(scaleSize: 0.7), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            zhuangshiButton.setBackgroundImage(UIImage(named: "pic3")?.scaleImage(scaleSize: 0.7), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            yinzhangButton.setBackgroundImage(UIImage(named: "3_add"), for: UIControlState.normal, barMetrics: UIBarMetrics.default)
            isUpSelectorShowed = true
        }
        else
        {
            
        }
    }
    
    //返回方法
    @IBAction func close(Segue:UIStoryboardSegue)
    {
    }
}
