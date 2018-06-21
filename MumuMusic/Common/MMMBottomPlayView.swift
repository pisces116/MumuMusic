//
//  MMMBottomPlayView.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/20.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit
//底部播放横条
class MMMBottomPlayView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createSubViews() {
        self.backgroundColor = UIColor.rgbColorFromHex(rgb: 0xf8f8f8)
        self.addSubview(self.listButton)
        self.addSubview(self.iconImageView)
        self.addSubview(self.musicLabel)
        self.addSubview(self.artistLabel)
        self.addSubview(self.loaderView)
        self.addSubview(self.playButton)
        
        self.listButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(3)
            make.height.width.equalTo(40)
            make.top.equalToSuperview().offset(7.5)
        }
        self.iconImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.listButton.snp.trailing).offset(2)
            make.height.width.equalTo(40)
            make.top.equalTo(self.listButton)
        }
        self.musicLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.iconImageView.snp.trailing).offset(12)
            make.trailing.equalTo(self.playButton.snp.leading).offset(-12)
            make.top.equalToSuperview().offset(13)
        }
        self.artistLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.musicLabel)
            make.top.equalTo(self.musicLabel.snp.bottom).offset(4)
        }
        self.playButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalTo(self.iconImageView)
        }
        self.loaderView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalTo(self.iconImageView)
        }
    }
    var buttonClickClosure: ((Bool)->Void)?
    
    func updateProcess(percent: CGFloat, isPlaying: Bool) {
        if isPlaying != self.playButton.isSelected {
            self.playButton.isSelected = isPlaying
        }
        self.loaderView.progress = percent
    }
    
    func updatePlayView(model: MMMMusicModel) {
        self.iconImageView.image = model.image
        self.musicLabel.text = model.name
        self.artistLabel.text = model.artist
    }
    
    fileprivate lazy var listButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "dota2.jpg"), for: .normal)
        return button
    }()
    fileprivate lazy var iconImageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    fileprivate lazy var musicLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        return label
    }()
    fileprivate lazy var artistLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgbColorFromHex(rgb: 0x666666)
        return label
    }()
    fileprivate lazy var playButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Play", for: .normal)
        button.setTitle("Pause", for: .selected)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.red, for: .selected)
        button.addTarget(self, action: #selector(playButtonClick(sender:)), for: .touchUpInside)
        return button
    }()
    fileprivate lazy var loaderView: MMMCircularLoaderView = {
        let loaderView = MMMCircularLoaderView(frame: CGRect.zero, circleRect: CGRect(x: 0, y: 0, width: 40, height: 40))
        loaderView.progress = 0
        return loaderView
    }()
    @objc private func playButtonClick(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if self.buttonClickClosure != nil {
            self.buttonClickClosure!(sender.isSelected)
        }
    }
}
