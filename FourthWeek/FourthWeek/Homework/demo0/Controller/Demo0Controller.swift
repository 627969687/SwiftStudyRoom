//
//  FirstWeekOneController.swift
//  SwiftHomework
//
//  Created by 荣 Jason on 2017/10/15.
//  Copyright © 2017年 荣 Jason. All rights reserved.
//


import UIKit

// 每秒旋转角度 360/6
fileprivate let perSecondAngle:CGFloat = 6
// 每分旋转角度 360/6
fileprivate let perMinuteAngle:CGFloat = 6
// 每时旋转角度 360/12
fileprivate let perHourAngle:CGFloat = 30
// 每分钟小时旋转角度 30/60
fileprivate let perMinuteHourAngle:CGFloat = 0.5

class Demo0Controller: UIViewController {
    fileprivate var clockView:UIImageView!
    fileprivate var secondHand:CALayer!
    fileprivate var minuteHand:CALayer!
    fileprivate var hourHand:CALayer!
    fileprivate var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        timeChange()
        setupEvent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
}

extension Demo0Controller {
    fileprivate func setupUI() {
        view.backgroundColor = UIColor.white
        setupClock()
        setupSecondHand()
        setupMinuteHand()
        setupHourHand()
    }
    
    fileprivate func setupClock() {
        let clock = UIImageView()
        clock.image = #imageLiteral(resourceName: "clock")
        clock.sizeToFit()
        clock.center = view.center
        view.addSubview(clock)
        clockView = clock
    }
    
    fileprivate func setupSecondHand() {
        let second = CALayer()
        second.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 2, height: clockView.height() * 0.5 - 20))
        second.backgroundColor = UIColor.red.cgColor
        second.position = CGPoint(x: clockView.width() * 0.5, y: clockView.height() * 0.5)
        second.anchorPoint = CGPoint(x: 0.5, y: 1)
        clockView.layer.addSublayer(second)
        secondHand = second
    }
    
    fileprivate func setupMinuteHand() {
        let minute = CALayer()
        minute.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 4, height: clockView.height() * 0.5 - 25))
        minute.backgroundColor = UIColor.black.cgColor
        minute.position = CGPoint(x: clockView.width() * 0.5, y: clockView.height() * 0.5)
        minute.anchorPoint = CGPoint(x: 0.5, y: 1)
        clockView.layer.addSublayer(minute)
        minuteHand = minute
    }
    
    fileprivate func setupHourHand() {
        let hour = CALayer()
        hour.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: 8, height: clockView.height() * 0.5 - 35))
        hour.backgroundColor = UIColor.black.cgColor
        hour.position = CGPoint(x: clockView.width() * 0.5, y: clockView.height() * 0.5)
        hour.anchorPoint = CGPoint(x: 0.5, y: 1)
        clockView.layer.addSublayer(hour)
        hourHand = hour
    }
}

extension Demo0Controller {
    fileprivate func setupEvent() {
        setupTimer()
    }
    
    fileprivate func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeChange), userInfo: nil, repeats: true)
    }
    
    @objc fileprivate func timeChange() {
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.hour,.minute,.second], from: Date())
        guard let second = dateComponent.second else { return }
        guard let minute = dateComponent.minute else { return }
        guard let hour = dateComponent.hour else { return }
        print(String(format: "%d:%d:%d", dateComponent.hour!,dateComponent.minute!,dateComponent.second!))
        
        // 秒
        let secondAngle = perSecondAngle * CGFloat(second)
        secondHand.transform = CATransform3DMakeRotation(angleToRadian(secondAngle), 0, 0, 1)
        // 分
        let minuteAngle = perMinuteAngle * CGFloat(minute)
        minuteHand.transform = CATransform3DMakeRotation(angleToRadian(minuteAngle), 0, 0, 1)
        // 时
        let hourAngle = perHourAngle * CGFloat(hour) + perMinuteHourAngle * CGFloat(minute)
        hourHand.transform = CATransform3DMakeRotation(angleToRadian(hourAngle), 0, 0, 1)
    }
}








