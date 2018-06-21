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
    let circleBackPathLayer = CAShapeLayer()
    let circlePathLayer = CAShapeLayer()
    let circleRadius: CGFloat = 20.0
    let circleRect: CGRect!
    
    init(frame: CGRect, circleRect: CGRect) {
        self.circleRect = circleRect
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        circleBackPathLayer.frame = self.circleRect
        circleBackPathLayer.lineWidth = 2
        circleBackPathLayer.fillColor = UIColor.clear.cgColor
        circleBackPathLayer.strokeColor = UIColor.rgbColorFromHex(rgb: 0xdcdcdc).cgColor
        circleBackPathLayer.strokeStart = 0;
        circleBackPathLayer.strokeEnd = 1;
        circleBackPathLayer.path = circlePath().cgPath
        layer.addSublayer(circleBackPathLayer)
        circlePathLayer.frame = self.circleRect
        circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.clear.cgColor
        circlePathLayer.strokeColor = UIColor.rgbColorFromHex(rgb: 0xe4005b).cgColor
        circlePathLayer.strokeStart = 0;
        layer.addSublayer(circlePathLayer)
        self.circleBackPathLayer.path = circlePath().cgPath
    }
    func circlePath() -> UIBezierPath {
        return UIBezierPath(arcCenter: CGPoint(x: self.circleRect.midX, y: self.circleRect.midY), radius: self.circleRect.midX, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(Double.pi + Double.pi/2), clockwise: true)
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
                circlePathLayer.path = circlePath().cgPath
            }
        }
    }
    
}
