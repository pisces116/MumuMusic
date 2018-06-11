//
//  MMMMusicManager.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/11.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

enum MusicDataSourceType: Int {
    case MusicDataLocal = 0
    case MusicDataFavority = 1
    case MusicDataRecommend = 2
}

class MMMMusicManager: NSObject {
    var currentMusic: MMMMusicModel?
    var musicArray: [MMMMusicModel]?
    init(type: MusicDataSourceType) {
        let filePath = Bundle.main.path(forResource: "Music", ofType: nil)
        var fileArry:[String]?
        musicArray = [MMMMusicModel]()
        do{
            try fileArry = FileManager.default.contentsOfDirectory(atPath: filePath!)
        }
        catch{
            print("error")
        }
        for musicName in fileArry! {
            let musicModel = MMMMusicModel(name: musicName)
            musicArray?.append(musicModel)
        }
        if (musicArray?.count)! > 0 {
            currentMusic = musicArray?.first
        }
    }

}
