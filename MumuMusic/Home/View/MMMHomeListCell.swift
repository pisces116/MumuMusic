//
//  MMMHomeListCell.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/9.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

enum HomeCellType: Int {
    case HomeCellMusicType = 0
    case HomeCellSingerType = 1
    case HomeCellAlbumType = 2
    case HomeCellGenreType = 3
}

class MMMHomeListCell: UITableViewCell {
    fileprivate lazy var iconImageView: UIImageView = {
        return UIImageView.init()
    }()
    fileprivate var homeTitleLabel: UILabel = {
        var label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.rgbColorFromHex(rgb: 0x333333)
        return label
    }()
    fileprivate var homeContentLabel: UILabel = {
        var label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.rgbColorFromHex(rgb: 0x666666)
        return label
    }()
    fileprivate var editButton: UIButton = {
        return UIButton(type: .custom)
    }()

    init(style: UITableViewCellStyle, reuseIdentifier: String?, type: HomeCellType) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createSubViews()
    }
    
    func updateCell(model: MMMMusicModel) {
        self.iconImageView.image = model.image
        self.homeTitleLabel.text = model.name
        self.homeContentLabel.text = model.artist
    }
    
    private func createSubViews() {
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.homeTitleLabel)
        self.contentView.addSubview(self.homeContentLabel)
        self.contentView.addSubview(self.editButton)
        
        self.iconImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(60)
            make.centerY.equalToSuperview()
        }
        self.homeTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.iconImageView)
            make.leading.equalTo(self.iconImageView.snp.trailing).offset(15)
        }
        self.homeContentLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.iconImageView)
            make.leading.equalTo(self.homeTitleLabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
