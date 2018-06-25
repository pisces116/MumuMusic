//
//  MMMFavorityViewController.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/12.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMFavorityViewController: MMMBaseViewController,UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "喜欢&收藏"
        self.dataSocrceDic = [String: [Any]]()
        createSubViews()
        loadFavoriteDataSource()
    }
    
    //MARK: - Private Func
    private func loadFavoriteDataSource() {
        DispatchQueue.global().async {
            self.dataManager = MMMFavoriteDataManager()
            self.dataSocrceDic["单曲"] = self.dataManager?.favoriteMusicList()
            self.dataSocrceDic["艺人"] = self.dataManager?.favoriteSingerList()
            self.dataSocrceDic["专辑"] = self.dataManager?.favoriteAlbumList()
            self.dataSocrceDic["MV"] = self.dataManager?.favoriteMusicList()
            self.dataSocrceDic["流派"] = self.dataManager?.favoriteMusicList()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func createSubViews() {
        self.itemScrollView = MMMItemScrollView(frame: CGRect.zero, titles: ["单曲", "艺人", "专辑", "MV", "流派"])
        self.itemScrollView?.setSelectTitle(index: 0)
        weak var weakSelf = self
        self.itemScrollView?.titleClickClosure = {
            if let strongSelf = weakSelf {
                strongSelf.tableView.reloadData()
            }
        }
        self.tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        self.tableView.backgroundColor = UIColor.white
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 90
        self.view.addSubview(self.itemScrollView!)
        self.view.addSubview(self.tableView)
        self.itemScrollView?.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo((self.itemScrollView?.snp.bottom)!)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Private Properties
    fileprivate var itemScrollView: MMMItemScrollView?
    fileprivate var tableView: UITableView!
    fileprivate var dataSocrceDic: [String: [Any]]!
    fileprivate var dataManager: MMMFavoriteDataManager?

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UITableViewDataSource
extension MMMFavorityViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0
        if let listArray = self.dataSocrceDic[(self.itemScrollView?.titleStr)!] {
            num = listArray.count
        }
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.itemScrollView?.titleStr == "艺人") {
            let cell = MMMSingerListCell.singerListCell(tableView: tableView, reuseIdentifier: "艺人")
            let singerModel = (self.dataSocrceDic["艺人"] as! [MMMSingerModel])[indexPath.row]
            cell.updateCell(model: singerModel)
            return cell
        } else if (self.itemScrollView?.titleStr == "专辑") {
            let cell = MMMAlbumListCell.albumListCell(tableView: tableView, reuseIdentifier: "专辑")
            let albumModel = (self.dataSocrceDic["专辑"] as! [MMMAlbumModel])[indexPath.row]
            cell.updateCell(model: albumModel)
            return cell
        } else {
            let cell = MMMMusicListCell.musicListCell(tableView: tableView, reuseIdentifier: "单曲")
            let musicModel = (self.dataSocrceDic["单曲"] as! [MMMMusicModel])[indexPath.row]
            cell.updateCell(model: musicModel)
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension MMMFavorityViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
