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
    //MARK: - Public Func
    public func setSelectTitle(index:Int) {
        updateSelectTitle(index: index)
    }
    //MARK: - Private Func
    private func setupUI() {
        self.addSubview(self.bottomLineView)
        self.bottomLineView.center = CGPoint(x: 40, y: 40)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        for (index, title) in self.titles!.enumerated() {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: index * 80, y: 0, width: 80, height: 50)
            self.titleButtons.append(button)
            button.setTitle(title, for: .normal)
            button.setTitle(title, for: .selected)
            button.setTitleColor(UIColor.rgbColorFromHex(rgb: 0x666666), for: .normal)
            button.setTitleColor(UIColor.black, for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.tag = index
            button.titleEdgeInsets = UIEdgeInsetsMake(-9, 0, 0, 0)
            button.addTarget(self, action: #selector(titleButtonClick(sender:)), for: .touchUpInside)
            self.addSubview(button)
        }
        self.contentSize = CGSize(width: 80 * CGFloat(self.titleButtons.count), height: 50)
    }
    
    private func updateSelectTitle(index: Int) {
        if index < self.titleButtons.count {
            UIView.animate(withDuration: 0.2) {
                self.bottomLineView.center.x = CGFloat(index) * 80 + 40
                self.contentOffset = self.calculateContentOffset(index: index)
            }
            let button = self.titleButtons[selectIndex]
            let selectButton = self.titleButtons[index]
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            selectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16);
            button.isSelected = false
            selectButton.isSelected = true
            self.titleStr = selectButton.titleLabel?.text
            selectIndex = index
        }
    }
    func calculateContentOffset(index: Int) -> CGPoint {
        var offsetX = kScreenWidth * 0.5 - (CGFloat(index) * 80 + 40)
        let OffsetMaxX = CGFloat(self.titleButtons.count) * 80 - kScreenWidth
        if (offsetX > 0) {
            offsetX = 0
        } else if (-offsetX > OffsetMaxX) {
            offsetX = -OffsetMaxX
        }
        return CGPoint(x: -offsetX, y: 0)
    }
    
    //MARK: - Action
    @objc private func titleButtonClick(sender: UIButton)  {
        if sender.tag == self.selectIndex {
            return
        }
        updateSelectTitle(index: sender.tag)
        if self.titleClickClosure != nil {
            self.titleClickClosure!()
        }
    }
    //MARK: - Public Properties
    var titleClickClosure: (() -> Void)?
    var titleStr: String?
    //MARK: - Private Properties
    fileprivate var selectIndex: Int = 0
    fileprivate let titles: [String]?
    fileprivate var titleButtons: [UIButton] = [UIButton]()
    fileprivate lazy var bottomLineView: UIView = {
        var view = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 15, height: 3)));
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 1.5
        return view
    }()
}
