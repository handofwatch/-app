//
//  RecognizeViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/25.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class RecognizeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    //返回页面调用
    @IBAction func close(Segue:UIStoryboardSegue)
    {
        
    }
    
    
    //为点击yourDrawView添加单击手势
    let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
    
    
    //TODO::机器学习算法得到下列words
    var words = ["墨","笔","书","真","情"]
    
    
    //ttfCollectionViewCell实时更新需要的字符
    var wordsOnShow : String = ""
    
    
    //MARK::字体
    var ttfs = ["颜真卿体","柳公权体","行体","草体","行草","隶书","篆书","碑文","编不出来了"]
    
    
    //字的CollectionView
    @IBOutlet weak var wordCollectionView: UICollectionView!
    
    
    //字体的CollectionView
    @IBOutlet weak var ttfCollectionView: UICollectionView!
    
    
    //PaintBoard传入的image
    var yourDraw: UIImage!
    
    
    //yourDraw的容器
    @IBOutlet weak var yourDrawView : UIImageView!
    
    
    //解释文字
    @IBOutlet weak var textForInstruct: UITextView!
    
    
    //返回上级的按键
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //为yourDrawView添加手势
        yourDrawView.addGestureRecognizer(singleTapGesture)
        
        //初始化显示文字
        wordsOnShow = words[0]
        
        //将yourDraw加入容器
        yourDrawView.image = yourDraw
        
        //把yourDrawView显示在最前
        self.view.bringSubview(toFront: yourDrawView)
        
        //返回按键设置
        backButton.setBackgroundImage(UIImage(named: "back_white"), for: UIControlState.normal)
        
        //设置解释文字为不可交互
        textForInstruct.isUserInteractionEnabled = false
        
        //添加wordCollectionViewCell
        wordCollectionView.register(UINib.init(nibName: "wordCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "wordIdentifier")
        
        //添加ttfCollectionViewCell
        ttfCollectionView.register(UINib.init(nibName: "ttfCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ttfIdentifier")
        
        //设置两种CollectionView的格式
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: wordCollectionView.frame.size.height, height: wordCollectionView.frame.size.height )
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 1
        flowLayout.sideItemAlpha = 1
        flowLayout.spacingMode = .fixed(spacing: 20.0)
        
        let flowLayout1 = UPCarouselFlowLayout()
        flowLayout1.itemSize = CGSize(width: ttfCollectionView.frame.size.width * 0.645, height: ttfCollectionView.frame.size.height)
        flowLayout1.scrollDirection = .horizontal
        flowLayout1.sideItemScale = 1
        flowLayout1.sideItemAlpha = 1
        flowLayout1.spacingMode = .fixed(spacing: 20.0)
        
        //确定两种CollectionView的格式、数据源和代理
        wordCollectionView.collectionViewLayout = flowLayout
        wordCollectionView.delegate = self
        wordCollectionView.dataSource = self
        
        ttfCollectionView.collectionViewLayout = flowLayout1
        ttfCollectionView.delegate = self
        ttfCollectionView.dataSource = self
    }
    
    
    //CollectionView所包含的Cell的数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == wordCollectionView
        {
            return 5
        }
        else if collectionView == ttfCollectionView
        {
            return 9
        }
        else{
            return 0
        }
    }
    
    
    //CollectionView滑动加载
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == wordCollectionView
        {
            let cell = wordCollectionView.dequeueReusableCell(withReuseIdentifier: "wordIdentifier", for: indexPath) as! wordCollectionViewCell
            
            cell.Wordlabel.text = words[indexPath.row]
            self.view.bringSubview(toFront: cell.Wordlabel)
            cell.Wordlabel.textColor = UIColor(red: 188/255, green: 159/255, blue: 115/255, alpha: 1)
            
            
            return cell
        }
        else if collectionView == ttfCollectionView
        {
            let cell = ttfCollectionView.dequeueReusableCell(withReuseIdentifier: "ttfIdentifier", for: indexPath) as! ttfCollectionViewCell
            
            cell.wordlabel.text = wordsOnShow
                self.view.bringSubview(toFront: cell.wordlabel)
                cell.wordlabel.textColor = UIColor(red: 188/255, green: 159/255, blue: 115/255, alpha: 1)
                cell.ttfLabel.text = ttfs[indexPath.row]
                self.view.bringSubview(toFront: cell.ttfLabel)
                return cell
        }
        else
        {
            let cell:UICollectionViewCell = wordCollectionView.dequeueReusableCell(withReuseIdentifier: "wordIdentifier", for: indexPath)
            return cell
        }
    }
    
    
    //CollectionView点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //用于测试
        print("select \(indexPath)")
        if collectionView == wordCollectionView
        {
            let cell = wordCollectionView.dequeueReusableCell(withReuseIdentifier: "wordIdentifier", for: indexPath) as! wordCollectionViewCell
            cell.Wordlabel.text = words[indexPath.row]
            wordsOnShow = words[indexPath.row]
            //刷新ttfCollectionView
            ttfCollectionView.reloadData()
            //TODO::为不同文字添加不同说明
            
        }
        else if collectionView == ttfCollectionView
        {
            //响应ttfCollectionViewCell的点击方法
            
        }
    }
    
    //响应yourDraw的点击方法
    @objc func imageViewClick()
    {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
