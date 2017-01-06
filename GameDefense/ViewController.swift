//
//  ViewController.swift
//  GameDefense
//
//  Created by Nhật Minh on 12/22/16.
//  Copyright © 2016 Nhật Minh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    override func viewDidLoad() {
    }
    
    @IBAction func Play(_ sender: UIButton) {
        let v2 = storyBoard.instantiateViewController(withIdentifier: "V2") as! GameViewController
        self.present(v2, animated: true, completion: nil)
    }

}

