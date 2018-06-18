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
        
        createSubViews()
    }
    
    //MARK: - Private Func
    private func loadFavoriteDataSource() {
        self.dataSocrceDic = [String: [Any]]()
    }
    
    private func createSubViews() {
        self.itemScrollView = MMMItemScrollView(frame: CGRect.zero, titles: ["单曲", "艺人", "专辑", "MV", "流派"])
        self.tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        self.tableView.backgroundColor = UIColor.white
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 90
        self.view.addSubview(self.itemScrollView!)
        self.itemScrollView?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kTopMargin + 44)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    //MARK: - Private Properties
    fileprivate var itemScrollView: MMMItemScrollView?
    fileprivate var tableView: UITableView!
    fileprivate var dataSocrceDic: [String: [Any]]!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//MARK: - UITableViewDataSource
extension MMMFavorityViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSocrceDic[(self.itemScrollView?.titleStr)!]!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return MMMSingerListCell(style: .default, reuseIdentifier: nil)
    }
}

//MARK: - UITableViewDelegate
extension MMMFavorityViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
