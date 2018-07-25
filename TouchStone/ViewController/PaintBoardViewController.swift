//
//  PaintBoardViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/21.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class PaintBoardViewController: UIViewController {
    
    
    @IBOutlet weak var drawView: DrawSignatureView!
    
    @IBOutlet weak var colorSelector: UIImageView!
    
    @IBOutlet weak var SliderBackground: UIImageView!
    
    @IBOutlet weak var backAStepButton: UIButton!
    
    @IBOutlet weak var controller: UIImageView!
    
    @IBOutlet weak var SliderForThickness: UISlider!
    
    @IBOutlet weak var colorButton: UIButton!
    
    var colorSelectorIsOpen = false
    
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
        
        SliderForThickness.addTarget(self, action:#selector(ThicknessChanged(_:)), for: UIControlEvents.valueChanged)
        
        SliderForThickness.backgroundColor = UIColor.clear
        SliderForThickness.setThumbImage(UIImage(named: "capture"), for: UIControlState.normal)
        
        colorButton.layer.cornerRadius = colorButton.frame.height/2
        
        colorSelector.alpha = 0
        blackButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.080), y: Double(colorSelector.frame.minY * 1.005), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        
        blackButton.backgroundColor = UIColor.clear
        blackButton.addTarget(self, action:#selector(blackButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        
        grayButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.185), y: Double(colorSelector.frame.minY * 1.005), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        
        grayButton.backgroundColor = UIColor.clear
        grayButton.addTarget(self, action:#selector(grayButtonTapped(_:)), for: UIControlEvents.touchUpInside)

        blueButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.29), y: Double(colorSelector.frame.minY * 1.005), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        
        blueButton.backgroundColor = UIColor.clear
        blueButton.addTarget(self, action:#selector(blueButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        greenButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.395), y: Double(colorSelector.frame.minY * 1.005), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        
        greenButton.backgroundColor = UIColor.clear
        greenButton.addTarget(self, action:#selector(greenButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        purpleButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.5), y: Double(colorSelector.frame.minY * 1.005), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        
        purpleButton.backgroundColor = UIColor.clear
        purpleButton.addTarget(self, action:#selector(purpleButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        redButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.605), y: Double(colorSelector.frame.minY * 1.005), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        
        redButton.backgroundColor = UIColor.clear
        redButton.addTarget(self, action:#selector(redButtonTapped(_:)), for: UIControlEvents.touchUpInside)

        yellowButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.711), y: Double(colorSelector.frame.minY * 1.005), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        
        yellowButton.backgroundColor = UIColor.clear
        yellowButton.addTarget(self, action:#selector(yellowButtonTapped(_:)), for: UIControlEvents.touchUpInside)

        brownButton = UIButton(frame: CGRect(x: Double(colorSelector.frame.minX + colorSelector.frame.size.width * 0.817), y: Double(colorSelector.frame.minY * 1.005), width: Double(colorSelector.frame.size.width / 10), height: Double(colorSelector.frame.size.height * 9 / 10)))
        
        brownButton.backgroundColor = UIColor.clear
        brownButton.addTarget(self, action:#selector(brownButtonTapped(_:)), for: UIControlEvents.touchUpInside)

        backAStepButton.setBackgroundImage(UIImage(named: "back_"), for: UIControlState.normal)
        
        self.view.addSubview(blackButton)
        self.view.addSubview(grayButton)
        self.view.addSubview(blueButton)
        self.view.addSubview(greenButton)
        self.view.addSubview(purpleButton)
        self.view.addSubview(redButton)
        self.view.addSubview(yellowButton)
        self.view.addSubview(brownButton)

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
    
    @objc func ThicknessChanged(_ sender:UISlider)
    {
        drawView.lineWidth = CGFloat(SliderForThickness.value)
    }

    @objc func blackButtonTapped(_ sender:UIButton)
    {
        print("blackButtonTapped")
        colorButton.backgroundColor = UIColor(red: 21 / 255, green: 23 / 255, blue: 24 / 255, alpha: 1)
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

    @IBAction func TapColorSelector(_ sender: Any) {
        if colorSelectorIsOpen == false{
            
            
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

            colorSelectorIsOpen = true
            
            
        }
        else
        {
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
        }
        
    }
    
    
    
    //清除签名
    @IBAction func BackAStepButtonTapped(_ sender: Any) {
        
        self.drawView.backAStep()
        
    }
    @IBAction func clearSignature(_ sender: AnyObject) {
        self.drawView.clearSignature()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
