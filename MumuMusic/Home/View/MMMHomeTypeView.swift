//
//  MMMHomeTypeView.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/12.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMHomeTypeView: UIView {
    
    init(frame: CGRect, title: String, subTitle: String) {
        super.init(frame: frame)
        self.title = title
        self.subTitle = subTitle
        self.createSubViews()
    }
    func updateView(title: String, subTitle: String) {
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
    }
    
    private func createSubViews() {
        self.addSubview(self.backButton)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitleLabel)
        
        self.backButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        self.subTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
        }
        self.titleLabel.text = self.title
        self.subTitleLabel.text = self.subTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonClick(sender: UIButton) {
        if self.viewSelectClosure != nil {
            self.viewSelectClosure!()
        }
    }
    
    //MARK: - Properties
    var viewSelectClosure: (() -> Void)?
    fileprivate var title: String?
    fileprivate var subTitle: String?
    fileprivate lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    fileprivate lazy var subTitleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26)
        label.textColor = UIColor.black
        return label
    }()
    fileprivate lazy var backButton: UIButton = {
        var button = UIButton(type: .custom)
        button .addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        return button
    }()
    
}
