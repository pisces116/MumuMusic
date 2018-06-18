//
//  MMMItemScrollView.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/13.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMItemScrollView: UIScrollView {

    init(frame: CGRect, titles: [String]?) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        for (index, title) in self.titles!.enumerated() {
            let button = UIButton(type: .custom)
            self.titleButtons.append(button)
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.tag = index
            button.addTarget(self, action: #selector(titleButtonClick(sender:)), for: .touchUpInside)
            self.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(80)
                make.height.equalTo(50)
            }
        }
        var preButton :UIButton?
        for (index, button) in self.titleButtons.enumerated() {
            if (preButton != nil) {
                button.snp.makeConstraints { (make) in
                    make.leading.equalTo((preButton?.snp.trailing)!)
                    if (index == self.titleButtons.count - 1) {
                        make.trailing.equalToSuperview()
                    }
                }
            } else {
                button.snp.makeConstraints { (make) in
                    make.leading.equalToSuperview()
                }
            }
            preButton = button
        }
    }
    
    private func updateSelectTitle(index: Int) {
        if index < self.titleButtons.count {
            let button = self.titleButtons[selectIndex]
            let selectButton = self.titleButtons[index]
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18);
            selectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            selectIndex = index
        }
    }
    
    //MARK: - Action
    @objc private func titleButtonClick(sender: UIButton)  {
        if sender.tag == self.selectIndex {
            return
        }
        updateSelectTitle(index: sender.tag)
        if self.titleClickClosure != nil {
            self.titleClickClosure!(sender.tag)
        }
    }
    //MARK: - Public Properties
    var titleClickClosure: ((Int) -> Void)?
    var titleStr: String?
    //MARK: - Private Properties
    fileprivate var selectIndex: Int = 0
    fileprivate let titles: [String]?
    fileprivate var titleButtons: [UIButton] = [UIButton]()
    fileprivate lazy var bottomLineView: UIView = {
        var view = UIView();
        
        return view
    }()
}
