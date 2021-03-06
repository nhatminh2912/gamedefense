//
//  Tower.swift
//  GameDefense
//
//  Created by Nhật Minh on 12/29/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit

class Tower: UIImageView {
    
    var targetCreep: Creep?
    
    var gameManager: GameManager
    
    var fireSpeed: Double?
    
    var dmg: Int?
    
    var fireTimer = Timer()
    
    var projectile = UIImageView()
    
    var projectileCenter = CGPoint.zero
    
    var towerRange = UIImageView()
    
    var towerImage = UIImageView()
    
    var widthTower: Int?
    
    var heightTower: Int?
    
    override init(frame: CGRect)
    {
        self.widthTower = Int(frame.width)
        self.heightTower = Int(frame.height)
        projectile = UIImageView(image: UIImage(named: "projectile"))
        self.gameManager = GameManager()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeTower(fireSpeed: Double, dmg: Int, towerImage: String, x: CGFloat, y: CGFloat)
    {
        self.image = UIImage(named: towerImage)
        self.frame = CGRect(x: x, y: y, width: CGFloat(widthTower!), height: CGFloat(heightTower!))
        self.fireSpeed = fireSpeed
        self.dmg = dmg
        projectile.frame = CGRect(x: x + 20, y: y + 10, width: 15, height: 15)
        projectileCenter = projectile.center
        
        towerRange = UIImageView(image: UIImage(named: "towerRange"))
        towerRange.frame = CGRect(x: x - 30, y: y - 30, width: 100, height: 100)
        towerRange.alpha = 0.2
        self.superview!.addSubview(towerRange)
    }
    
    func startFiring()
    {
        fireTimer = Timer.scheduledTimer(timeInterval: fireSpeed!, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    
    func fire()
    {
        if targetCreep == nil
        {
            return
        }
        
        projectile.alpha = 1.0
        self.superview?.addSubview(projectile)
        
        
        UIView.animate(withDuration: fireSpeed!, animations: {
            
            self.projectile.center = (self.targetCreep?.center)!
            
        }, completion: { (finished) in
            self.projectile.alpha = 0.0
            self.projectile.center = self.projectileCenter
            self.projectile.removeFromSuperview()
            self.damageCreep()
            
        })
    }
    
    func damageCreep()
    {
        if (targetCreep == nil)
        {
            return
        }
        
        if (targetCreep?.health!)! <= 0
        {
            
            stopFiring()
            
            self.projectile.removeFromSuperview()
            
            self.gameManager.Creeps.remove(targetCreep!)
            
            targetCreep?.removeFromSuperview()
            
            targetCreep = nil
            
            return
        }
        else
        {
            targetCreep?.health! -= dmg!
            
        }
        if targetCreep?.frame.intersects(towerRange.frame) == false
        {
            stopFiring()
            
            targetCreep = nil
        }
    }
    
    func stopFiring()
    {
        fireTimer.invalidate()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
