//
//  HomeCollectionViewCell.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/18.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    //Cell的View
    @IBOutlet weak var cellView: UIView!
    
    //设置背景图片
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.backgroundColor = UIColor.clear.cgColor
        //添加圆角
        self.layer.cornerRadius = 0
        self.layer.shouldRasterize = true
    }
    
    
}
