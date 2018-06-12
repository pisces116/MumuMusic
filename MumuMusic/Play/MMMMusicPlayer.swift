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
    
    static let sharedInstance = MMMMusicPlayer()
    private override init() {}
    
    func play() {
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
        musicPlayer?.prepareToPlay()
        musicPlayer?.play()
    }
    func pause() {
        musicPlayer?.pause()
    }
    func stop() {
        musicPlayer?.stop()
    }
    func next() {
        if (self.musicList?.count)! > 0 {
            index += 1
            index = index % (self.musicList?.count)!
            self.musicModel = self.musicList![index]
            play()
        }
    }
    func pre() {
        if (self.musicList?.count)! > 0 {
            index -= 1
            if index < 0 {
                index = (self.musicList?.count)! - 1
            }
            self.musicModel = self.musicList![index]
            play()
        }
    }
}

extension MMMMusicPlayer {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: kNotificationMusicPlayEnd)))
    }
}
