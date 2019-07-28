//
//  EffectsView.swift
//  MyWearherApp
//
//  Created by D N on 28/07/2019.
//  Copyright © 2019 Daniel Nejezchleb. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class EffectsView: UIView {
    
    
    func hideAll() -> () {
        let spriteView = self.viewWithTag(110) as! SKView
        spriteView.scene?.childNode(withName: "Rain")?.isHidden = true
        spriteView.scene?.childNode(withName: "Clear")?.isHidden = true
        spriteView.scene?.childNode(withName: "Mist")?.isHidden = true

        let imageView = self.viewWithTag(100) as! UIImageView
        imageView.isHidden = true
    }
    
    func startRain() -> ()  {
        hideAll()
        let spriteView = self.viewWithTag(110) as! SKView
        spriteView.scene?.childNode(withName: "Rain")?.isHidden = false
        let imageView = self.viewWithTag(100) as! UIImageView
        imageView.isHidden = false
    }
    
    func startClear() -> ()  {
        hideAll()
        let spriteView = self.viewWithTag(110) as! SKView
        spriteView.scene?.childNode(withName: "Clear")?.isHidden = false
    }
    
    func StartCloudy()->()
    {
        hideAll()

        let imageView = self.viewWithTag(100) as! UIImageView
        imageView.isHidden = false
    }
    
    func startMist()->()
    {
        hideAll()

        let spriteView = self.viewWithTag(110) as! SKView
        spriteView.scene?.childNode(withName: "Mist")?.isHidden = false
        spriteView.scene?.childNode(withName: "Mist")?.position = CGPoint(x:             spriteView.scene?.childNode(withName: "Mist")?.userData!["startX"] as! Int
, y: 0)
    }
    
    func isDay(day : Bool) ->(){
        let spriteView = self.viewWithTag(110) as! SKView
        if(day)
        {
            spriteView.scene?.childNode(withName: "Night")?.isHidden = true
        }else
        {
            spriteView.scene?.childNode(withName: "Night")?.isHidden = false
        }
    }
   
}
