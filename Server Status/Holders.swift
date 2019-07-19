//
//  Holders.swift
//  Server Status
//
//  Created by Дмитрий Стариков on 19/07/2019.
//  Copyright © 2019 dmitrystar. All rights reserved.
//

import UIKit

class BarChartView: UIView {
    let blockTitle = UILabel()
    let value = UILabel()
    
    init(frame: CGRect, blockTitle: UILabel, value: UILabel?) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 8
        
        setupShadow(opacity: 0.05, radius: 8, offset: .init(width: 0, height: 12), color: .black)
        
        addSubview(blockTitle)
        blockTitle.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 0))
        
        if value != nil {
            addSubview(value!)
            value!.anchor(top: blockTitle.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 16, right: 0))
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
