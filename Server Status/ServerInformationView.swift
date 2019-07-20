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
    
    let startupDuration = BarChartView(frame: .zero, title: "Startup duration", content: "\(tempStatus.startupDuration)")
    let eventQueue = BarChartView(frame: .zero, title: "Events", content: "\(tempStatus.eventQueueLength)")
    let installationDate = BarChartView(frame: .zero, title: "Installation date", content: tempStatus.installationDate)
    
    lazy var scroll : UIScrollView = {
        let v = UIScrollView()
//        v.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        v.contentSize = CGSize(width: 414, height: 2000)
        
        let startupDuration = BarChartView(frame: .zero, title: "Startup duration", content: "\(tempStatus.startupDuration)")
        let eventQueue = BarChartView(frame: .zero, title: "Events", content: "\(tempStatus.eventQueueLength)")
        let installationDate = BarChartView(frame: .zero, title: "Installation date", content: tempStatus.installationDate)
        
        v.addSubview(startupDuration)
        startupDuration.translatesAutoresizingMaskIntoConstraints = false
        
        startupDuration.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        startupDuration.topAnchor.constraint(equalTo: v.topAnchor, constant: 32).isActive = true
        startupDuration.heightAnchor.constraint(equalToConstant: 140).isActive = true
        startupDuration.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        v.addSubview(eventQueue)
        eventQueue.translatesAutoresizingMaskIntoConstraints = false
        
        eventQueue.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        eventQueue.topAnchor.constraint(equalTo: startupDuration.bottomAnchor, constant: 32).isActive = true
        eventQueue.heightAnchor.constraint(equalToConstant: 140).isActive = true
        eventQueue.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        v.addSubview(installationDate)
        installationDate.translatesAutoresizingMaskIntoConstraints  = false
        
        installationDate.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        installationDate.topAnchor.constraint(equalTo: eventQueue.bottomAnchor, constant: 32).isActive = true
        installationDate.heightAnchor.constraint(equalToConstant: 140).isActive = true
        installationDate.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        
        view.addSubview(scroll)
        scroll.anchor(top: customNavBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = customNavBar.bounds
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}

}


