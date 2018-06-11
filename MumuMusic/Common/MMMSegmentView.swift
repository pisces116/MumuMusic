//
//  MMMSegmentView.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/7.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMSegmentView: UIView {
    
    var titleClickClosure: ((Int) -> Void)?
    
    fileprivate let titles: [String]?
    fileprivate lazy var buttonArray :[UIButton] = {
        return [UIButton]()
    }()
    fileprivate var selectIndex: Int = 0
    
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Public Func
    public func setSelectTitle(index:Int) {
        updateSelectTitle(index: index)
    }
    
    //MARK: - Private Func
    
    private func setupUI() {
        for (index, title) in self.titles!.enumerated() {
            let button = UIButton(type: .custom)
            self.buttonArray.append(button)
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.tag = index
            button.addTarget(self, action: #selector(titleButtonClick(sender:)), for: .touchUpInside)
            self.addSubview(button)
            
            button.snp.makeConstraints { (make) in
                make.top.bottom.equalToSuperview()
            }
        }
        var preButton :UIButton?
        for (index, button) in self.buttonArray.enumerated() {
            if (preButton != nil) {
                button.snp.makeConstraints { (make) in
                    make.width.equalTo(preButton!)
                    make.leading.equalTo((preButton?.snp.trailing)!)
                    if (index == self.buttonArray.count - 1) {
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
        if index < self.buttonArray.count {
            let button = self.buttonArray[selectIndex]
            let selectButton = self.buttonArray[index]
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
}
