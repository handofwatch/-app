//
//  CollectionBoardViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/21.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

func findFiles(path: String, filterTypes: [String]) -> [String] {
    do {
        let files = try FileManager.default.contentsOfDirectory(atPath: path)
        if filterTypes.count == 0 {
            return files
        }
        else {
            let filteredfiles = NSArray(array: files).pathsMatchingExtensions(filterTypes)
            return filteredfiles
        }
    }
    catch {
        return []
    }
}

class CollectionBoardViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    
    //TODO::功能尚未完善
    //点击不同cell发出的指令，暂时用不到
    var order:Int!
    
    var getImages = ["","","","","","","","","","","","","","","","","","","",""]
    
    var Images : [UIImage] = []
    //发送给preview的图片
    var transImage:UIImage!
    
    //每个cell的状态
    var attribute = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]
    
    //滚动页面的collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getImages = findFiles(path: NSHomeDirectory() + "/Documents", filterTypes: ["jpg"])
        print(getImages)
        
        let number = getImages.count
        for i in 0..<number
        {
            let picData: NSData = FileManager.default.contents(atPath: NSHomeDirectory() + "/Documents/\(getImages[i])")! as NSData
            Images += [UIImage(data: picData as Data)!]
        }
        
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
        
        var ShowImages = Images
        //对每个cell进行判断
        for i in 0..<Images.count
        {
            ShowImages[i] = ShowImages[i].scaleImage(scaleSize: 0.3)
        }
        for _ in Images.count..<20
        {
            ShowImages.append(UIImage(named: "3_add")!.scaleImage(scaleSize: 1))
        }
        cell.image.image = ShowImages[indexPath.row]
        cell.image.contentMode = .center
        return cell
    }
    
    //cell点击效果，跳转至预览页面
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryIdentifier", for: indexPath) as! GalleryCollectionViewCell
        order = indexPath.row
        if order<Images.count
        {
            transImage = Images[order]
            performSegue(withIdentifier: "showCollection", sender: nil)
        }
        else
        {
            performSegue(withIdentifier: "goToCreate", sender: nil)
        }
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
