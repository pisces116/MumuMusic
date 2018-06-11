//
//  MMMMusicPlayer.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/6.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit
import AVFoundation

class MMMMusicPlayer: NSObject {
    
    var musicPlayer: AVAudioPlayer?
    static let sharedInstance = MMMMusicPlayer()
    private override init() {}
    
    func play(url: URL) {
        if url == musicPlayer?.url {
            musicPlayer?.play()
            return
        }
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: url)
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
}
