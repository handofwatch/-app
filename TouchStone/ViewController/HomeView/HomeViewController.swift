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
    
    //下方的显示文字
    @IBOutlet weak var showLayout: UILabel!
    
    //返回方法
    @IBAction func close(Segue:UIStoryboardSegue)
    {
        
    }
    
    //文字的字符串数组
    let showLayoutArray = ["创作","收集","推荐"]
    
    fileprivate var pageSize: CGSize {
        let layout = self.HomeCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSize = layout.itemSize
        return pageSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 3
    }
    
    //滑动加载HomeCollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = HomeCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeIdentifier", for: indexPath) as! HomeCollectionViewCell
        
        cell.backgroundImageView.image = UIImage(named: "文字底图\(indexPath.row + 1)")
        
        return cell
    }
    
    
    //为CollectionViewCell添加点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select \(indexPath)")
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: "GoToPaintBoard", sender: nil)
        case 1:
            self.performSegue(withIdentifier: "GoToCollectionBoard", sender: nil)
        case 2:
            self.performSegue(withIdentifier: "GoToCommendBoard", sender: nil)
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

