//
//  GameManager.swift
//  GameDefense
//
//  Created by Nhật Minh on 12/26/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit

class GameManager: NSObject{
    
    var Creeps = NSMutableArray()
    
    var allTowers = NSMutableArray()
    
    func addCreeptoViewController(viewcontroller: GameViewController, speed: CGFloat, health: Int, imageName: String, wps: NSMutableArray) // tạo creep để add vào view
    {
        let creep = Creep(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        creep.generateCreep(speed: speed, health: health, imageName: imageName, wps: wps)
        
        self.Creeps.add(creep)
        
        viewcontroller.view.addSubview(creep)
    }
    
    func addTowertoViewController(viewcontroller: GameViewController, fireSpeed: Double, dmg: Int, towerImage: String, x: CGFloat, y: CGFloat)
    {
        let tower = Tower(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        viewcontroller.view.addSubview(tower)
        
        tower.gameManager = self
        
        tower.makeTower(fireSpeed: fireSpeed, dmg: dmg, towerImage: towerImage, x: x, y: y)
        
        self.allTowers.add(tower)
        
        
        
    }
    
    func updateMove()
    {
        for creep in self.Creeps
        {
            (creep as AnyObject).updateMove()
            
            for tower in allTowers
            {
                
                if let currentTower = tower as? Tower
                {
                    if currentTower.frame.intersects((creep as! Creep).frame)
                    {
                        currentTower.removeFromSuperview()
                        currentTower.towerRange.removeFromSuperview()
                        allTowers.remove(currentTower)
                        return
                    }
                
                   if currentTower.towerRange.frame.intersects((creep as! Creep).frame)
                   {
                        if currentTower.targetCreep == nil
                        {
                            currentTower.targetCreep = (creep as! Creep)
                            currentTower.startFiring()
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    
}
