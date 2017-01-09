//
//  GameViewController.swift
//  GameDefense
//
//  Created by Nhật Minh on 12/26/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit
enum tag: Int {
    case tower1 = 101
    case tower2
    case tower3
    case tower4
    case tower5
}
class GameViewController: UIViewController, UIGestureRecognizerDelegate {
    var gameManager: GameManager?
    
    var moveTimer = Timer()
    
    var spawnTimer = Timer()
    
    var creeps = 0
    
    var tower1 = UIImageView()
    
    var tower2 = UIImageView()
    
    var tower3 = UIImageView()
    
    var tower4 = UIImageView()
    
    var tower5 = UIImageView()
    
    var towerCopies = UIImageView()
    
    var waypointLocations = NSMutableArray()
    
    var allTowers = NSMutableArray()
    
    var imageCenter = CGPoint.zero
    
    @IBOutlet var waypoints: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.gameManager = GameManager()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        // thêm mảng waypoints chứa các label vào mảng waypointSorted
        let waypointSorted: NSMutableArray = NSMutableArray.init(array: waypoints)
        
        // thêm các vị trí tọa độ của label vào trong mảng waypointLocations
        for wplabel in waypointSorted
        {
            if wplabel is UILabel
            {
                let point: CGPoint = (wplabel as AnyObject).center
                let value: NSValue = NSValue.init(cgPoint: point)
                waypointLocations.add(value)

            }
            
            (wplabel as AnyObject).removeFromSuperview()
        }
        
        spawnTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(spawnCreep), userInfo: nil, repeats: true)
        moveTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self.gameManager!, selector: Selector(("updateMove")), userInfo: nil, repeats: true)
        makeTowerImage()
    }

    func spawnCreep() // Add creep vào view cùng các chỉ số
    {
        self.gameManager?.addCreeptoViewController(viewcontroller: self, speed: 2, health: 10, imageName: "creep13", wps: waypointLocations)
    }
    func makeTowerImage()
    {
        let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
        let image = UIImage(named: "tower2")
        tower2 = UIImageView(frame: rect)
        tower2.image = image
        tower2.tag = tag.tower1.rawValue
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panMove(_:)))
        tower2.addGestureRecognizer(panGesture)
        tower2.isUserInteractionEnabled = true
        self.view.addSubview(tower2)
    }
    
    func panMove(_ panGesture : UIPanGestureRecognizer)
    {
        let tagView = panGesture.view?.tag
        if let selectedImage = self.view.viewWithTag(tagView!) as? UIImageView
        {
            if panGesture.state == .began
            {
                imageCenter = selectedImage.center
                
            }
            else if panGesture.state == .changed
            {
                selectedImage.center = panGesture.location(in: view)
            }
            else
            {
                self.gameManager?.addTowertoViewController(viewcontroller: self, fireSpeed: 0.5, dmg: 5,towerImage: "tower2", x: selectedImage.center.x - 20 , y: selectedImage.center.y - 20)
                selectedImage.center = imageCenter
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
    
    
    
    
    

