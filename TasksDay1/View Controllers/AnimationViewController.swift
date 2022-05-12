//
//  AnimationViewController.swift
//  TasksDay1
//
//  Created by Rehan Shah on 09/05/2022.
//

import UIKit

class AnimationViewController: UIViewController {

    
    let layer =  CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        layer.backgroundColor = UIColor.red.cgColor
        layer.frame = CGRect(x: 100, y: 100, width: 120, height: 120)
        view.layer.addSublayer(layer)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.animation()
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+10) {
            self.animation()
        }
    }
    
    func animation()
    {
        let animate = CABasicAnimation(keyPath: "position")
        animate.fromValue = CGPoint(x: layer.frame.origin.x + (layer.frame.size.width/2),
                                    y: layer.frame.origin.y + (layer.frame.size.height/2))
        animate.toValue = CGPoint(x: 300, y: 400)
        animate.duration = 4
        animate.fillMode = .forwards
        animate.isRemovedOnCompletion = false
        animate.beginTime = CACurrentMediaTime()
        layer.add(animate, forKey: nil)
    }
    
    func animat()
    {
        let animate = CABasicAnimation(keyPath: "position")
        animate.fromValue = CGPoint(x: layer.frame.origin.x + (layer.frame.size.width/2),
                                    y: layer.frame.origin.y + (layer.frame.size.height/2))
        animate.toValue = CGPoint(x: 300, y: 400)
        animate.duration = 4
        animate.fillMode = .forwards
        animate.isRemovedOnCompletion = false
        animate.beginTime = CACurrentMediaTime()
        layer.add(animate, forKey: nil)
    }
}
