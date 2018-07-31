//
//  RecognizeViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/25.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class RecognizeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //TODO::机器学习算法得到下列words
    var words = ["墨","笔","书","真","情"]
    
    
    //判断传入下一级的字体的指令
    var order : Int!
    
    
    //原始图片
    var originalImage : UIImage!
    
    
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
    
    
    //TODO::添加说明内容
    func changeInstruction(word:String)->String
    {
        switch(word)
        {
        case"墨":
            return "墨，是形声字，从土黑声，本义为书写用的黑色颜料，《说文》，“墨，书墨也”。墨也是黑色的别称，《广雅》，“墨，黑也”。引申为文墨、贪墨、绳墨等。墨刑为古代五刑之一，即脸上刺字并涂以黑色颜料。另有墨家学派，为诸子百家之一。又有墨姓。"
        case"书":
            return "这是书的说明"
        case"笔":
            return "这是笔的说明"
        case"真":
            return "这是真的说明"
        case"情":
            return "这是情的说明"
        default:
            return "这个字我们没有收录"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        order = 0
        //为点击yourDrawView添加单击手势
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewClick))
        
        //为yourDrawView添加手势
        yourDrawView.addGestureRecognizer(singleTapGesture)
        yourDrawView.isUserInteractionEnabled = true
        
        //初始化显示文字
        wordsOnShow = words[0]
        
        //设置说明文字
        textForInstruct.text = changeInstruction(word: wordsOnShow)
        
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
        
        originalImage = yourDraw
        order = nil
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
        else
        {
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
            //TODO::设置字体为第一个选择框字体
            //cell.Wordlabel.font.familyName = ""
            return cell
        }
        else if collectionView == ttfCollectionView
        {
            let cell = ttfCollectionView.dequeueReusableCell(withReuseIdentifier: "ttfIdentifier", for: indexPath) as! ttfCollectionViewCell
            
            cell.wordlabel.text = wordsOnShow
            self.view.bringSubview(toFront: cell.wordlabel)
            cell.wordlabel.textColor = UIColor(red: 188/255, green: 159/255, blue: 115/255, alpha: 1)
            cell.ttfLabel.text = ttfs[indexPath.row]
            //TODO::添加字体文件并且改变文字的字体
            //            switch indexPath.row
            //            {
            //            case 0:
            //                cell.wordlabel.font.familyName = ""
            //            case 1:
            //                cell.wordlabel.font.familyName = ""
            //            case 2:
            //                cell.wordlabel.font.familyName = ""
            //            case 3:
            //                cell.wordlabel.font.familyName = ""
            //            case 4:
            //                cell.wordlabel.font.familyName = ""
            //            case 5:
            //                cell.wordlabel.font.familyName = ""
            //            case 6:
            //                cell.wordlabel.font.familyName = ""
            //            case 7:
            //                cell.wordlabel.font.familyName = ""
            //            case 8:
            //                cell.wordlabel.font.familyName = ""
            //            default:
            //                cell.wordlabel.font.familyName = ""
            //            }
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
            wordCollectionView.reloadData()
            
            textForInstruct.text = changeInstruction(word: wordsOnShow)
            
        }
        else if collectionView == ttfCollectionView
        {
            order = indexPath.row
            print("OK")
            performSegue(withIdentifier: "GoDecorate", sender: nil)
        }
    }
    
    //响应yourDraw的点击方法
    @objc func imageViewClick()
    {
        order = -1
        print("order change to -1")
        print("OK")
        performSegue(withIdentifier: "GoDecorate", sender: nil)
    }
    
    //为跳转页面搭桥
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoDecorate"
        {
            let vc = segue.destination as! DecorateViewController
            let paintedImage = originalImage
            vc.paintedImage = paintedImage
            vc.order = order
            vc.getWord = wordsOnShow
        }
    }
    
    //点击预览键，默认为以第一种字体跳转
    @IBAction func yulanButtonTapped(_ sender: Any) {
        print("OK")
        performSegue(withIdentifier: "GoDecorate", sender: nil)
    }
    
    //返回页面调用
    @IBAction func close(Segue:UIStoryboardSegue)
    {
        yourDrawView.image = originalImage
    }
}
