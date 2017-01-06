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
    
    var towerCopies = UIImageView()
    
    var waypointLocations = NSMutableArray()
    
    var allTowers = NSMutableArray()
    
    var towerTag: Int = 0
    
    var imageCenter = CGPoint.zero
    @IBOutlet var waypoints: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.gameManager = GameManager()
        makeButton()
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
        
        spawnTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(generateCreep), userInfo: nil, repeats: true)
        moveTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self.gameManager!, selector: Selector(("updateMove")), userInfo: nil, repeats: true)
        
    }

    func generateCreep() // Add creep vào view cùng các chỉ số
    {
        self.gameManager?.addCreeptoViewController(viewcontroller: self, speed: 2, health: 10, imageName: "creep13", wps: waypointLocations)
    }
    
    
    func makeButton()
    {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.setBackgroundImage(UIImage(named: "buildtools"), for: .normal)
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func makeTowerImage()
    {
        let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
        let image = UIImage(named: "tower2")
        tower1 = UIImageView(frame: rect)
        tower1.image = image
        tower1.tag = tag.tower1.rawValue
        towerTag = tower1.tag
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panMove(_:)))
        tower1.addGestureRecognizer(panGesture)
        tower1.isUserInteractionEnabled = true
        self.view.addSubview(tower1)
    }
    
    func actionButton(sender: UIButton)
    {
        sender.isHidden = true
        sender.isUserInteractionEnabled = false
        makeTowerImage()
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
                self.gameManager?.addTowertoViewController(viewcontroller: self, fireSpeed: 0.5, dmg: 5, towerImage: "tower2", x: selectedImage.center.x - 20 , y: selectedImage.center.y - 20)
                selectedImage.center = imageCenter
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
    
    
    
    
    

