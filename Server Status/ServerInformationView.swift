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
        
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let scrollView = UIScrollView()
    
    
    let scroll : UIView = {
        let v = UIView()
        
        let serverVersion = BarChartView(frame: .init(x: 0, y: 0, width: 0, height: 0), title: "Server Version", content: tempStatus.version)
        let startupDuration = BarChartView(frame: .init(x: 0, y: 0, width: v.frame.width, height: 140), title: "Startup duration", content: convertLongToTime(tempStatus.startupDuration))
        let eventQueue = BarChartView(frame: .zero, title: "Events Queue Length", content: "\(tempStatus.eventQueueLength)")
        let installationDate = BarChartView(frame: .zero, title: "Installation Date", content: convertDate(tempStatus.installationDate))
        let startDate = BarChartView(frame: .zero, title: "Start Time", content: convertDate(tempStatus.startTime))
        let uptime = BarChartView(frame: .zero, title: "Uptime", content: convertLongToTime(tempStatus.uptime))
        let freeMemory = BarChartView(frame: .zero, title: "Free memory in the JVM", content: convertLongToByte(tempStatus.freeMemory))
        let maxMemory = BarChartView(frame: .zero, title: "Max memory for the JVM", content: convertLongToByte(tempStatus.maxMemory))
        let totalMemory = BarChartView(frame: .zero, title: "Total memory used by the JVM", content: convertLongToByte(tempStatus.totalMemory))
        let cpuLoad = DonutChartView(frame: .zero, title: "CPU Load by JVM", value: tempStatus.cpuLoad)
        let cpuLoadSystem = DonutChartView(frame: .zero, title: "CPU Load", value: tempStatus.cpuLoadSystem)
        let eventsScheduled = BarChartView(frame: .zero, title: "Events Scheduled", content: "\(tempStatus.eventsScheduled)")
        let eventsProcessed = BarChartView(frame: .zero, title: "Events Processed", content: "\(tempStatus.eventsProcessed)")
        let diskUtilil = DonutChartView(frame: .zero, title: "Disk Utilisation", value: tempStatus.diskUtilization[0].diskUtilizationSpace)
       
        
        
        v.addSubview(serverVersion)
        serverVersion.anchor(top: v.topAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 140))
        
        v.addSubview(installationDate)
        installationDate.anchor(top: serverVersion.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 140))

        v.addSubview(startDate)
        startDate.anchor(top: installationDate.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 140))

        v.addSubview(startupDuration)
        startupDuration.anchor(top: startDate.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 140))

        v.addSubview(uptime)
        uptime.anchor(top: startupDuration.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 140))

        v.addSubview(freeMemory)
        freeMemory.anchor(top: uptime.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 140))

        v.addSubview(maxMemory)
        maxMemory.anchor(top: freeMemory.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 140))

        v.addSubview(totalMemory)
        totalMemory.anchor(top: maxMemory.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 140))

        v.addSubview(eventQueue)
        eventQueue.anchor(top: totalMemory.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 140))

        v.addSubview(cpuLoad)
        cpuLoad.anchor(top: eventQueue.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 332))

        v.addSubview(cpuLoadSystem)
        cpuLoadSystem.anchor(top: cpuLoad.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 332))
        
        v.addSubview(eventsScheduled)
        eventsScheduled.anchor(top: cpuLoadSystem.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 140))
        
        v.addSubview(eventsProcessed)
        eventsProcessed.anchor(top: eventsScheduled.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 140))
        
        v.addSubview(diskUtilil)
        diskUtilil.anchor(top: eventsProcessed.bottomAnchor, leading: v.leadingAnchor, bottom: nil, trailing: v.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 332))
        
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(customNavBar)
        customNavBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        customNavBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1674).isActive = true
        
        print(view.frame.height)
        
        scrollView.contentSize.height = 3000
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(scroll)
        scroll.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scroll.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        scroll.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = customNavBar.bounds
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}

}

func convertLongToTime (_ content: Int) -> String {
    let seconds : Int = content/1000 % 60
    let minutes : Int = content/1000 / 60
    let hours : Int = content/1000 / 60 / 60
    
    switch hours {
    case 0:
        return "\(minutes) Min \(seconds) Sec"
    default:
        return "\(hours) Hr \(minutes % 60) Min \(seconds) Sec"
    }
}

func convertDate (_ content: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm:ss.zzz"
    let date = dateFormatter.date(from: content)
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy' 'HH:mm:ss"
    
    return formatter.string(from: date!)
}

func convertLongToByte (_ value : Int) -> String {
    
    let content : Double = Double(value/1024/1024)
    if content < 1024 {
        return "\(round(content*10)/10) MB"
    }
    else {
        return "\(round(content*10/1024)/10) GB"
    }
}
