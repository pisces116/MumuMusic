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
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: kNotificationMusicPlayEnd), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MMMMusicPlayer.sharedInstance.hideBottomView(hide: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        MMMMusicPlayer.sharedInstance.hideBottomView(hide: false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(playMusic: Bool) {
        super.init(nibName: nil, bundle: nil)
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
        self.view.addSubview(self.preButton)
        self.view.addSubview(self.playButton)
        self.view.addSubview(self.nextButton)
        self.timeView.addSubview(self.timeLabel)
        
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
        self.preButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.playButton.snp.leading).offset(-10)
            make.centerY.equalTo(self.playButton)
        }
        self.playButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.nameLabel.snp.bottom).offset(10)
        }
        self.nextButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self.playButton.snp.trailing).offset(10)
            make.centerY.equalTo(self.playButton)
        }
        self.artworkImageView.image = MMMMusicPlayer.sharedInstance.musicModel?.image
        self.nameLabel.text = MMMMusicPlayer.sharedInstance.musicModel?.name
        updateProgress()
    }
    
    private func processBarImage() -> UIImage? {
        let currentTime = timeString(timeInterval: (MMMMusicPlayer.sharedInstance.musicPlayer?.currentTime)!)
        let duration = timeString(timeInterval: (MMMMusicPlayer.sharedInstance.musicPlayer?.duration)!)
        let timeProcess: String = currentTime! + "/" + duration!
        self.timeLabel.text = timeProcess
        let processImage = UIImage.image(view:self.timeView, size:self.timeView.bounds.size)
        return processImage
    }
    
    private func timeString(timeInterval: TimeInterval) -> String? {
        let minute = String(format: "%d", Int(round(timeInterval)) / 60)
        let second = String(format: "%02d", Int(round(timeInterval)) % 60)
        return "\(minute):\(second)"
    }
    
    @objc private func updateProgress() {
        let percent = (MMMMusicPlayer.sharedInstance.musicPlayer?.currentTime)! / (MMMMusicPlayer.sharedInstance.musicPlayer?.duration)! 
        self.progressBar.setValue(Float(percent), animated: true)
        if let image = self.processBarImage() {
            self.progressBar.setThumbImage(image, for: .normal)
        }
    }
    @objc private func updateUI() {
        self.artworkImageView.image = MMMMusicPlayer.sharedInstance.musicModel?.image
        self.nameLabel.text = MMMMusicPlayer.sharedInstance.musicModel?.name
        self.playButton.isSelected = (MMMMusicPlayer.sharedInstance.musicPlayer?.isPlaying)!
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        }
    }
    
    //MARK: - Action
    @objc private func playButtonClick(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            MMMMusicPlayer.sharedInstance.play()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        } else {
            guard let timer = self.timer else {return}
            timer.invalidate()
            self.timer = nil
            MMMMusicPlayer.sharedInstance.pause()
        }
    }
    @objc private func nextButtonClick(sender: UIButton) {
        MMMMusicPlayer.sharedInstance.next()
        updateUI()
    }
    @objc private func preButtonClick(sender: UIButton) {
        MMMMusicPlayer.sharedInstance.pre()
        updateUI()
    }
    
    @objc private func progressValueChanged(sender: UISlider) {
        let time = sender.value * Float((MMMMusicPlayer.sharedInstance.musicPlayer?.duration)!)
        MMMMusicPlayer.sharedInstance.musicPlayer?.currentTime = TimeInterval(time)
        updateProgress()
    }
    
    @objc private func disMissButtonClick(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Properties
    //直接播放
    fileprivate var playMusic: Bool = false
    //封面
    fileprivate lazy var artworkImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
    //下一首
    fileprivate lazy var nextButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor.rgbColorFromHex(rgb: 0x333333), for: .normal)
        button.addTarget(self, action: #selector(nextButtonClick(sender:)), for: .touchUpInside)
        return button
    }()
    //上一首
    fileprivate lazy var preButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Pre", for: .normal)
        button.setTitleColor(UIColor.rgbColorFromHex(rgb: 0x333333), for: .normal)
        button.addTarget(self, action: #selector(preButtonClick(sender:)), for: .touchUpInside)
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
    fileprivate lazy var timeView: UIView = {
        var view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 14))
        view.layer.cornerRadius = 7
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = UIColor.white
        return view
    }()
    fileprivate lazy var timeLabel: UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 14))
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
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
