//
//  BasicsViewController.swift
//  ARKit_Dev
//
//  Created by ait on 2019/07/14.
//  Copyright © 2019 ait. All rights reserved.
//
import UIKit
import ARKit

class BasicsViewController: UIViewController {

  @IBOutlet weak var sceneView: ARSCNView!

  override func viewDidLoad() {
    super.viewDidLoad()
    sceneView.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    let configuration = ARWorldTrackingConfiguration()
    configuration.planeDetection = [.horizontal, .vertical]
    sceneView.session.run(configuration, options: [])
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    sceneView.session.pause()
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let ship = SCNScene(named: "art.scnassets/ship.scn")!
    let shipNode = ship.rootNode.childNodes.first!
    shipNode.scale = SCNVector3(0.1, 0.1, 0.1)

    // スクリーン系座標
    guard let location: CGPoint = touches.first?.location(in: sceneView) else {
      return
    }
    //        guard let location: CGFont = touches.first?.location(in: sceneView) else {
    //            return
    //        }

    //
    let pos: SCNVector3 = SCNVector3(location.x, location.y, 0.996)

    // ワールド座標系
    let finalPosition = sceneView.unprojectPoint(pos)

    shipNode.position = finalPosition
    sceneView.scene.rootNode.addChildNode(shipNode)
  }
}

extension BasicsViewController: ARSCNViewDelegate{
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    print("anchor added")
    if anchor is ARPlaneAnchor{
      print("this is ARPlaneAnchor.")
    }
  }
}
