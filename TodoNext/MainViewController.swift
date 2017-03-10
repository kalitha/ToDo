//
//  MainViewController.swift
//  TodoNext
//
//  Created by Kalitha H N on 22/02/17.
//  Copyright © 2017 next. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil) {
            print("error occured\(error)")
        } else {
            print("succesfully signed in\(user)")
            performSegue(withIdentifier: "navigateToHomePageViewController", sender: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
