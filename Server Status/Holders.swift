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
            let value = UILabel(text: content!, font: .systemFont(ofSize: 48, weight: .bold), textColor: .gray, textAlignment: .center)
            addSubview(value)
            value.anchor(top: blockTitle.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 0, bottom: 24, right: 0))
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
