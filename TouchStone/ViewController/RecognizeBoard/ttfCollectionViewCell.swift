//
//  ttfCollectionViewCell.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/25.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class ttfCollectionViewCell: UICollectionViewCell {
    
    //背景框
    @IBOutlet weak var background: UIImageView!
    //中央显示的文字
    @IBOutlet weak var wordlabel: UILabel!
    //下端字体文字
    @IBOutlet weak var ttfLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
