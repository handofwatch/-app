//
//  PaintBoardViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/21.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class PaintBoardViewController: UIViewController {
    
    //用于绘制的画板View
    @IBOutlet weak var drawView: DrawSignatureView!
    
    //颜色选择器
    @IBOutlet weak var colorSelector: UIImageView!
    
    //笔触选择器的背景图
    @IBOutlet weak var SliderBackground: UIImageView!
    
    //撤销按钮
    @IBOutlet weak var backAStepButton: UIButton!
    
    //下方毛笔墨盘的图片
    @IBOutlet weak var controller: UIImageView!
    
    //笔触选择器
    @IBOutlet weak var SliderForThickness: UISlider!
    
    //颜色选择按钮
    @IBOutlet weak var colorButton: UIButton!
    
    //颜色选择器是否已经打开
    var colorSelectorIsOpen = false
    
    //所有颜色按钮
    var blackButton : UIButton! = nil
    var grayButton : UIButton! = nil
    var blueButton : UIButton! = nil
    var greenButton : UIButton! = nil
    var purpleButton : UIButton! = nil
    var redButton : UIButton! = nil
    var yellowButton : UIButton! = nil
    var brownButton : UIButton! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //笔触选择器添加事件
        SliderForThickness.addTarget(self, action:#selector(ThicknessChanged(_:)), for: UIControlEvents.valueChanged)
        
        //笔触选择器设置为透明
        SliderForThickness.backgroundColor = UIColor.clear
        
        //笔触选择器的圆点改变样式
        SliderForThickness.setThumbImage(UIImage(named: "capture"), for: UIControlState.normal)
        
        //颜色选择按钮设置为圆形
        colorButton.layer.cornerRadius = colorButton.frame.height/2
        
        //颜色选择器设置为透明
        colorSelector.alpha = 0
        
        //各种颜色的按钮添加到颜色选择器对应位置并设置为透明
        //各种颜色按钮添加点击事件
        blackButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.095), y: Double(colorSelector.frame.minY * 1.15), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        blackButton.backgroundColor = UIColor.clear
        blackButton.addTarget(self, action:#selector(blackButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        grayButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.215), y: Double(colorSelector.frame.minY * 1.15), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        
        grayButton.backgroundColor = UIColor.clear
        grayButton.addTarget(self, action:#selector(grayButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        blueButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.33), y: Double(colorSelector.frame.minY * 1.15), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        blueButton.backgroundColor = UIColor.clear
        blueButton.addTarget(self, action:#selector(blueButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        greenButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.447), y: Double(colorSelector.frame.minY * 1.15), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        greenButton.backgroundColor = UIColor.clear
        greenButton.addTarget(self, action:#selector(greenButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        purpleButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.564), y: Double(colorSelector.frame.minY * 1.15), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        purpleButton.backgroundColor = UIColor.clear
        purpleButton.addTarget(self, action:#selector(purpleButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        redButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.68), y: Double(colorSelector.frame.minY * 1.15), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        redButton.backgroundColor = UIColor.clear
        redButton.addTarget(self, action:#selector(redButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        yellowButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.8), y: Double(colorSelector.frame.minY * 1.15), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        yellowButton.backgroundColor = UIColor.clear
        yellowButton.addTarget(self, action:#selector(yellowButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        brownButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.914), y: Double(colorSelector.frame.minY * 1.15), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        brownButton.backgroundColor = UIColor.clear
        brownButton.addTarget(self, action:#selector(brownButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        //撤销按钮设置背景图
        backAStepButton.setBackgroundImage(UIImage(named: "back_"), for: UIControlState.normal)
        
        
        //视图中添加所有按钮
        self.view.addSubview(blackButton)
        self.view.addSubview(grayButton)
        self.view.addSubview(blueButton)
        self.view.addSubview(greenButton)
        self.view.addSubview(purpleButton)
        self.view.addSubview(redButton)
        self.view.addSubview(yellowButton)
        self.view.addSubview(brownButton)
        
        //加载视图时将颜色选择器和所有颜色按钮放在视图最下层
        self.view.sendSubview(toBack: colorSelector)
        self.view.sendSubview(toBack: blackButton)
        self.view.sendSubview(toBack: grayButton)
        self.view.sendSubview(toBack: blueButton)
        self.view.sendSubview(toBack: greenButton)
        self.view.sendSubview(toBack: purpleButton)
        self.view.sendSubview(toBack: redButton)
        self.view.sendSubview(toBack: yellowButton)
        self.view.sendSubview(toBack: brownButton)
    }
    
    //响应笔触选择器改变的方法
    @objc func ThicknessChanged(_ sender:UISlider)
    {
        //画板中笔触的粗细相应改变
        drawView.lineWidth = CGFloat(SliderForThickness.value)
    }
    
    //响应各种颜色按钮的方法
    @objc func blackButtonTapped(_ sender:UIButton)
    {
        //用于测试
        print("blackButtonTapped")
        
        //设置颜色选择按钮的颜色为对应颜色
        colorButton.backgroundColor = UIColor(red: 21 / 255, green: 23 / 255, blue: 24 / 255, alpha: 1)
        
        //收起颜色选择器
        colorSelector.alpha = 0
        SliderForThickness.alpha = 1
        SliderBackground.alpha = 1
        self.view.sendSubview(toBack: colorSelector)
        self.view.sendSubview(toBack: blackButton)
        self.view.sendSubview(toBack: grayButton)
        self.view.sendSubview(toBack: blueButton)
        self.view.sendSubview(toBack: greenButton)
        self.view.sendSubview(toBack: purpleButton)
        self.view.sendSubview(toBack: redButton)
        self.view.sendSubview(toBack: yellowButton)
        self.view.sendSubview(toBack: brownButton)
        
        //设置颜色选择器为关闭
        colorSelectorIsOpen = false
        
        //改变画板中笔触颜色
        drawView.strokeColor = colorButton.backgroundColor!
    }
    
    @objc func grayButtonTapped(_ sender:UIButton)
    {
        print("grayButtonTapped")
        colorButton.backgroundColor = UIColor(red: 61 / 255, green: 58 / 255, blue: 78 / 255, alpha: 1)
        colorSelector.alpha = 0
        SliderForThickness.alpha = 1
        SliderBackground.alpha = 1
        self.view.sendSubview(toBack: colorSelector)
        self.view.sendSubview(toBack: blackButton)
        self.view.sendSubview(toBack: grayButton)
        self.view.sendSubview(toBack: blueButton)
        self.view.sendSubview(toBack: greenButton)
        self.view.sendSubview(toBack: purpleButton)
        self.view.sendSubview(toBack: redButton)
        self.view.sendSubview(toBack: yellowButton)
        self.view.sendSubview(toBack: brownButton)
        
        colorSelectorIsOpen = false
        drawView.strokeColor = colorButton.backgroundColor!
    }
    
    @objc func blueButtonTapped(_ sender:UIButton)
    {
        print("blueButtonTapped")
        colorButton.backgroundColor = UIColor(red: 45 / 255, green: 76 / 255, blue: 120 / 255, alpha: 1)
        colorSelector.alpha = 0
        SliderForThickness.alpha = 1
        SliderBackground.alpha = 1
        self.view.sendSubview(toBack: colorSelector)
        self.view.sendSubview(toBack: blackButton)
        self.view.sendSubview(toBack: grayButton)
        self.view.sendSubview(toBack: blueButton)
        self.view.sendSubview(toBack: greenButton)
        self.view.sendSubview(toBack: purpleButton)
        self.view.sendSubview(toBack: redButton)
        self.view.sendSubview(toBack: yellowButton)
        self.view.sendSubview(toBack: brownButton)
        
        colorSelectorIsOpen = false
        drawView.strokeColor = colorButton.backgroundColor!
    }
    
    @objc func greenButtonTapped(_ sender:UIButton)
    {
        print("greenButtonTapped")
        colorButton.backgroundColor = UIColor(red: 135 / 255, green: 169 / 255, blue: 163 / 255, alpha: 1)
        colorSelector.alpha = 0
        SliderForThickness.alpha = 1
        SliderBackground.alpha = 1
        self.view.sendSubview(toBack: colorSelector)
        self.view.sendSubview(toBack: blackButton)
        self.view.sendSubview(toBack: grayButton)
        self.view.sendSubview(toBack: blueButton)
        self.view.sendSubview(toBack: greenButton)
        self.view.sendSubview(toBack: purpleButton)
        self.view.sendSubview(toBack: redButton)
        self.view.sendSubview(toBack: yellowButton)
        self.view.sendSubview(toBack: brownButton)
        
        colorSelectorIsOpen = false
        drawView.strokeColor = colorButton.backgroundColor!
    }
    
    @objc func redButtonTapped(_ sender:UIButton)
    {
        print("redButtonTapped")
        colorButton.backgroundColor = UIColor(red: 226 / 255, green: 85 / 255, blue: 64 / 255, alpha: 1)
        colorSelector.alpha = 0
        SliderForThickness.alpha = 1
        SliderBackground.alpha = 1
        self.view.sendSubview(toBack: colorSelector)
        self.view.sendSubview(toBack: blackButton)
        self.view.sendSubview(toBack: grayButton)
        self.view.sendSubview(toBack: blueButton)
        self.view.sendSubview(toBack: greenButton)
        self.view.sendSubview(toBack: purpleButton)
        self.view.sendSubview(toBack: redButton)
        self.view.sendSubview(toBack: yellowButton)
        self.view.sendSubview(toBack: brownButton)
        
        colorSelectorIsOpen = false
        drawView.strokeColor = colorButton.backgroundColor!
    }
    
    @objc func yellowButtonTapped(_ sender:UIButton)
    {
        print("yellowButtonTapped")
        colorButton.backgroundColor = UIColor(red: 231 / 255, green: 184 / 255, blue: 81 / 255, alpha: 1)
        colorSelector.alpha = 0
        SliderForThickness.alpha = 1
        SliderBackground.alpha = 1
        self.view.sendSubview(toBack: colorSelector)
        self.view.sendSubview(toBack: blackButton)
        self.view.sendSubview(toBack: grayButton)
        self.view.sendSubview(toBack: blueButton)
        self.view.sendSubview(toBack: greenButton)
        self.view.sendSubview(toBack: purpleButton)
        self.view.sendSubview(toBack: redButton)
        self.view.sendSubview(toBack: yellowButton)
        self.view.sendSubview(toBack: brownButton)
        
        colorSelectorIsOpen = false
        drawView.strokeColor = colorButton.backgroundColor!
    }
    
    @objc func brownButtonTapped(_ sender:UIButton)
    {
        print("brownButtonTapped")
        colorButton.backgroundColor = UIColor(red: 175 / 255, green: 149 / 255, blue: 113 / 255, alpha: 1)
        colorSelector.alpha = 0
        SliderForThickness.alpha = 1
        SliderBackground.alpha = 1
        self.view.sendSubview(toBack: colorSelector)
        self.view.sendSubview(toBack: blackButton)
        self.view.sendSubview(toBack: grayButton)
        self.view.sendSubview(toBack: blueButton)
        self.view.sendSubview(toBack: greenButton)
        self.view.sendSubview(toBack: purpleButton)
        self.view.sendSubview(toBack: redButton)
        self.view.sendSubview(toBack: yellowButton)
        self.view.sendSubview(toBack: brownButton)
        
        colorSelectorIsOpen = false
        drawView.strokeColor = colorButton.backgroundColor!
    }
    
    @objc func purpleButtonTapped(_ sender:UIButton)
    {
        print("purpleButtonTapped")
        colorButton.backgroundColor = UIColor(red: 169 / 255, green: 160 / 255, blue: 204 / 255, alpha: 1)
        colorSelector.alpha = 0
        SliderForThickness.alpha = 1
        SliderBackground.alpha = 1
        self.view.sendSubview(toBack: colorSelector)
        self.view.sendSubview(toBack: blackButton)
        self.view.sendSubview(toBack: grayButton)
        self.view.sendSubview(toBack: blueButton)
        self.view.sendSubview(toBack: greenButton)
        self.view.sendSubview(toBack: purpleButton)
        self.view.sendSubview(toBack: redButton)
        self.view.sendSubview(toBack: yellowButton)
        self.view.sendSubview(toBack: brownButton)
        
        colorSelectorIsOpen = false
        drawView.strokeColor = colorButton.backgroundColor!
    }
    
    
    //点击颜色选择按钮的事件
    @IBAction func TapColorSelector(_ sender: Any) {
        //若颜色选择器并未打开
        if colorSelectorIsOpen == false{
            //颜色选择器显示
            colorSelector.alpha = 1
            SliderForThickness.alpha = 0
            SliderBackground.alpha = 0
            self.view.bringSubview(toFront: colorSelector)
            self.view.bringSubview(toFront: blackButton)
            self.view.bringSubview(toFront: grayButton)
            self.view.bringSubview(toFront: blueButton)
            self.view.bringSubview(toFront: greenButton)
            self.view.bringSubview(toFront: purpleButton)
            self.view.bringSubview(toFront: redButton)
            self.view.bringSubview(toFront: yellowButton)
            self.view.bringSubview(toFront: brownButton)
            
            //设置颜色选择器状态为打开
            colorSelectorIsOpen = true
        }
            //若颜色选择器已经打开
        else
        {
            //隐藏颜色选择器
            colorSelector.alpha = 0
            SliderForThickness.alpha = 1
            SliderBackground.alpha = 1
            self.view.sendSubview(toBack: colorSelector)
            self.view.sendSubview(toBack: blackButton)
            self.view.sendSubview(toBack: grayButton)
            self.view.sendSubview(toBack: blueButton)
            self.view.sendSubview(toBack: greenButton)
            self.view.sendSubview(toBack: purpleButton)
            self.view.sendSubview(toBack: redButton)
            self.view.sendSubview(toBack: yellowButton)
            self.view.sendSubview(toBack: brownButton)
            
            //设置颜色选择器为未打开
            colorSelectorIsOpen = false
        }
        
    }
    
    
    
    //撤销按钮方法
    @IBAction func BackAStepButtonTapped(_ sender: Any) {
        self.drawView.backAStep()
    }
    
    //清空按钮方法
    @IBAction func clearSignature(_ sender: AnyObject) {
        self.drawView.clearSignature()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //为recognize面板准备搭桥
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //设置画板的颜色与recognize面板颜色一致
        drawView.signatureBackgroundColor = UIColor(red: 49/255, green: 49/255, blue: 49/255, alpha: 1)
        
        //截图
        let yourDraw = drawView.getSignature()
        
        //将图片作为yourDraw传递给recognizeViewController
        if segue.identifier == "recognize"{
            let vc = segue.destination as! RecognizeViewController
            vc.yourDraw = yourDraw
        }
    }
    
    //返回方法
    @IBAction func close(Segue:UIStoryboardSegue)
    {
        drawView.signatureBackgroundColor = UIColor.clear
    }
}
