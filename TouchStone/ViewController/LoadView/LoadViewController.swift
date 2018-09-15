//
//  LoadViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/9/12.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//

import UIKit
import AVKit

class LoadViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    var timer : Timer!
    var player: AVPlayer?
    var order : Int!
    private func loadVideo() {
        
        //this line is important to prevent background music stop
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        } catch { }
        
        let path = Bundle.main.path(forResource: "改-触墨-闪屏1080-Wang", ofType:"mov")
        
        player = AVPlayer(url: URL(fileURLWithPath: path!) as URL)
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1
        
        self.view.layer.addSublayer(playerLayer)
        
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        order = 0
        button.alpha = 0
        self.loadVideo()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(showButton), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 7,
                                     target:self,selector:#selector(tickDown),
                                                       userInfo:nil,repeats:true)
    }

    
    @objc func tickDown()
    {
        if(order == 0)
        {
            performSegue(withIdentifier: "goHome", sender: nil)
            order = 1
        }
        else
        {
            
        }
    }
    @objc func showButton()
    {
        button.alpha = 1
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
