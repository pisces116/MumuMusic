//
//  MMMListViewController.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/9.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

let reuseIdentifier: String = "MMMHomeListCell"

class MMMListViewController: MMMBaseViewController, UITableViewDataSource, UITableViewDelegate{
    fileprivate var tableView: UITableView!
    fileprivate var musicManager: MMMMusicManager?
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
        self.musicManager?.currentMusic = self.musicManager?.musicArray![indexPath.row]
        let musicPlay = MMMPlayViewController.init(manager: self.musicManager!, playMusic: true)
        self.present(musicPlay, animated: true, completion: nil)
    }
}
