//
//  ViewController.swift
//  buddy
//
//  Created by Maggie Guan on 6/19/20.
//  Copyright © 2020 Maggie Guan. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var shadows = UIView()
        shadows.frame = loginButton.frame
        shadows.clipsToBounds = false
        loginButton.addSubview(shadows)


        
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 360)

               let loginButton = CALayer()

               loginButton.shadowPath = shadowPath0.cgPath

               loginButton.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor

               loginButton.shadowOpacity = 1

               loginButton.shadowRadius = 4

               loginButton.shadowOffset = CGSize(width: 4, height: 4)

               loginButton.bounds = shadows.bounds

               loginButton.position = shadows.center

               shadows.layer.addSublayer(loginButton)
        
        
        var shapes = UIView()
        shapes.frame = view.frame
        shapes.clipsToBounds = true
        view.addSubview(shapes)


        loginButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor

        loginButton.bounds = shapes.bounds

        loginButton.position = shapes.center

        shapes.layer.addSublayer(loginButton)


        shapes.layer.cornerRadius = 360



    }


}

