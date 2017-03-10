//
//  SplashScreenViewController.swift
//  TodoNext
//
//  Created by Kalitha H N on 20/02/17.
//  Copyright © 2017 next. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController,CAAnimationDelegate
{
    
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var todo: UIImageView!
    
    var mask : CALayer!
    var animation :CABasicAnimation!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.animateLaunch(image: #imageLiteral(resourceName: "todo"))
        
    }
    
    func animateLaunch(image:UIImage){
        mask = CALayer()
        mask.contents = image.cgImage
        mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        mask.position = CGPoint(x: self.view.frame.width/2.0, y: self.view.frame.height/2.0)
        mainview.layer.mask = mask
        animateDecreaseSize()
        
    }
    
    func animateDecreaseSize(){
        //initially decrese the size of mask
        let decreaseSize = CABasicAnimation(keyPath: "bounds")
        decreaseSize.delegate = self
        decreaseSize.duration = 0.4
        decreaseSize.fromValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: self.view.frame.width/2, height: self.view.frame.height/2))
        
        //ensure that the animation is removed after completion
        decreaseSize.fillMode = kCAFillModeForwards
        decreaseSize.isRemovedOnCompletion = false
        
        //add animations to mask
        mask.add(decreaseSize, forKey: "bounds")
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        //called when animate decrease size is completed
        animateIncreaesize()
    }
    func animateIncreaesize(){
        animation = CABasicAnimation(keyPath: "bounds")
        animation.duration = 1
        animation.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        //ensure that the animation is removed after completion
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        //add animations to mask
        mask.add(animation, forKey: "bounds")
        
        //fade out overlay
//        UIView.animate(withDuration: 0.75, animations: {()->Void in
//            self.todo.alpha = 0
//        })
        //        GIDSignIn.sharedInstance().hasAuthInKeychain(){
        //            if(user == nil){
//        performSegue(withIdentifier: "navigateToMainViewController", sender: nil)
        //            }else{
        //        performSegue(withIdentifier: "navigateToHomePageViewController", sender: nil)
        //            }
        //        }
        
        UIView.animate(withDuration: 1, animations: {()->Void in
            self.todo.alpha = 0
            
        }, completion:{finished in
            if(GIDSignIn.sharedInstance().hasAuthInKeychain() == true){
            self.performSegue(withIdentifier: "navigateToHomeFomSplashScreen", sender: nil)
            }else{
               self.performSegue(withIdentifier: "navigateToMainViewController", sender: nil) 
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

