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
   
    @IBAction func close(Segue:UIStoryboardSegue)
    {
        
    }
    let showLayoutArray = ["创作","收集","推荐"]
    
    fileprivate var pageSize: CGSize {
        let layout = self.HomeCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSize = layout.itemSize
//        if layout.scrollDirection == .horizontal {
//            pageSize.width += layout.minimumLineSpacing
//        } else {
//            pageSize.height += layout.minimumLineSpacing
//        }
        return pageSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    HomeCollectionView.register(UINib.init(nibName:"HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"HomeIdentifier")
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 122, height: HomeCollectionView.frame.size.height )
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 0.6
        flowLayout.sideItemShift = 30
        flowLayout.spacingMode = .fixed(spacing: 20.0)
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageSide = self.pageSize.width
        let offset = scrollView.contentOffset.x
        showLayout.text = showLayoutArray[Int(floor((offset - pageSide / 2) / pageSide) + 1)]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

