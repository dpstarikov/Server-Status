//
//  ServerInformationView.swift
//  Server Status
//
//  Created by Дмитрий Стариков on 17/07/2019.
//  Copyright © 2019 dmitrystar. All rights reserved.
//

import UIKit

class ServerInformationView: UIViewController {
    
    let gradientLayer = CAGradientLayer()
    lazy var customNavBar : UIView = {
        let v = UIView()
        gradientLayer.colors = [
            #colorLiteral(red: 0.1938629746, green: 0.6131367087, blue: 0.8643187881, alpha: 1).cgColor, #colorLiteral(red: 0.271910429, green: 0.3255732059, blue: 0.8209788799, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        v.layer.addSublayer(gradientLayer)
        
        let labelContainer = UILabel(text: tempStatus.name, font: .boldSystemFont(ofSize: 32), textColor: .white)
        v.addSubview(labelContainer)
        labelContainer.anchor(top: nil, leading: v.leadingAnchor, bottom: v.bottomAnchor, trailing: v.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 8, right: 0))
        v.setupShadow(opacity: 0.4, radius: 8, offset: .init(width: 0, height: 5), color: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
        
        return v
    }()
    
    let startupDuration = BarChartView(frame: .zero, blockTitle: .init(text: "Startup duration", font: .systemFont(ofSize: 18, weight: .semibold), textColor: .black), value: .init(text: "\(tempStatus.startupDuration)", font: .systemFont(ofSize: 48, weight: .bold), textColor: .gray, textAlignment: .center))
    let eventQueue = BarChartView(frame: .zero, blockTitle: .init(text: "Events", font: .systemFont(ofSize: 18, weight: .semibold), textColor: .black), value: .init(text: "\(tempStatus.eventQueueLength)", font: .systemFont(ofSize: 48, weight: .bold), textColor: .gray, textAlignment: .center))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        
        view.addSubview(startupDuration)
        startupDuration.anchor(top: customNavBar.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 140))
        
        view.addSubview(eventQueue)
        eventQueue.anchor(top: startupDuration.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 200))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = customNavBar.bounds
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}

}


