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
        setupUI()
        if self.playMusic {
           self.playButtonClick(sender: self.playButton)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(manager: MMMMusicManager, playMusic: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.musicManager = manager
        self.playMusic = playMusic
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Func
    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.artworkImageView)
        self.view.addSubview(self.progressBar)
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
        self.progressBar.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.artworkImageView.snp.bottom)
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
    
    @objc private func updateUI() {
        let percent = (MMMMusicPlayer.sharedInstance.musicPlayer?.currentTime)! / (MMMMusicPlayer.sharedInstance.musicPlayer?.duration)!
        self.progressBar.setValue(Float(percent), animated: true)
    }
    
    //MARK: - Action
    @objc private func playButtonClick(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            MMMMusicPlayer.sharedInstance.play(url: (self.musicManager?.currentMusic?.url)!)
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        } else {
            guard let timer = self.timer else {return}
            timer.invalidate()
            self.timer = nil
            MMMMusicPlayer.sharedInstance.pause()
        }
    }
    
    @objc private func progressValueChanged(sender: UISlider) {
        let time = sender.value * Float((MMMMusicPlayer.sharedInstance.musicPlayer?.duration)!)
        MMMMusicPlayer.sharedInstance.musicPlayer?.currentTime = TimeInterval(time)
    }
    
    @objc private func disMissButtonClick(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Properties
    //直接播放
    fileprivate var playMusic: Bool = false
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
    //进度条
    fileprivate lazy var progressBar: UISlider = {
        var slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(self, action: #selector(progressValueChanged(sender:)), for: .valueChanged)
        return slider
    }()
    //定时器
    fileprivate var timer: Timer?
    fileprivate lazy var disMissButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.rgbColorFromHex(rgb: 0x333333), for: .normal)
        button.addTarget(self, action: #selector(disMissButtonClick(sender:)), for: .touchUpInside)
        return button
    }()
    
    

}
