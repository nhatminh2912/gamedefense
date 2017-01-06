//
//  Creep.swift
//  GameDefense
//
//  Created by Nhật Minh on 12/26/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit

class Creep: UIImageView{
    // Kích thước và vị trí
    var widthFrame: Int?
    var heightFrame: Int?
    var widthCreep: Int?
    var heightCreep: Int?
    // Các chỉ số
    var speed: CGFloat?
    var health: Int?
    var creepId: Int?
    // Đường đi 
    var currenWaypoint = CGPoint()
    var waypointArray = NSMutableArray()
    
    override init(frame: CGRect)
    {
        self.widthCreep = Int(frame.width)
        self.heightCreep = Int(frame.height)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateCreep(speed: CGFloat, health: Int, imageName: String, wps: NSMutableArray) // tạo creep gốc
    {
        self.waypointArray = NSMutableArray.init(array: wps)
        let point : NSValue = waypointArray.object(at: 0) as! NSValue
        currenWaypoint = point.cgPointValue
        self.speed = speed
        self.health = health
        self.image = UIImage(named: imageName)
//        self.image = UIImage(cgImage: UIImage(named: imageName)!.cgImage!, scale: 1.0, orientation: UIImageOrientation.upMirrored)
        self.frame = CGRect(x: CGFloat((currenWaypoint.x)), y: CGFloat((currenWaypoint.y)), width: CGFloat(self.widthCreep!), height: CGFloat(self.heightCreep!))
        }
    
    func updateMove()
    {
            var newX: CGFloat = self.center.x
            var newY: CGFloat = self.center.y
            
            if self.center.x > (currenWaypoint.x)
            {
                newX -= self.speed!
            }
            if self.center.x < (currenWaypoint.x)
            {
                newX += self.speed!
            }
            if self.center.y > (currenWaypoint.y)
            {
                newY -= self.speed!
            }
            if self.center.y < (currenWaypoint.y)
            {
                newY += self.speed!
            }
            if self.center.x == (currenWaypoint.x) || fabs(self.center.x - (currenWaypoint.x)) <= self.speed!
            {
                newX = (currenWaypoint.x)
            }
            if self.center.y == (currenWaypoint.y) || fabs(self.center.y - (currenWaypoint.y)) <= self.speed!
            {
                newY = (currenWaypoint.y)
            }
        
        
            self.center = CGPoint(x: newX, y: newY)
        
        
            if (self.center.x == currenWaypoint.x && self.center.y == currenWaypoint.y)
            {
                nextWayPoint()
            }
    }
    
    func nextWayPoint()
    {
        if waypointArray.count <= 0 // check nếu đã đi đến waypoint cuối
        {
            self.removeFromSuperview()
            return
        }
        else
        {
            let point: NSValue = waypointArray.object(at: 0) as! NSValue
            currenWaypoint = point.cgPointValue
            waypointArray.removeObject(at: 0)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
