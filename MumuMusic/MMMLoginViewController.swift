//
//  MMMLoginViewController.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/6.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit
import SnapKit

class MMMLoginViewController: UIViewController {
    fileprivate var playButton : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyan
        cresteSubViews();
        
    }
    func cresteSubViews() {
        self.playButton = UIButton(type: .custom)
        self.playButton.setTitle("Play", for: .normal)
        self.playButton.setTitleColor(UIColor.black, for: .normal)
        self.playButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.playButton.backgroundColor = UIColor.purple
        self.playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        self.view.addSubview(self.playButton!)
        self.playButton.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
            make.width.height.equalTo(50)
        }
    }
    @objc private func play() {
        MMMMusicPlayer.sharedInstance.play(name: "Ailee - 像初雪一样靠近你.mp3")
    }

}
