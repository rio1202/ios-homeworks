//
//  ViewController.swift
//  Netology_IB_Instruments
//
//  Created by Daniil Ivanov on 18.03.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let customView = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)?.first as? ProfileView {
            customView.avatarImage.image = UIImage(named: "test")
            view.addSubview(customView)
        }
        
        // Do any additional setup after loading the view.
    }


}

