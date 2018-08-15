//
//  MMMRootViewController.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/8/14.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMRootViewController: MMMBaseViewController {
    
    //顶部导航
    fileprivate var segmentView: MMMSegmentView!
    fileprivate var searchButton: UIButton!
    fileprivate var listButton: UIButton!
    fileprivate var homeVC: MMMHomeViewController!
    fileprivate var mineVC: MMMMineViewController!
    fileprivate var currentIndex: NSInteger?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showNavi = false
        homeVC = MMMHomeViewController()
        mineVC = MMMMineViewController()
        self.addChildViewController(homeVC)
        self.addChildViewController(mineVC)
        self.currentIndex = 0
        setupUI()
    }
    
    private func setupUI() {
        createTopNaviView()
        self.view.addSubview(homeVC.view)
        homeVC.view.frame = CGRect(x: 0, y: kIsIphoneX ? 92 : 68, width: kScreenWidth, height: kScreenHeight - (kIsIphoneX ? 92 : 68))
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
        weak var weakSelf = self
        self.segmentView.titleClickClosure = { (index) in
            if let strongSelf = weakSelf {
                if strongSelf.currentIndex != index {
                    if index == 0 {
                        strongSelf.transition(from: strongSelf.mineVC, to: strongSelf.homeVC, duration: 0.2, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        }, completion: { (isFinished) in
                            strongSelf.homeVC.view.frame = CGRect(x: 0, y: kIsIphoneX ? 92 : 68, width: kScreenWidth, height: kScreenHeight - (kIsIphoneX ? 92 : 68))
                            strongSelf.currentIndex = index
                        })
                    } else {
                        strongSelf.transition(from: strongSelf.homeVC, to: strongSelf.mineVC, duration: 0.2, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        }, completion: { (isFinished) in
                            strongSelf.mineVC.view.frame = CGRect(x: 0, y: kIsIphoneX ? 92 : 68, width: kScreenWidth, height: kScreenHeight - (kIsIphoneX ? 92 : 68))
                            strongSelf.currentIndex = index
                        })
                    }
                }
            }
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
    
    @objc func listButtonClick(sender: UIButton) {
        self.navigationController?.pushViewController(MMMListViewController(type: MusicListType(rawValue: 2)!), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
