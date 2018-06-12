//
//  MMMListViewController.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/9.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

enum MusicListType: Int {
    case MusicListLocal = 0
    case MusicListHistory = 1
    case MusicListArtist = 2
    case MusicListAlbum = 3
}

let reuseIdentifier: String = "MMMHomeListCell"

class MMMListViewController: MMMBaseViewController, UITableViewDataSource, UITableViewDelegate{
    fileprivate var tableView: UITableView!
    fileprivate var musicManager: MMMMusicManager?
    
    init(type: MusicListType) {
        super.init(nibName: nil, bundle: nil)
        switch type {
        case .MusicListHistory:
            self.title = "播放历史"
        case .MusicListLocal:
            self.title = "本地歌曲"
        case .MusicListArtist:
            self.title = "歌手"
        case .MusicListAlbum:
            self.title = "专辑"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.musicManager = MMMMusicManager(type: MusicDataSourceType(rawValue: 0)!)
        self.setupUI()
        
    }
    
    private func setupUI() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        self.tableView.backgroundColor = UIColor.white
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 90
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - DataSource
extension MMMListViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.musicManager?.musicArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: MMMHomeListCell! = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? MMMHomeListCell
        if cell == nil {
            cell = MMMHomeListCell.init(style: .default, reuseIdentifier: reuseIdentifier, type: HomeCellType(rawValue: 0)!)
        }
        cell.updateCell(model: self.musicManager!.musicArray![indexPath.row])
        return cell!
    }
}
//MARK: - Delegate
extension MMMListViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.musicManager?.currentMusic = self.musicManager?.musicArray![indexPath.row]
        let musicPlayVC = MMMPlayViewController.init(playMusic: true)
        MMMMusicPlayer.sharedInstance.musicList = self.musicManager?.musicArray
        MMMMusicPlayer.sharedInstance.index = indexPath.row
        MMMMusicPlayer.sharedInstance.musicModel = self.musicManager?.currentMusic
        self.present(musicPlayVC, animated: true, completion: nil)
    }
    
    
}
