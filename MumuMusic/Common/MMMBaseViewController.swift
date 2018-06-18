//
//  MMMBaseViewController.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/8.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMBaseViewController: UIViewController {
    var showNavi: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(UIColor.white), for: .any, barMetrics: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(!showNavi, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
