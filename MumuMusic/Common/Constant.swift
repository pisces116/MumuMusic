//
//  Constant.swift
//  MumuMusic
//
//  Created by 卞方庆 on 2018/6/8.
//  Copyright © 2018年 卞方庆. All rights reserved.
//

import Foundation
import UIKit

let kNotificationMusicPlayEnd = "kNotificationMusicPlayEnd"

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kIsIphoneX = (kScreenHeight == 812.0)
let kBottomMargin = kIsIphoneX ? 35.0 : 0
let kTopMargin = kIsIphoneX ? 44.0 : 20

extension UIColor {
    /**
     *  16进制 转 RGBA
     */
    class func rgbaColorFromHex(rgb:Int, alpha:CGFloat) -> UIColor {
        
        return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                       alpha: alpha)
    }
    
    /**
     *  16进制 转 RGB
     */
    class func rgbColorFromHex(rgb:Int) -> UIColor {
        
        return UIColor(red: ((CGFloat)((rgb & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgb & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgb & 0xFF)) / 255.0,
                       alpha: 1.0)
    }
}

extension UIImage {
    class func image(view: UIView, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.layer.render(in: ctx)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func image(_ text:String, font: UIFont, size:CGSize, edgeInset:UIEdgeInsets, backColor:UIColor, textColor:UIColor, isCircle:Bool) -> UIImage? {
        // 过滤空""
        if text.isEmpty { return nil }
        let contextSize = CGSize(width: size.width + edgeInset.left + edgeInset.right, height: size.height + edgeInset.top + edgeInset.bottom)
        let rect = CGRect(origin: CGPoint.zero, size: contextSize)
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        // 拿到上下文
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        // 取较小的边
        let minSide = min(contextSize.width, contextSize.height)
        // 是否圆角裁剪
        if isCircle {
            let circle = UIBezierPath(roundedRect: rect, cornerRadius: minSide * 0.5)
            circle.addClip()
            circle.addLine(to: CGPoint(x: 0, y: 0))
        }
        // 设置填充颜色
        ctx.setFillColor(backColor.cgColor)
        // 填充绘制
        ctx.fill(rect)
        let attr = [kCTForegroundColorAttributeName: textColor, kCTFontAttributeName: font]
        // 写入文字
        (text as NSString).draw(at: CGPoint(x: edgeInset.left, y: edgeInset.top), withAttributes: attr as [NSAttributedStringKey : Any])
        // 得到图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭上下文
        UIGraphicsEndImageContext()
        return image
    }
    //MARK: - 颜色图片
    class func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    //MARK: - 圆角图片
    func imageWithRoundCorner() -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.ctm.scaledBy(x: 1, y: -1)
        context?.ctm.translatedBy(x: 0, y: -rect.size.height)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: self.size)
        path.close()
        context?.saveGState()
        path.addClip()
        context?.draw(self.cgImage!, in: rect)
        context?.resetClip()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
