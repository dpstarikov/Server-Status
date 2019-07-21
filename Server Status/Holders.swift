//
//  Holders.swift
//  Server Status
//
//  Created by Дмитрий Стариков on 19/07/2019.
//  Copyright © 2019 dmitrystar. All rights reserved.
//

import UIKit

class BarChartView: UIView {
    
    init(frame: CGRect, title: String, content: String?) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 8
        
        setupShadow(opacity: 0.05, radius: 8, offset: .init(width: 0, height: 12), color: .black)
        
        let blockTitle = UILabel(text: title, font: .systemFont(ofSize: 18, weight: .semibold), textColor: .black)
        
        addSubview(blockTitle)
        blockTitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        
        if content != nil{
            let value = UILabel(text: content!, font: .systemFont(ofSize: 32, weight: .bold), textColor: .gray, textAlignment: .center)
            addSubview(value)
            value.anchor(top: blockTitle.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 32, left: 0, bottom: 24, right: 0))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

class DonutChartView: UIView {
    
    init(frame: CGRect, title: String, value: Double) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 8
        
        setupShadow(opacity: 0.05, radius: 8, offset: .init(width: 0, height: 12), color: .black)
        let blockTitle = UILabel(text: title, font: .systemFont(ofSize: 18, weight: .semibold), textColor: .black)
        
        addSubview(blockTitle)
        blockTitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        
        //MARK: Adding donut diagram
        //tracklayer
        let trackLayer = CAShapeLayer()
        //TODO: repair center property
        let circularPath = UIBezierPath(arcCenter :.init(x: 191, y: 182) , radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(trackLayer)
        
        // data layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        shapeLayer.position = .init(x: 9, y: 373) //WTF?! gonna fix it
        shapeLayer.position = center
        shapeLayer.strokeEnd = CGFloat(value/100) // here is the value devided by 100%
        layer.addSublayer(shapeLayer)
        
        // add value content
        let content = UILabel(text: "\(Int(value))%", font: .systemFont(ofSize: 32, weight: .bold), textColor: .gray, textAlignment: .center)
        addSubview(content)
        content.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
