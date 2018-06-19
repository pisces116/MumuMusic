//
//  MMMAlbumListCell.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/18.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMAlbumListCell: UITableViewCell {
    
    class func albumListCell(tableView: UITableView, reuseIdentifier: String) -> MMMAlbumListCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? MMMAlbumListCell
        if cell == nil {
            cell = MMMAlbumListCell(style: .default, reuseIdentifier: reuseIdentifier)
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
    
    func updateCell(model: MMMAlbumModel) {
        self.albumNameLabel.text = model.albumName
        self.albumMusicLabel.text = "\(String(describing: (model.ablumMusic?.count)!))首"
        self.albumImageView.image = model.albumImage
    }
    
    private func createSubViews() {
        self.contentView.addSubview(self.albumImageView)
        self.contentView.addSubview(self.albumNameLabel)
        self.contentView.addSubview(self.albumMusicLabel)
        
        self.albumImageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(60)
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        self.albumNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.albumImageView)
            make.leading.equalTo(self.albumImageView.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        self.albumMusicLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.albumImageView)
            make.leading.equalTo(self.albumNameLabel)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate lazy var albumImageView: UIImageView = {
        var imageView = UIImageView()
        return imageView
    }()
    fileprivate lazy var albumNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.rgbColorFromHex(rgb: 0x333333)
        return label
    }()
    fileprivate lazy var albumMusicLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.rgbColorFromHex(rgb: 0x666666)
        return label
    }()

}
