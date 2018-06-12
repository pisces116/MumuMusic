//
//  MMMHomeViewController.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/7.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMHomeViewController: MMMBaseViewController {
    //顶部导航
    fileprivate var segmentView: MMMSegmentView!
    fileprivate var searchButton: UIButton!
    fileprivate var listButton: UIButton!
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
        createTopNaviView()
        createTypeViews()
    }
    
    private func createTopNaviView() {
        self.listButton = UIButton(type: .custom)
        self.view.addSubview(self.listButton)
        self.listButton.setTitle("List", for: .normal)
        self.listButton.setTitleColor(UIColor.black, for: .normal)
        self.listButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.listButton.addTarget(self, action: #selector(listButtonClick(sender:)), for: .touchUpInside)
        
        self.searchButton = UIButton(type: .custom)
        self.view.addSubview(self.searchButton!)
        self.searchButton.setTitle("Search", for: .normal)
        self.searchButton.setTitleColor(UIColor.black, for: .normal)
        self.searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        self.segmentView = MMMSegmentView(frame: CGRect.zero, titles: ["HOME","ME"])
        self.segmentView.setSelectTitle(index: 0)
        self.segmentView.titleClickClosure = { (index) in
            
        }
        self.view.addSubview(self.segmentView)
        
        self.listButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(kTopMargin)
            make.height.width.equalTo(48)
        }
        
        self.searchButton.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(kTopMargin)
            make.height.width.equalTo(48)
        }
        
        self.segmentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kTopMargin)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.width.equalTo(kScreenWidth * 0.5)
        }
    }
    private func createTypeViews() {
        self.favorityView = MMMHomeTypeView(frame: CGRect.zero, title: "喜欢&收藏", subTitle: "0")
        self.localView = MMMHomeTypeView(frame: CGRect.zero, title: "本地音乐", subTitle: "0")
        self.historyView = MMMHomeTypeView(frame: CGRect.zero, title: "历史播放", subTitle: "0")
        
        self.view.addSubview(self.favorityView)
        self.view.addSubview(self.localView)
        self.view.addSubview(self.historyView)
        
        self.favorityView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(self.segmentView.snp.bottom).offset(20)
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
    
    @objc func listButtonClick(sender: UIButton) {
        self.navigationController?.pushViewController(MMMListViewController(type: MusicListType(rawValue: 2)!), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
