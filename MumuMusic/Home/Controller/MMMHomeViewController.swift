//
//  MMMHomeViewController.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/7.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMHomeViewController: MMMBaseViewController {
    fileprivate var segmentView: MMMSegmentView!
    fileprivate var searchButton: UIButton!
    fileprivate var listButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showNavi = false
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        self.listButton = UIButton(type: .custom)
        self.view.addSubview(self.listButton)
        self.listButton.setTitle("List", for: .normal)
        self.listButton.setTitleColor(UIColor.black, for: .normal)
        
        self.searchButton = UIButton(type: .custom)
        self.view.addSubview(self.searchButton!)
        self.searchButton.setTitle("Search", for: .normal)
        self.searchButton.setTitleColor(UIColor.black, for: .normal)
        
        self.segmentView = MMMSegmentView(frame: CGRect.zero, titles: ["HOME","ME"])
        self.segmentView.setSelectTitle(index: 0)
        self.segmentView.titleClickClosure = { (index) in
            print(index)
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
            make.leading.equalToSuperview().offset(48);
            make.trailing.equalToSuperview().offset(-48)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
