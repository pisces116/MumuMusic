//
//  MMMMusicListCell.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/18.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMMusicListCell: UITableViewCell {

    class func musicListCell(tableView: UITableView, reuseIdentifier: String) -> MMMMusicListCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? MMMMusicListCell
        if cell == nil {
            cell = MMMMusicListCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(model: MMMMusicModel) {
        self.musicLabel.text = model.name
        self.singerLabel.text = model.artist
    }
    
    private func createSubViews() {
        self.contentView.addSubview(self.musicLabel)
        self.contentView.addSubview(self.singerLabel)
        self.musicLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(14)
        }
        self.singerLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.musicLabel)
            make.top.equalTo(self.musicLabel.snp.bottom).offset(7)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate lazy var musicLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.rgbColorFromHex(rgb: 0x333333)
        return label
    }()
    fileprivate lazy var singerLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgbColorFromHex(rgb: 0x666666)
        return label
    }()

}
