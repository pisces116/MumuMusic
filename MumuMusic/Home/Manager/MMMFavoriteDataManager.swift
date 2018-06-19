//
//  MMMFavoriteDataManager.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/19.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMFavoriteDataManager: NSObject {
    
    fileprivate var musicList: [MMMMusicModel] = [MMMMusicModel]()
    fileprivate var singerDic: [String: [MMMMusicModel]] = [:]
    fileprivate var albumDic: [String: [MMMMusicModel]] = [:]
    fileprivate var MVList: [MMMMusicModel]?
    
    override init() {
        super.init()
        self.musicList = MMMMusicManager.prepareMusicList()
        generateFavoriteData()
    }
    
    
    func favoriteMusicList() -> [MMMMusicModel] {
        return self.musicList
    }
    
    func favoriteSingerList() -> [MMMSingerModel] {
        var singerList = [MMMSingerModel]()
        for (key, value) in self.singerDic {
            let singerModel = MMMSingerModel()
            singerModel.singerName = key
            singerModel.singerMusic = value
            singerModel.singerImage = value.first?.image
            singerList.append(singerModel)
        }
        return singerList
    }
    
    func favoriteAlbumList() -> [MMMAlbumModel] {
        var albumList = [MMMAlbumModel]()
        for (key, value) in self.albumDic {
            let albumModel = MMMAlbumModel()
            albumModel.albumName = key
            albumModel.ablumMusic = value
            albumModel.albumImage = value.first?.image
            albumList.append(albumModel)
        }
        return albumList
    }
    
    func favoriteMVList() -> [MMMMusicModel] {
        return self.MVList!
    }
    
    private func generateFavoriteData() {
        for model in self.musicList {
            //歌手
            if var list = self.singerDic[model.artist!] {
                list.append(model)
                self.singerDic[model.artist!] = list
            } else {
                self.singerDic[model.artist!] = [model]
            }
            //专辑
            if var list = albumDic[model.album!] {
                list.append(model)
                self.albumDic[model.album!] = list
            } else {
                self.albumDic[model.album!] = [model]
            }
        }
    }
}
