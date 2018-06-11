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
    
    var music: MMMMusicModel?
    static let sharedInstance = MMMMusicPlayer()
    private override init() {}
    private var avPlayer: AVAudioPlayer?
    
    
    func play(url: URL) {
        if url == avPlayer?.url {
            avPlayer?.play()
            return
        }
        do {
            avPlayer = try AVAudioPlayer(contentsOf: url)
        } catch {
            print(error)
            return
        }
        avPlayer?.prepareToPlay()
        avPlayer?.play()
    }
    func pause() {
        avPlayer?.pause()
    }
    func stop() {
        avPlayer?.stop()
    }
}
