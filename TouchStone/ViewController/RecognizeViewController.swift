//
//  RecognizeViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/25.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit

class RecognizeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBAction func close(Segue:UIStoryboardSegue)
    {
        
    }
    
    var wordOnShow : String = ""
    
    @IBOutlet weak var wordCollectionView: UICollectionView!
    
    @IBOutlet weak var ttfCollectionView: UICollectionView!
    
    
    var yourDraw: UIImage!
    
    
//    @IBOutlet weak var yourDrawView: UIImageView!
    
    @IBOutlet weak var textForInstruct: UITextView!
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        yourDrawView.image = yourDraw
        backButton.setBackgroundImage(UIImage(named: "back_white"), for: UIControlState.normal)
        textForInstruct.isUserInteractionEnabled = false
        
        wordCollectionView.register(UINib.init(nibName: "wordCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "wordIdentifier")
        ttfCollectionView.register(UINib.init(nibName: "ttfCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ttfIdentifier")
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: wordCollectionView.frame.size.height, height: wordCollectionView.frame.size.height )
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 1
        flowLayout.sideItemAlpha = 1
        flowLayout.spacingMode = .fixed(spacing: 20.0)
        let flowLayout1 = UPCarouselFlowLayout()
        flowLayout1.itemSize = CGSize(width: ttfCollectionView.frame.size.width / 3, height: ttfCollectionView.frame.size.height)
        flowLayout1.scrollDirection = .horizontal
        flowLayout1.sideItemScale = 1
        flowLayout1.sideItemAlpha = 1
        flowLayout1.spacingMode = .fixed(spacing: 20.0)
        wordCollectionView.collectionViewLayout = flowLayout
        wordCollectionView.delegate = self
        wordCollectionView.dataSource = self
        ttfCollectionView.collectionViewLayout = flowLayout1
        ttfCollectionView.delegate = self
        ttfCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == wordCollectionView
        {
            return 5
        }
        else if collectionView == ttfCollectionView
        {
            return 10
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == wordCollectionView
        {
            let cell = wordCollectionView.dequeueReusableCell(withReuseIdentifier: "wordIdentifier", for: indexPath) as! wordCollectionViewCell
            
            cell.Wordlabel.text = "墨"
            self.view.bringSubview(toFront: cell.Wordlabel)
            cell.Wordlabel.textColor = UIColor(red: 188/255, green: 159/255, blue: 115/255, alpha: 1)
            
            
            return cell
        }
        else if collectionView == ttfCollectionView
        {
            let cell = ttfCollectionView.dequeueReusableCell(withReuseIdentifier: "ttfIdentifier", for: indexPath) as! ttfCollectionViewCell
            
            cell.wordlabel.text = "书"
            self.view.bringSubview(toFront: cell.wordlabel)
            cell.wordlabel.textColor = UIColor(red: 188/255, green: 159/255, blue: 115/255, alpha: 1)
            cell.ttfLabel.text = "字体"
             self.view.bringSubview(toFront: cell.ttfLabel)
            return cell
        }
        else
        {
            let cell:UICollectionViewCell = wordCollectionView.dequeueReusableCell(withReuseIdentifier: "wordIdentifier", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select \(indexPath)")
        if collectionView == wordCollectionView
        {
            let cell = wordCollectionView.dequeueReusableCell(withReuseIdentifier: "wordIdentifier", for: indexPath) as! wordCollectionViewCell
            wordOnShow = cell.Wordlabel.text!
            let cell1 = ttfCollectionView.dequeueReusableCell(withReuseIdentifier: "ttfIdentifier", for: indexPath) as! ttfCollectionViewCell
            cell1.wordlabel.text = wordOnShow
        }
        else if collectionView == ttfCollectionView
        {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
