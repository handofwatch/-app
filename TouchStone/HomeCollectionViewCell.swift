//
//  HomeCollectionViewCell.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/18.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.cellView.layer.cornerRadius = 13.0
            self.cellView.layer.shadowColor = UIColor.gray.cgColor
            self.cellView.layer.shadowOpacity = 0.5
            self.cellView.layer.shadowOpacity = 10.0
            self.cellView.layer.shadowOffset = .zero
            self.cellView.layer.shadowPath = UIBezierPath(rect: self.cellView.bounds).cgPath
            self.cellView.layer.shouldRasterize = true
        }
    }

}
