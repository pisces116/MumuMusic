//
//  MMMHomeListCell.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/9.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit

class MMMSingerListCell: UITableViewCell {
    fileprivate lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
//        var iconBorder = CAShapeLayer()
//        iconBorder.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
//        iconBorder.cornerRadius = 30
//        iconBorder.lineWidth = 1 / UIScreen.main.scale
//        iconBorder.borderColor = UIColor(white: 0.00, alpha: 0.90).cgColor
//        iconBorder.shouldRasterize = true
//        iconBorder.rasterizationScale = UIScreen.main.scale
//        
//        imageView.layer.addSublayer(iconBorder)
        return imageView
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
    
    class func singerListCell(tableView: UITableView, reuseIdentifier: String) -> MMMSingerListCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? MMMSingerListCell
        if cell == nil {
            cell = MMMSingerListCell(style: .default, reuseIdentifier: reuseIdentifier)
        }
        return cell!
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubViews()
    }
    
    func updateCell(model: MMMSingerModel) {
        self.homeTitleLabel.text = model.singerName
        self.homeContentLabel.text = "\(String(describing: (model.singerMusic?.count)!))首"
        self.iconImageView.image = model.singerImage
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
            make.trailing.equalToSuperview().offset(-15)
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
