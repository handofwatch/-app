//
//  ARViewController.swift
//  TouchStone
//
//  Created by 王星洲 on 2018/7/30.
//  Copyright © 2018 cn.edu.tongji.1652977. All rights reserved.
//
import ARKit
import SceneKit
import UIKit

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sharebutton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var ARView: ARSCNView!
    var draw:UIImage!
    
    @IBOutlet weak var captureButton: UIButton!
    
  
    // 会话配置
    private var sessionConfiguration: ARConfiguration?
    // 遮罩视图
    private var _maskView: UIView?
    private var maskView: UIView? {
        if nil == _maskView {
            // 创建遮罩视图
            _maskView = UIView(frame: view.bounds)
            _maskView?.isUserInteractionEnabled = false
            _maskView?.backgroundColor = UIColor.white
            _maskView?.alpha = 0
        }
        return _maskView
    }
    // 提示标签
    private var _tipLabel: UILabel?
    private var tipLabel: UILabel? {
        if nil == _tipLabel {
            // 创建提示信息的Label
            _tipLabel = UILabel()
            _tipLabel?.frame = CGRect(x: 0, y: 30, width: (ARView?.frame.width)!, height: 50)
            _tipLabel?.numberOfLines = 0
            _tipLabel?.textColor = UIColor.black
        }
        return _tipLabel
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //sharebutton.setBackgroundImage(UIImage(named: "Share"), for: UIControlState.normal)
        // Do any additional setup after loading the view.
        if let aView = ARView {
            view.addSubview(aView)
        }
        if let aView = maskView {
            view.addSubview(aView)
        }
        if let aLabel = tipLabel {
            view.addSubview(aLabel)
        }
        // 设置AR视图代理
        ARView?.delegate = self
        // 显示视图的FPS信息
        //ARView?.showsStatistics = true
        
        self.view.bringSubview(toFront: backButton)
        self.view.bringSubview(toFront: sharebutton)
        self.view.bringSubview(toFront: captureButton)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 运行视图中自带的会话
        ARView?.session.run(sessionConfig()!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 暂停会话
        ARView?.session.pause()
    }
   
    @IBAction func captureButtonTapped(_ sender: Any) {
        let scene = SCNScene()
        ARView.scene = scene
        let box = SCNBox(width: 0.4, height: 1, length: 0, chamferRadius: 0)
        let boxMaterial = SCNMaterial()
       boxMaterial.diffuse.contents = draw
//        boxMaterial.diffuse.contents = UIImage(named: "B")
        box.materials = [boxMaterial]
        
        let boxNode = SCNNode(geometry: box)
        boxNode.position = SCNVector3(0, 0, -1.5)
        scene.rootNode.addChildNode(boxNode)
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
//        switch camera.trackingState {
//        case ARCamera.TrackingState.notAvailable:
////            self.tipLabel?.text = "跟踪不可用"
////            self.maskView?.alpha = 0.7
//        case ARCamera.TrackingState.limited(ARCamera.TrackingState.Reason.initializing):
//            let title = "跟踪受限\n"
//            let reason: String = "正在初始化"
////            self.tipLabel?.text = title + reason
////            self.maskView?.alpha = 0.6
//        case ARCamera.TrackingState.limited(ARCamera.TrackingState.Reason.excessiveMotion):
//            let title = "跟踪受限\n"
//            let reason: String = "设备移动过快，少侠手速惊人"
//            self.tipLabel?.text = title + reason
//            self.maskView?.alpha = 0.6
//        case ARCamera.TrackingState.limited(ARCamera.TrackingState.Reason.insufficientFeatures):
//            let title = "跟踪受限\n"
//            let reason: String = "提取不到足够的特征点，请先移动设备"
//            self.tipLabel?.text = title + reason
//            self.maskView?.alpha = 0.6
//        case ARCamera.TrackingState.limited(ARCamera.TrackingState.Reason.relocalizing):
//            let title = "跟踪受限\n"
//            let reason: String = "Relocating..."
//            self.tipLabel?.text = title + reason
//            self.maskView?.alpha = 0.6
//        case ARCamera.TrackingState.normal:
//            self.tipLabel?.text = ""
//            self.maskView?.alpha = 0.0
//        default:
//            self.tipLabel?.text = "未知错误"
//            self.maskView?.alpha = 0.5
//        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // 当会话出错时输出出错信息
        switch (error as NSError).code {
        case ARError.Code.unsupportedConfiguration.rawValue:
            tipLabel?.text = "当前设备不支持"
        case ARError.Code.sensorUnavailable.rawValue:
            tipLabel?.text = "传感器不可用，请检查传感器"
        case ARError.Code.sensorFailed.rawValue:
            tipLabel?.text = "传感器出错，请检查传感器"
        case ARError.Code.cameraUnauthorized.rawValue:
            tipLabel?.text = "相机不可用，请检查相机"
        case ARError.Code.worldTrackingFailed.rawValue:
            tipLabel?.text = "追踪出错，请重置"
        default:
            break
        }
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        tipLabel?.text = "会话中断"
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        tipLabel?.text = "会话中断结束，已重置会话"
        if let aConfig = sessionConfig() {
            ARView?.session.run(aConfig, options: .resetTracking)
        }
    }
    
    // MARK: - lazy
    
    func sessionConfig() -> ARConfiguration? {
        if nil == sessionConfiguration {
            // 创建会话配置
            if ARWorldTrackingConfiguration.isSupported {
                let worldConfig = ARWorldTrackingConfiguration()
                worldConfig.planeDetection = .horizontal
                worldConfig.isLightEstimationEnabled = true
                sessionConfiguration = worldConfig
            } else {
                // 创建可追踪3DOF的会话配置
                let orientationConfig = AROrientationTrackingConfiguration()
                sessionConfiguration = orientationConfig
                tipLabel?.text = "当前设备不支持6DOF追踪"
            }
        }
        return sessionConfiguration
    }

    @IBAction func shareButtonTapped(_ sender: Any) {
        let myWeb = NSURL(string: "http://www.touchStone.com")
        let shareString = "一起来用触墨创造作品吧！"
        let activity = UIActivity()
        let activityItems = [UIImage(named: "FULL")!, shareString, myWeb as Any] as [Any]
        let activities = [activity]
        let activityController = UIActivityViewController(activityItems: activityItems,            applicationActivities: activities)
        activityController.excludedActivityTypes = [UIActivityType.copyToPasteboard,UIActivityType.assignToContact]
        activityController.popoverPresentationController?.sourceView = self.view

        self.present(activityController, animated: true, completion: {()-> Void in})
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
