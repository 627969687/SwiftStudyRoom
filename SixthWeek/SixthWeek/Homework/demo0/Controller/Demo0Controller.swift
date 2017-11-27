//
//  Demo1Controller.swift
//  FirstWeek
//
//  Created by 荣 Jason on 2017/10/16.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//

import UIKit

class Demo0Controller: UIViewController {
    fileprivate var screenW:CGFloat!
    fileprivate var screenH:CGFloat!
    
    fileprivate let cloudW = #imageLiteral(resourceName: "cloud").size.width * 0.5
    fileprivate let cloudH = #imageLiteral(resourceName: "cloud").size.height * 0.5
    fileprivate var groundW:CGFloat!
    fileprivate let groundH = #imageLiteral(resourceName: "mud").size.height * 0.5
    fileprivate var moutainMaxH:CGFloat = 0 // 最大雪山高度
    fileprivate var moutainMaxW:CGFloat = 0 // 最大雪山宽度
    fileprivate var grassMaxH:CGFloat = 0
    fileprivate var grassMaxW:CGFloat = 0
    fileprivate var yellowTrack:CAShapeLayer!
    fileprivate var greenTrack:CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenW = UIScreen.main.bounds.size.width
        screenH = UIScreen.main.bounds.size.height
        groundW = UIScreen.main.bounds.size.width
        moutainMaxH = screenH * 0.7
        moutainMaxW = screenW * 0.45
        grassMaxH = moutainMaxH * 0.25
        grassMaxW = screenW
        
        setupUI()
        setupAnim()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .landscape
        }
        set {
            self.supportedInterfaceOrientations = newValue
        }
    }
}

// MARK: - UI
extension Demo0Controller {
    fileprivate func setupUI() {
        setupBG()
        setupTrack()
    }
    
    fileprivate func setupAnim() {
        setupCloudAnim()
        setupCarAnim()
    }
    
    // MARK: 云朵
    fileprivate func setupCloudAnim() {
        let layer = CALayer()
        layer.contents = #imageLiteral(resourceName: "cloud").cgImage
        layer.frame = CGRect(x: screenW + cloudW, y: 44, width: cloudW, height: cloudH)
        view.layer.addSublayer(layer)
        
        let anim = CABasicAnimation(keyPath: "position.x")
        anim.fromValue = screenW + cloudW
        anim.toValue = -cloudW
        anim.duration = 15
        anim.repeatCount = MAXFLOAT
        layer.add(anim, forKey: nil)
    }
    
    fileprivate func setupCarAnim() {
        setupColorCarAnim(img: #imageLiteral(resourceName: "otherTrain"), begin: CACurrentMediaTime()+7, time: 7, track: yellowTrack)
        setupColorCarAnim(img: #imageLiteral(resourceName: "train"), begin: CACurrentMediaTime()+1, time: 7, track: greenTrack)
    }
    
    fileprivate func setupColorCarAnim(img:UIImage,begin:CFTimeInterval,time:CFTimeInterval,track:CAShapeLayer) {
        let car = CALayer()
        car.contents = img.cgImage
        car.frame = CGRect(x: -img.size.width*1.5, y: 0, width: img.size.width*1.5, height: img.size.height*1.5)
        car.setAffineTransform(car.affineTransform().translatedBy(x: 0, y: -7)) // 列车上移，保持车轮在轨道上
        view.layer.addSublayer(car)
        
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = track.path
        anim.beginTime = begin
        anim.duration = time
        anim.repeatCount = MAXFLOAT
        anim.calculationMode = kCAAnimationCubicPaced
        anim.rotationMode = kCAAnimationRotateAuto
        car.add(anim, forKey: nil)
        
        let copyLayer = CAReplicatorLayer()
        copyLayer.instanceCount = 3
//        copyLayer.instanceTransform = CATransform3DMakeTranslation(-img.size.width*1.5, 0, 0)
        copyLayer.instanceDelay = 0.1
        copyLayer.addSublayer(car)
        view.layer.addSublayer(copyLayer)
    }
}

// MARK: - 背景
extension Demo0Controller {
    fileprivate func setupBG() {
        setupSky()
        setupGround()
        setupMountain()
        setupGrassland()
        setupTree()
    }
    
    // MARK: 天空
    fileprivate func setupSky() {
        let colors:[CGColor] = [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.209955077, green: 0.5977561329, blue: 0.9196958814, alpha: 1)]
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = colors
        layer.startPoint = CGPoint(x: 1.0, y: 1.0)
        layer.endPoint = CGPoint.zero
        view.layer.addSublayer(layer)
    }
    
    // MARK: 广场
    fileprivate func setupGround() {
        let layer = CALayer()
        layer.contents = #imageLiteral(resourceName: "mud").cgImage
        layer.frame = CGRect(x: 0, y: screenH - groundH, width: groundW, height: groundH)
        layer.zPosition = 0.1 // 改变层级
        view.layer.addSublayer(layer)
    }

    // MARK: 雪山
    fileprivate func setupMountain() {
        // 左侧
        let leftHillTopP = CGPoint(x: moutainMaxW * 0.5, y: screenH - moutainMaxH - groundH)
        let leftHillLBottomBeginP = CGPoint(x: 0, y: screenH - groundH)
        let leftHillLBottomEndP = CGPoint(x: 0, y: screenH - groundH - moutainMaxH * 0.35)
        let leftHillRBottomP = CGPoint(x: moutainMaxW, y: screenH - groundH)
        let leftBrownMiddleP = CGPoint(x: moutainMaxW*0.75, y: calculateLineY(x: moutainMaxW*0.75, startP: leftHillRBottomP, endP: leftHillTopP))
        setupLeftMountain(top: leftHillTopP, begin: leftHillLBottomBeginP, end: leftHillLBottomEndP, rightBottom: leftHillRBottomP, brownBegin: leftBrownMiddleP)
        
        // 右侧
        let rightHillLfBottomP = CGPoint(x: leftHillRBottomP.x - moutainMaxW * 0.35, y: leftHillRBottomP.y)
        let rightHillRtBottomP = CGPoint(x: leftHillRBottomP.x + moutainMaxW * 0.75, y: rightHillLfBottomP.y)
        let rightHillTopP = CGPoint(x: rightHillRtBottomP.x * 0.7, y: screenH - moutainMaxH * 0.7 - groundH)
        let rightBrownMiddleP = CGPoint(x: rightHillRtBottomP.x * 0.88, y: calculateLineY(x: rightHillRtBottomP.x * 0.88, startP: rightHillRtBottomP, endP: rightHillTopP))
        setupRightMountain(right: rightHillRtBottomP, left: rightHillLfBottomP, top: rightHillTopP, brownBegin: rightBrownMiddleP)
    }

    // 左侧雪山
    fileprivate func setupLeftMountain(top:CGPoint,begin:CGPoint,end:CGPoint,rightBottom:CGPoint,brownBegin:CGPoint,_ margin:CGFloat = 30) {
        // 左侧雪山白色山体
        let leftSnowWhiteM = CAShapeLayer()
        let leftSnowWhitePath = UIBezierPath()
        // 左下起点 ==> 右下 ==> 顶点 ==> 左下终点
        leftSnowWhitePath.move(to: begin)
        leftSnowWhitePath.addLine(to: rightBottom)
        leftSnowWhitePath.addLine(to: top)
        leftSnowWhitePath.addLine(to: end)
        leftSnowWhitePath.close()
        
        leftSnowWhiteM.path = leftSnowWhitePath.cgPath
        leftSnowWhiteM.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        view.layer.addSublayer(leftSnowWhiteM)
        
        // 左侧雪山棕色山体
        let leftSnowBrownM = CAShapeLayer()
        let leftSnowBrownPath = UIBezierPath()
        // 右 ==> 左
        leftSnowBrownPath.move(to: begin)
        leftSnowBrownPath.addLine(to: rightBottom)
        leftSnowBrownPath.addLine(to: brownBegin)
        
        leftSnowBrownPath.addLine(to: CGPoint(x: brownBegin.x - margin, y: brownBegin.y))
        leftSnowBrownPath.addLine(to: CGPoint(x: brownBegin.x - margin * 1.5, y: brownBegin.y - margin * 0.5))
        leftSnowBrownPath.addLine(to: CGPoint(x: brownBegin.x - margin * 3, y: brownBegin.y))
        leftSnowBrownPath.addLine(to: CGPoint(x: brownBegin.x - margin * 4, y: brownBegin.y + margin))
        leftSnowBrownPath.addLine(to: CGPoint(x: brownBegin.x - margin * 5, y: brownBegin.y))
        leftSnowBrownPath.addLine(to: CGPoint(x: calculateLineX(y: brownBegin.y, startP: end, endP: top), y: brownBegin.y))
        
        leftSnowBrownPath.addLine(to: end)
        leftSnowBrownPath.close()
        
        leftSnowBrownM.path = leftSnowBrownPath.cgPath
        leftSnowBrownM.fillColor = #colorLiteral(red: 0.2941176471, green: 0.2549019608, blue: 0.4352941176, alpha: 1).cgColor
        view.layer.addSublayer(leftSnowBrownM)
    }
    
    fileprivate func setupRightMountain(right:CGPoint,left:CGPoint,top:CGPoint,brownBegin:CGPoint,_ margin:CGFloat = 30) {
        // 右侧雪山白色山体
        let rightSnowWhiteM = CAShapeLayer()
        let rightSnowWhitePath = UIBezierPath()
        // 左 ==> 右 ==> 顶点
        rightSnowWhitePath.move(to: left)
        rightSnowWhitePath.addLine(to: right)
        rightSnowWhitePath.addLine(to: top)
        rightSnowWhitePath.close()
        
        rightSnowWhiteM.path = rightSnowWhitePath.cgPath
        rightSnowWhiteM.fillColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        view.layer.addSublayer(rightSnowWhiteM)
        
        // 右侧雪山棕色山体
        let rightSnowBrownM = CAShapeLayer()
        let rightSnowBrownPath = UIBezierPath()
        
        rightSnowBrownPath.move(to: left)
        rightSnowBrownPath.addLine(to: right)
        rightSnowBrownPath.addLine(to: CGPoint(x: brownBegin.x, y: brownBegin.y))
        
        rightSnowBrownPath.addLine(to: CGPoint(x: brownBegin.x - 30, y: brownBegin.y))
        rightSnowBrownPath.addLine(to: CGPoint(x: brownBegin.x - 30 * 2, y: brownBegin.y + 5))
        rightSnowBrownPath.addLine(to: CGPoint(x: brownBegin.x - 30 * 3.5, y: brownBegin.y - 30))
        rightSnowBrownPath.addLine(to: CGPoint(x: brownBegin.x - 30 * 4.5, y: brownBegin.y + 15))
        rightSnowBrownPath.addLine(to: CGPoint(x: brownBegin.x - 30 * 5.5, y: brownBegin.y - 30 * 0.65))
        
        rightSnowBrownPath.addLine(to: CGPoint(x: calculateLineX(y: brownBegin.y - 30 * 0.65, startP: left, endP: top), y: brownBegin.y - 30 * 0.65))
        rightSnowBrownPath.close()
        
        rightSnowBrownM.path = rightSnowBrownPath.cgPath
        rightSnowBrownM.fillColor = #colorLiteral(red: 0.4078431373, green: 0.3568627451, blue: 0.6078431373, alpha: 1).cgColor
        view.layer.addSublayer(rightSnowBrownM)
    }

    // MARK: 草原
    fileprivate func setupGrassland() {
        // 左侧
        let leftGrass = CAShapeLayer()
        let leftGrassPath = UIBezierPath()
        leftGrassPath.move(to: CGPoint(x: 0, y: screenH - groundH - grassMaxH))
        leftGrassPath.addQuadCurve(to: CGPoint(x: moutainMaxW * 0.65, y: screenH - groundH), controlPoint: CGPoint(x: moutainMaxW * 0.4, y: screenH - groundH - grassMaxH))
        leftGrassPath.addLine(to: CGPoint(x: 0, y: screenH - groundH))
        leftGrassPath.close()
        leftGrass.path = leftGrassPath.cgPath
        leftGrass.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor
        view.layer.addSublayer(leftGrass)
        
        // 右侧
        let rightGrass = CAShapeLayer()
        let rightGrassPath = UIBezierPath()
        rightGrassPath.move(to: CGPoint(x: grassMaxW, y: screenH - groundH - grassMaxH * 0.95))
        rightGrassPath.addQuadCurve(to: CGPoint(x: 0, y: screenH - groundH), controlPoint: CGPoint(x: grassMaxW * 0.45, y: screenH - groundH - grassMaxH * 0.95))
        rightGrassPath.addLine(to: CGPoint(x: grassMaxW, y: screenH - groundH))
        rightGrassPath.close()
        rightGrass.path = rightGrassPath.cgPath
        rightGrass.fillColor = #colorLiteral(red: 0.04610688877, green: 0.7839665292, blue: 0.01476480715, alpha: 1).cgColor
        view.layer.addSublayer(rightGrass)
    }
    
    // MARK: 树木
    fileprivate func setupTree() {
        let size = CGSize(width: #imageLiteral(resourceName: "tree").size.width * 0.5, height: #imageLiteral(resourceName: "tree").size.height * 0.5)
        let number = 10
        
        for _ in 0..<number {
            let x = CGFloat(arc4random_uniform(UInt32(grassMaxW-size.width)))
            let y = CGFloat(arc4random_uniform(UInt32(grassMaxH-size.height))) + (screenH-grassMaxH)
            let layer = CALayer()
            layer.contents = #imageLiteral(resourceName: "tree").cgImage
            layer.frame = CGRect(origin: CGPoint(x: x, y: y), size: size)
            layer.zPosition = 0.2
            view.layer.addSublayer(layer)
        }
    }
}

// MARK: - 轨道
extension Demo0Controller {
    fileprivate func setupTrack() {
        setupYellowTrack()
        setupGreenTrack()
    }
    
    fileprivate func setupYellowTrack() {
        yellowTrack = CAShapeLayer()
        let trackPath = UIBezierPath()
        
        trackPath.move(to: CGPoint(x: 0, y: screenH-groundH-grassMaxH*0.5))
        trackPath.addCurve(to: CGPoint(x: screenW*0.7, y: screenH*0.5), controlPoint1: CGPoint(x: screenW*0.15, y: screenH*0.45), controlPoint2: CGPoint(x: screenW*0.4, y: screenH*1.2))
        trackPath.addQuadCurve(to: CGPoint(x: screenW+30, y: screenH*0.3), controlPoint: CGPoint(x: screenW*0.85, y: screenH*0.2))
        // 添加栅栏需要另外画线，控制填充方向
        trackPath.addLine(to: CGPoint(x: screenW+30, y: screenH+30))
        trackPath.addLine(to: CGPoint(x: 0, y: screenH+30))
        
        yellowTrack.fillColor = UIColor(patternImage: #imageLiteral(resourceName: "yellowTrack")).cgColor
        yellowTrack.strokeColor = #colorLiteral(red: 0.9450980392, green: 0.8039215686, blue: 0.1843137255, alpha: 1).cgColor
        yellowTrack.lineWidth = 5
        yellowTrack.path = trackPath.cgPath
        setupTrackLine(track: yellowTrack)
        
        view.layer.addSublayer(yellowTrack)
    }
    
    fileprivate func setupGreenTrack() {
        greenTrack = CAShapeLayer()
        let trackPath = UIBezierPath()
        
        trackPath.move(to: CGPoint(x: screenW, y: screenH * 0.9))
        trackPath.addQuadCurve(to: CGPoint(x: screenW*0.55, y: screenH * 0.65 + 70), controlPoint: CGPoint(x: screenW*0.8, y: screenH * 0.6))
        trackPath.addArc(withCenter: CGPoint(x: screenW*0.52, y: screenH*0.65), radius: 70, startAngle: CGFloat(0.5*Double.pi), endAngle: CGFloat(2.5*Double.pi), clockwise: true)
        trackPath.addCurve(to: CGPoint(x: 0, y: screenH * 0.83), controlPoint1: CGPoint(x: screenW * 0.25, y: screenH * 0.9), controlPoint2: CGPoint(x: screenW * 0.35, y: screenH * 0.4))
        // 添加栅栏需要另外画线，控制填充方向
        trackPath.addLine(to: CGPoint(x: -30, y: screenH + 30))
        trackPath.addLine(to: CGPoint(x: screenW, y: screenH + 30))
        
        greenTrack.fillColor = UIColor(patternImage: #imageLiteral(resourceName: "greenTrack")).cgColor
        greenTrack.strokeColor = #colorLiteral(red: 0, green: 0.6431372549, blue: 0.7058823529, alpha: 1)
        greenTrack.lineWidth = 5
        greenTrack.path = trackPath.cgPath
        setupTrackLine(track: greenTrack)
        
        view.layer.addSublayer(greenTrack)
    }
    
    fileprivate func setupTrackLine(track:CAShapeLayer) {
        let line = CAShapeLayer()
        line.lineCap = kCALineCapRound
        line.strokeColor = UIColor.white.cgColor
        line.lineDashPattern = [1,5] // 第一个数值代表虚线宽度，第二个数值代表间隔
        line.lineWidth = 2
        line.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        line.path = track.path
        track.addSublayer(line)
    }
}

// MARK: - 公式
extension Demo0Controller {
    // MARK: 线段某点的y值
    fileprivate func calculateLineY(x:CGFloat,startP:CGPoint,endP:CGPoint) -> CGFloat {
        /** 两点式
         
         (y-y2)/(y1-y2) = (x-x2)/(x1-x2)
         */
        return (x - endP.x) / (startP.x - endP.x) * (startP.y - endP.y) + endP.y
    }
    
    fileprivate func calculateLineX(y:CGFloat,startP:CGPoint,endP:CGPoint) -> CGFloat {
        return (y - endP.y) / (startP.y - endP.y) * (startP.x - endP.x) + endP.x
    }
}





