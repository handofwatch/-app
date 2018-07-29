//
//  PaintBoard.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/23.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import Foundation
import UIKit

open class DrawSignatureView: UIView {
    
    // 公共属性
    open var lineWidth: CGFloat = 5.0 {
        didSet {
            self.path.lineWidth = lineWidth
        }
    }
    open var strokeColor: UIColor = UIColor.black
    open var signatureBackgroundColor: UIColor = UIColor.clear
    
    // 私有属性
    fileprivate var path = UIBezierPath()
    fileprivate var pts = [CGPoint]()
    fileprivate var lines = [[CGPoint]]()
    fileprivate var lineWidArray = [CGFloat]()
    fileprivate var lineColorArray = [CGColor]()
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = signatureBackgroundColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = signatureBackgroundColor
    }
    
    
    override open func draw(_ rect: CGRect)
    {
        self.backgroundColor = signatureBackgroundColor
        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(.round)
        context?.setLineJoin(.round)
        
        if lines.count > 0
        {
            for i in 0..<lines.count
            {
                let tmpArr = lines[i]
                if tmpArr.count > 0
                {
                    context?.beginPath()
                    let sPoint:CGPoint = tmpArr[0]
                    context?.move(to: sPoint)
                    for j in 0..<tmpArr.count
                    {
                        let endPoint:CGPoint = tmpArr[j]
                        context?.addLine(to: endPoint)
                    }
                    context?.setLineWidth(lineWidArray[i])
                    context?.setStrokeColor(lineColorArray[i])
                    context?.strokePath()
                }
            }
        }
        if pts.count > 0 {
            //绘制当前线
            context?.beginPath()
            context?.setLineWidth(self.lineWidth)
            context?.setStrokeColor(self.strokeColor.cgColor)
            context?.move(to: pts[0])
            print(pts[0])
            
            for i in 0..<pts.count {
                context?.addLine(to: pts[i])
                print(pts[i])
            }
            context?.strokePath()
            
        }
        
    }
    
    // 触摸签名相关方法
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point:CGPoint = (event?.allTouches?.first?.location(in: self))!
        //路径起点
        pts.append(point)
        self.setNeedsDisplay()
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point:CGPoint = (event?.allTouches?.first?.location(in: self))!
        //路径
        pts.append(point)
        
        self.setNeedsDisplay()
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lineWidArray.append(self.lineWidth)
        lineColorArray.append(strokeColor.cgColor)
        lines.append(pts)
        pts.removeAll()
        self.setNeedsDisplay()
    }
    
    // 签名视图清空
    open func clearSignature() {
        lineWidArray.removeAll()
        lineColorArray.removeAll()
        pts.removeAll()
        lines.removeAll()
        self.setNeedsDisplay()
    }
    
    //视图撤销
    open func backAStep()
    {
        if lines.count != 0
        {
            lines.removeLast()
            lineColorArray.removeLast()
            lineWidArray.removeLast()
            setNeedsDisplay()
        }
    }
    
    // 将签名保存为UIImage
    open func getSignature() ->UIImage {
        UIGraphicsBeginImageContext(CGSize(width: self.bounds.size.width,
                                           height: self.bounds.size.height))
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let signature: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        print("getSignature!")
        return signature
    }
    
    
}
