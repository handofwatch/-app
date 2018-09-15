//
//  ViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/18.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit
import AVKit
class commendSelectorViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var HomeCollectionView: UICollectionView!
    
    //下方的显示文字
    @IBOutlet weak var showLayout: UILabel!
    
    @IBOutlet weak var background: UIImageView!
    //返回方法
    @IBAction func close(Segue:UIStoryboardSegue)
    {
        
    }
    
    //文字的字符串数组
    let showLayoutArray = ["王羲之","颜真卿","欧阳询","张旭","米芾","柳公权","苏轼","赵孟頫","钟繇","文徵明"]
    
    fileprivate var pageSize: CGSize {
        let layout = self.HomeCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSize = layout.itemSize
        return pageSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLayout.text = "王羲之"
        let url = Bundle.main.path(forResource:"bg3", ofType: "gif")!
        let data = NSData(contentsOfFile: url)!
        let src = CGImageSourceCreateWithData(data, nil)!
        var images = [UIImage]()
        let count = CGImageSourceGetCount(src)
        for index in 0..<count {
            let cgImage = CGImageSourceCreateImageAtIndex(src, index, nil)
            images.append(UIImage(cgImage: cgImage!))
            background.image = UIImage.animatedImage(with: images, duration: 8)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        //MARK::是否需要下拉说明框效果
        
        //添加HomeCollectionViewCell
        HomeCollectionView.register(UINib.init(nibName:"HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"HomeIdentifier")
        
        //设置CollectionView格式
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 122, height: HomeCollectionView.frame.size.height )
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 0.6
        flowLayout.sideItemShift = 30
        flowLayout.spacingMode = .fixed(spacing: 20.0)
        
        //为HomeCollectionView添加格式、数据源和代理
        HomeCollectionView.collectionViewLayout = flowLayout
        HomeCollectionView.delegate=self
        HomeCollectionView.dataSource=self
    }
    
    //返回CollectionView的Cell的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    //滑动加载HomeCollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = HomeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeIdentifier", for: indexPath) as! HomeCollectionViewCell
        
        switch indexPath.row{
        case 0:
            cell.backgroundImageView.image = UIImage(named: "commend1.png")
        case 1:
            cell.backgroundImageView.image = UIImage(named: "commend7.png")
        case 2:
            cell.backgroundImageView.image = UIImage(named: "commend13.png")
        case 3:
            cell.backgroundImageView.image = UIImage(named: "commend19.png")
        case 4:
            cell.backgroundImageView.image = UIImage(named: "commend24.png")
        case 5:
            cell.backgroundImageView.image = UIImage(named: "commend30.png")
        case 6:
            cell.backgroundImageView.image = UIImage(named: "commend35.png")
        case 7:
            cell.backgroundImageView.image = UIImage(named: "commend42.png")
        case 8:
            cell.backgroundImageView.image = UIImage(named: "commend46.png")
        case 9:
            cell.backgroundImageView.image = UIImage(named: "commend48.png")
        default:
            cell.backgroundImageView.image = UIImage(named: "commend1.png")
        }
        cell.backgroundImageView.contentMode = .center
        return cell
    }
    
    
    //为CollectionViewCell添加点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select \(indexPath)")
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "go1", sender: nil)
        case 1:
            self.performSegue(withIdentifier: "go2", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "go3", sender: nil)
        case 3:
            self.performSegue(withIdentifier: "go4", sender: nil)
        case 4:
            self.performSegue(withIdentifier: "go5", sender: nil)
        case 5:
            self.performSegue(withIdentifier: "go6", sender: nil)
        case 6:
            self.performSegue(withIdentifier: "go7", sender: nil)
        case 7:
            self.performSegue(withIdentifier: "go8", sender: nil)
        case 8:
            self.performSegue(withIdentifier: "go9", sender: nil)
        case 9:
            self.performSegue(withIdentifier: "go10", sender: nil)
        default:
            print("Wrong!")
        }
    }
    
    
    
    
    //在每次滑动页面改变cell时调用的方法
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageSide = self.pageSize.width
        let offset = scrollView.contentOffset.x
        //改变showLayout内容为屏幕中央的Cell对应内容
        showLayout.text = showLayoutArray[Int(floor((offset - pageSide / 2) / pageSide) + 1)]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

