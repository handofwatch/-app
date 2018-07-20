//
//  ViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/18.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var HomeCollectionView: UICollectionView!
    
    @IBOutlet weak var showLayout: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    HomeCollectionView.register(UINib.init(nibName:"HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"HomeIdentifier")
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 61, height: HomeCollectionView.frame.size.height )
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 1.8
        flowLayout.spacingMode = .fixed(spacing: 5.0)
        HomeCollectionView.collectionViewLayout = flowLayout
        HomeCollectionView.delegate=self
        HomeCollectionView.dataSource=self
    }
    
    //MARK: UICollectionView Delegates and DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = HomeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeIdentifier", for: indexPath) as! HomeCollectionViewCell
        
        cell.backgroundImageView.image = UIImage(named: "文字底图\(indexPath.row + 1)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("!!")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

