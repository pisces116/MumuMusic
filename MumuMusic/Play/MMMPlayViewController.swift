//
//  MMMPlayViewController.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/7.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMPlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.musicManager = MMMMusicManager(type: MusicDataSourceType(rawValue: 0)!)
        setupUI()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Private Func
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.artworkImageView)
        self.view.addSubview(self.nameLabel)
        self.view.addSubview(self.disMissButton)
        self.view.addSubview(self.playButton)
        
        self.disMissButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kTopMargin)
            make.height.width.equalTo(48)
            make.leading.equalToSuperview()
        }
        self.artworkImageView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(kScreenWidth)
        }
        self.nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.artworkImageView.snp.bottom).offset(20)
        }
        self.playButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.nameLabel.snp.bottom).offset(10)
        }
        
        self.artworkImageView.image = self.musicManager?.currentMusic?.image
        self.nameLabel.text = self.musicManager?.currentMusic?.name
    }
    
    //MARK: - Action
    @objc private func playButtonClick(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            MMMMusicPlayer.sharedInstance.play(url: (self.musicManager?.currentMusic?.url)!)
        } else {
            MMMMusicPlayer.sharedInstance.pause()
        }
    }
    
    @objc private func disMissButtonClick(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Properties
    //数据管理
    fileprivate var musicManager: MMMMusicManager?
    //封面
    fileprivate lazy var artworkImageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    //歌曲名
    fileprivate lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.rgbColorFromHex(rgb: 0x333333)
        label.textAlignment = .center
        return label
    }()
    //播放
    fileprivate lazy var playButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Play", for: .normal)
        button.setTitle("Pause", for: .selected)
        button.setTitleColor(UIColor.rgbColorFromHex(rgb: 0x333333), for: .normal)
        button.setTitleColor(UIColor.red, for: .selected)
        button.addTarget(self, action: #selector(playButtonClick(sender:)), for: .touchUpInside)
        return button
    }()
    fileprivate lazy var disMissButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.rgbColorFromHex(rgb: 0x333333), for: .normal)
        button.addTarget(self, action: #selector(disMissButtonClick(sender:)), for: .touchUpInside)
        return button
    }()
    

}
