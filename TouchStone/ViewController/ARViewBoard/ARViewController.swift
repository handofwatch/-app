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
    @IBOutlet weak var gestureButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var ARView: ARSCNView!
    
    //TODO::ARKit
//    private var _scnView: ARSCNView?
//    private var scnView: ARSCNView? {
//        if nil == _scnView {
//            // 创建AR视图
//            _scnView = ARSCNView(frame: view.bounds)
//        }
//        return _scnView
//    }
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
            _maskView?.alpha = 0.6
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
        sharebutton.setBackgroundImage(UIImage(named: "Share"), for: UIControlState.normal)
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
        ARView?.showsStatistics = true
        // 显示检测到的特征点
        ARView?.debugOptions = ARSCNDebugOptions.showFeaturePoints
        // 添加手势
        addGestureOfSceneView()
        self.view.bringSubview(toFront: backButton)
        self.view.bringSubview(toFront: gestureButton)
        self.view.bringSubview(toFront: sharebutton)
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
    
    // MARK: - TapGesture
    func addGestureOfSceneView() {
        // 添加单击手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ARViewController.addARGeometry(fromGesture:)))
        tapGesture.numberOfTapsRequired = 1
        ARView?.addGestureRecognizer(tapGesture)
    }
    @objc func addARGeometry(fromGesture tapGestureRecognizer: UITapGestureRecognizer?) {
        let point: CGPoint? = tapGestureRecognizer?.location(in: ARView)
        // 命中测试，类型为已存在的平面
        let resultArray = ARView?.hitTest(point ?? CGPoint.zero, types: .existingPlaneUsingExtent)
        if nil != resultArray && (resultArray?.count ?? 0) > 0 {
            // 拿到命中测试结果，取出位置
            let result: ARHitTestResult? = resultArray?.first
            var vector: SCNVector3? = nil
            if let aTransform = result?.worldTransform {
                vector = position(withWorldTransform: aTransform)
            }
            // 获取模型场景
            let scene = SCNScene(named: "scene.scn")
            let node = scene?.rootNode.clone()
            if let aVector = vector {
                node?.position = aVector
            }
            // 添加到根节点中
            if let aNode = node {
                ARView?.scene.rootNode.addChildNode(aNode)
            }
        }
    }
    
    // MARK: - Utils
    func position(withWorldTransform worldTransform: matrix_float4x4) -> SCNVector3 {
        // 从世界坐标系中的一个位姿中提取位置
        return SCNVector3Make(worldTransform.columns.3.x, worldTransform.columns.3.y, worldTransform.columns.3.z)
    }
    
    // MARK: - ARARViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        // 判断场景内添加的锚点是否为平面锚点
        if (anchor is ARPlaneAnchor) {
            // 如果是平面锚点，则自定义节点加入平面图片
            let node = PlaneNode(anchor: anchor as? ARPlaneAnchor)
            DispatchQueue.main.async(execute: {
                self.tipLabel?.text = "检测到平面并已添加到场景中"
            })
            return node
        }
        return nil
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
        // 判断场景内更新的锚点是否为平面锚点
        if (anchor is ARPlaneAnchor) {
            // 如果是平面锚点，则更新节点
            (node as? PlaneNode)?.update(with: anchor as? ARPlaneAnchor)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        // 判断场景内删除的锚点是否为平面锚点
        if (anchor is ARPlaneAnchor) {
            // 如果是平面锚点，则删除节点
            (node as? PlaneNode)?.remove(with: anchor as? ARPlaneAnchor)
        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case ARCamera.TrackingState.notAvailable:
            self.tipLabel?.text = "跟踪不可用"
            self.maskView?.alpha = 0.7
        case ARCamera.TrackingState.limited(ARCamera.TrackingState.Reason.initializing):
            let title = "跟踪受限\n"
            let reason: String = "正在初始化"
            self.tipLabel?.text = title + reason
            self.maskView?.alpha = 0.6
        case ARCamera.TrackingState.limited(ARCamera.TrackingState.Reason.excessiveMotion):
            let title = "跟踪受限\n"
            let reason: String = "设备移动过快，少侠手速惊人"
            self.tipLabel?.text = title + reason
            self.maskView?.alpha = 0.6
        case ARCamera.TrackingState.limited(ARCamera.TrackingState.Reason.insufficientFeatures):
            let title = "跟踪受限\n"
            let reason: String = "提取不到足够的特征点，请先移动设备"
            self.tipLabel?.text = title + reason
            self.maskView?.alpha = 0.6
        case ARCamera.TrackingState.limited(ARCamera.TrackingState.Reason.relocalizing):
            let title = "跟踪受限\n"
            let reason: String = "Relocating..."
            self.tipLabel?.text = title + reason
            self.maskView?.alpha = 0.6
        case ARCamera.TrackingState.normal:
            self.tipLabel?.text = "正常跟踪"
            self.maskView?.alpha = 0.0
        default:
            self.tipLabel?.text = "未知错误"
            self.maskView?.alpha = 0.5
        }
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
        UIGraphicsBeginImageContext(CGSize(width: self.ARView.bounds.size.width,
                                           height: self.ARView.bounds.size.height))
        self.ARView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let ARImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        print("getARImage!")
        
        let myWeb = NSURL(string: "http://www.touchStone.com")
        let shareString = "一起来用触墨创造作品吧！"
        let activity = UIActivity()
        let activityItems = [ARImage, shareString, myWeb as Any] as [Any]
        let activities = [activity]
        let activityController = UIActivityViewController(activityItems: activityItems,            applicationActivities: activities)
        activityController.excludedActivityTypes = [UIActivityType.copyToPasteboard,UIActivityType.assignToContact]
        self.present(activityController, animated: true, completion: {()-> Void in})
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
