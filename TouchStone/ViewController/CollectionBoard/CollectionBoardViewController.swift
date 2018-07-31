//
//  CollectionBoardViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/21.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class CollectionBoardViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    //TODO::功能尚未完善
    //传入的图片
    var getImage:UIImage!
    
    //点击不同cell发出的指令，暂时用不到
    var order:Int!
    
    //发送给preview的图片
    var transImage:UIImage!
    
    //每个cell的状态
    var attribute = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    
    //滚动页面的collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册cell
        collectionView.register(UINib.init(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryIdentifier")
        
        //设置CollectionView格式
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width / 2, height: collectionView.frame.size.height / 3 )
        flowLayout.scrollDirection = .vertical
        flowLayout.sideItemScale = 1
        flowLayout.sideItemAlpha = 1
        flowLayout.spacingMode = .fixed(spacing: 20.0)
        
        //为HomeCollectionView添加格式、数据源和代理
        collectionView.collectionViewLayout = flowLayout
        collectionView.delegate=self
        collectionView.dataSource=self
        
        //传递图片设置
        transImage = getImage
        
        //提供order
        for i in 0..<20
        {
            if attribute[i] == false
            {
                order = i
                break
            }
            if i == 20
            {
                order = -1
            }
            else
            {
                continue
            }
        }
    }
    
    //返回cell数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    //cell滑动响应加载
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryIdentifier", for: indexPath) as! GalleryCollectionViewCell
        
        
        //对每个cell进行判断
        switch indexPath.row
        {
        case 0:
            if order == 0
            {
                cell.image.image = getImage
                attribute[0] = true
                break
            }
        case 1:
            if order == 1
            {
                cell.image.image = getImage
            }
            attribute[1] = true
        case 2:
            if order == 2
            {
                cell.image.image = getImage
            }
            attribute[2] = true
        case 3:
            if order == 3
            {
                cell.image.image = getImage
            }
            attribute[3] = true
        case 4:
            if order == 4
            {
                cell.image.image = getImage
            }
            attribute[4] = true
        case 5:
            if order == 5
            {
                cell.image.image = getImage
            }
            attribute[5] = true
        case 6:
            if order == 6
            {
                cell.image.image = getImage
            }
            attribute[6] = true
        case 7:
            if order == 7
            {
                cell.image.image = getImage
            }
            attribute[7] = true
        case 8:
            if order == 8
            {
                cell.image.image = getImage
            }
            attribute[8] = true
        case 9:
            if order == 9
            {
                cell.image.image = getImage
            }
            attribute[9] = true
        case 10:
            if order == 10
            {
                cell.image.image = getImage
            }
            attribute[10] = true
        case 11:
            if order == 11
            {
                cell.image.image = getImage
            }
            attribute[11] = true
        case 12:
            if order == 12
            {
                cell.image.image = getImage
            }
            attribute[12] = true
        case 13:
            if order == 13
            {
                cell.image.image = getImage
            }
            attribute[13] = true
        case 14:
            if order == 14
            {
                cell.image.image = getImage
            }
            attribute[14] = true
        case 15:
            if order == 15
            {
                cell.image.image = getImage
            }
            attribute[15] = true
        case 16:
            if order == 16
            {
                cell.image.image = getImage
            }
            attribute[16] = true
        case 17:
            if order == 17
            {
                cell.image.image = getImage
            }
            attribute[17] = true
        case 18:
            if order == 18
            {
                cell.image.image = getImage
            }
            attribute[18] = true
        case 19:
            if order == 19
            {
                cell.image.image = getImage
            }
            attribute[19] = true
        default:
            print("Wrong")
        }
        
        return cell
    }
    
    //cell点击效果，跳转至预览页面
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryIdentifier", for: indexPath) as! GalleryCollectionViewCell
        order = indexPath.row
        performSegue(withIdentifier: "showCollection", sender: nil)
    }
    
    
    //为传入预览页面搭桥
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollection"
        {
            let vc = segue.destination as! PreviewViewController
            vc.getImage = transImage
        }
    }
    
    
    //返回方法
    @IBAction func close(Segue:UIStoryboardSegue)
    {
        
    }
}
