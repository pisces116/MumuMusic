//
//  MMMMusicModel.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/11.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit
import AVFoundation

class MMMMusicModel: NSObject {
    var name: String?
    var url: URL?
    var image: UIImage?
    var artist: String?
    var album: String?
    var genre: String?
    var isActive: Bool = false
    
    init(name: String) {
        let filePath = Bundle.main.path(forResource: "Music", ofType: nil)
        let musicPath = filePath! + "/" + name
        url = URL.init(fileURLWithPath: musicPath)
        let musicAsset = AVURLAsset(url: url!)
        for metaFormat in musicAsset.availableMetadataFormats {
            for musicMetaData in musicAsset.metadata(forFormat: metaFormat) {
//                print("key = \(String(describing: musicMetaData.commonKey?.rawValue)) value = \(String(describing: musicMetaData.value))")
                //歌曲名
                if musicMetaData.commonKey?.rawValue == "title" {
                    self.name = musicMetaData.value as? String
                }
                //封面图片
                if musicMetaData.commonKey?.rawValue == "artwork" {
                    self.image = UIImage.init(data: (musicMetaData.value as? Data)!)
                }
                //专辑名
                if musicMetaData.commonKey?.rawValue == "albumName" {
                    self.album = musicMetaData.value as? String
                }
                //歌手
                if musicMetaData.commonKey?.rawValue == "artist" {
                    self.artist = musicMetaData.value as? String
                }
                //流派
                if musicMetaData.commonKey?.rawValue == "genre" {
                    self.genre = musicMetaData.value as? String
                }
            }
        }
    }
}
