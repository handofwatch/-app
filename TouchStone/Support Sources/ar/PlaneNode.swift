import ARKit
import UIKit
import SceneKit

class PlaneNode: SCNNode {
    var theDraw : UIImage!
    init(anchor: ARPlaneAnchor?, image: UIImage!) {
        super.init()
        // 创建材质并用于平面
        theDraw = image
        let material = SCNMaterial()
        material.diffuse.contents = theDraw
        // 创建平面
        let planeGeometry = SCNPlane(width: CGFloat(anchor?.extent.x ?? 0.0), height: CGFloat(anchor?.extent.z ?? 0.0))
        planeGeometry.materials = [material]
        // 创建节点并作为当前节点的子节点
        let childNode = SCNNode(geometry: planeGeometry)
        childNode.position = SCNVector3Make(anchor?.center.x ?? 0.0, -0.002, anchor?.center.z ?? 0.0)
        childNode.transform = SCNMatrix4MakeRotation(-.pi / 2.0, 1.0, 0.0, 0.0)
        self.addChildNode(childNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with anchor: ARPlaneAnchor?) {
        // 更新平面的范围
        let node = childNodes.first
        let planeGeometry = node?.geometry as? SCNPlane
        planeGeometry?.width = CGFloat(anchor?.extent.x ?? 0.0)
        planeGeometry?.height = CGFloat(anchor?.extent.z ?? 0.0)
        // 更新节点位置
        node?.position = SCNVector3Make(anchor?.center.x ?? 0.0, -0.002, anchor?.center.z ?? 0.0)
    }
    
    func remove(with anchor: ARPlaneAnchor?) {
        // 删除节点
        removeFromParentNode()
    }
}
