//
//  MMMCircularLoaderView.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/20.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import UIKit
//圆形播放进度条
class MMMCircularLoaderView: UIView {
    let circlePathLayer = CAShapeLayer()
    let circleRadius: CGFloat = 20.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.rgbColorFromHex(rgb: 0xdcdcdc).cgColor
        circlePathLayer.strokeColor = UIColor.rgbColorFromHex(rgb: 0xe4005b).cgColor
        layer.addSublayer(circlePathLayer)
//        backgroundColor = UIColor.white
    }
    func circleFrame() -> CGRect {
        var circleFrame = CGRect(x: 0, y: 0, width: 2 * circleRadius, height: 2 * circleRadius)
        circleFrame.origin.x = circlePathLayer.bounds.maxX - circleFrame.midX
        circleFrame.origin.y = circlePathLayer.bounds.maxY - circleFrame.midY
        return circleFrame
    }
    func circlePath() -> UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40))
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().cgPath
    }
    var progress: CGFloat {
        get {
            return circlePathLayer.strokeEnd
        }
        set {
            if (newValue > 1) {
                circlePathLayer.strokeEnd = 1
            } else if (newValue < 0) {
                circlePathLayer.strokeEnd = 0
            } else {
                circlePathLayer.strokeEnd = newValue
            }
        }
    }
    
}
