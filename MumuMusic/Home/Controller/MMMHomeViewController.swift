//
//  MMMHomeViewController.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/7.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMHomeViewController: MMMBaseViewController {
    
    //分类型跳转
    fileprivate var favorityView: MMMHomeTypeView!
    fileprivate var localView: MMMHomeTypeView!
    fileprivate var historyView: MMMHomeTypeView!
    //推荐
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showNavi = false
        setupUI()
    }
    
    private func setupUI() {
        createTypeViews()
    }
    
    private func createTypeViews() {
        self.favorityView = MMMHomeTypeView(frame: CGRect.zero, title: "喜欢&收藏", subTitle: "0")
        self.localView = MMMHomeTypeView(frame: CGRect.zero, title: "本地音乐", subTitle: "0")
        self.historyView = MMMHomeTypeView(frame: CGRect.zero, title: "历史播放", subTitle: "0")
        
        self.view.addSubview(self.favorityView)
        self.view.addSubview(self.localView)
        self.view.addSubview(self.historyView)
        
        self.favorityView.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(20)
            make.height.equalTo(80)
        }
        self.localView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.favorityView.snp.trailing)
            make.height.width.top.equalTo(self.favorityView)
        }
        self.historyView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.localView.snp.trailing)
            make.height.width.top.equalTo(self.favorityView)
            make.trailing.equalToSuperview().offset(20)
        }
        weak var weakSelf = self
        self.favorityView.viewSelectClosure = {
            if let strongSelf = weakSelf {
                let favorityVC = MMMFavorityViewController()
                strongSelf.navigationController?.pushViewController(favorityVC, animated: true)
            }
        }
        self.localView.viewSelectClosure = {
            if let strongSelf = weakSelf {
                let localVC = MMMListViewController(type: MusicListType(rawValue: 0)!)
                strongSelf.navigationController?.pushViewController(localVC, animated: true)
            }
        }
        self.historyView.viewSelectClosure = {
            if let strongSelf = weakSelf {
                let historyVC = MMMListViewController(type: MusicListType(rawValue: 1)!)
                strongSelf.navigationController?.pushViewController(historyVC, animated: true)
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
