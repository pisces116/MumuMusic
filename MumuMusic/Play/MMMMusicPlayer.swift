//
//  MMMMusicPlayer.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/6.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit
import AVFoundation

enum PlayOrderType: Int {
    case PlayAllRepeat = 0
    case PlayOneRepeat = 1
    case PlayAllRandom = 2
}

class MMMMusicPlayer: NSObject,AVAudioPlayerDelegate {
    
    var musicPlayer: AVAudioPlayer?
    var musicList: [MMMMusicModel]?
    var musicModel: MMMMusicModel?
    var playType: PlayOrderType = PlayOrderType(rawValue: 0)!
    var index: Int = 0
    var playBottomView: MMMBottomPlayView?
    
    fileprivate var displayLink: CADisplayLink?
    
    static let sharedInstance = MMMMusicPlayer()
    private override init() {}
    
    func prepare() {
        self.playBottomView = MMMBottomPlayView()
        self.displayLink = CADisplayLink(target: self, selector: #selector(updateBottomProcess))
        weak var weakSelf = self
        self.playBottomView?.buttonClickClosure = { (play) in
            if let strongSelf = weakSelf {
                if play == true {
                    strongSelf.play()
                } else {
                    strongSelf.pause()
                }
            }

        }
        UIApplication.shared.keyWindow?.addSubview(self.playBottomView!)
        self.playBottomView?.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(55 + (kIsIphoneX ? 35 : 0))
        }
        self.musicList = MMMMusicManager.prepareMusicList()
        if (self.musicList?.count)! > 0 {
            self.musicModel = self.musicList?.first
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: (musicModel?.url)!)
                musicPlayer?.delegate = self
            } catch {
                print(error)
                return
            }
            self.playBottomView?.updatePlayView(model: self.musicModel!)
            musicPlayer?.prepareToPlay()
        }
        DispatchQueue.global().async {
            self.displayLink?.add(to: RunLoop.current, forMode: .defaultRunLoopMode)
            RunLoop.current.run()
        }
    }
    
    func hideBottomView(hide: Bool) {
        self.playBottomView?.isHidden = hide
        if hide == true {
            self.displayLink?.isPaused = true
        } else {
            if (self.musicPlayer?.isPlaying)! {
                self.displayLink?.isPaused = false
            }
        }
    }
    
    func play() {
        if self.playBottomView?.isHidden == false {
           self.displayLink?.isPaused = false
        }
        if musicModel?.url == musicPlayer?.url {
            musicPlayer?.play()
            return
        }
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: (musicModel?.url)!)
            musicPlayer?.delegate = self
        } catch {
            print(error)
            return
        }
        self.playBottomView?.updatePlayView(model: self.musicModel!)
        musicPlayer?.prepareToPlay()
        musicPlayer?.play()
    }
    func prepareToPlay() {
        musicPlayer?.prepareToPlay()
    }
    func pause() {
        musicPlayer?.pause()
        self.displayLink?.isPaused = true
    }
    func stop() {
        musicPlayer?.stop()
        self.displayLink?.isPaused = true
    }
    
    func next() {
        self.playBottomView?.updatePlayView(model: self.musicModel!)
        if (self.musicList?.count)! > 0 {
            index += 1
            index = index % (self.musicList?.count)!
            self.musicModel = self.musicList![index]
            play()
        }
    }
    func pre() {
        self.playBottomView?.updatePlayView(model: self.musicModel!)
        if (self.musicList?.count)! > 0 {
            index -= 1
            if index < 0 {
                index = (self.musicList?.count)! - 1
            }
            self.musicModel = self.musicList![index]
            play()
        }
    }
    @objc private func updateBottomProcess() {
        let percent = Float((musicPlayer?.currentTime)!) / Float((musicPlayer?.duration)!)
        DispatchQueue.main.async {
            self.playBottomView?.updateProcess(percent: CGFloat(percent), isPlaying: (self.musicPlayer?.isPlaying)!)
        }
    }
}

extension MMMMusicPlayer {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        next()
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: kNotificationMusicPlayEnd)))
    }
}
