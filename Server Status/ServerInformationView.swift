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
    
    let scrollView : UIScrollView = {
        let v = UIScrollView()
        
        
        return v
    }()
    
    lazy var scroll : UIView = { //change to stackview?
        let v = UIView()

        let serverVersion = BarChartView(frame: v.bounds, title: "Server Version", content: tempStatus.version)
        let startupDuration = BarChartView(frame: .zero, title: "Startup duration", content: convertLongToTime(tempStatus.startupDuration))
        let eventQueue = BarChartView(frame: .zero, title: "Events Queue Length", content: "\(tempStatus.eventQueueLength)")
        let installationDate = BarChartView(frame: .zero, title: "Installation Date", content: convertDate(tempStatus.installationDate))
        let startDate = BarChartView(frame: .zero, title: "Start Time", content: convertDate(tempStatus.startTime))
        let uptime = BarChartView(frame: .zero, title: "Uptime", content: convertLongToTime(tempStatus.uptime))
        let freeMemory = BarChartView(frame: .zero, title: "Free memory in the JVM", content: convertLongToByte(tempStatus.freeMemory))
        let maxMemory = BarChartView(frame: .zero, title: "Max memory for the JVM", content: convertLongToByte(tempStatus.maxMemory))
        let totalMemory = BarChartView(frame: .zero, title: "Total memory used by the JVM", content: convertLongToByte(tempStatus.totalMemory))
        
        let cpuLoad = DonutChartView(frame: .zero, title: "CPU Load", value: tempStatus.cpuLoad)
        let cpuLoadSystem = DonutChartView(frame: .zero, title: "CPU Load System", value: tempStatus.cpuLoadSystem)
        
        v.addSubview(serverVersion)
        serverVersion.translatesAutoresizingMaskIntoConstraints = false
        
        serverVersion.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        serverVersion.topAnchor.constraint(equalTo: v.topAnchor, constant: 32).isActive = true
        serverVersion.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 16).isActive = true
        serverVersion.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: 16).isActive = true
    //    serverVersion.heightAnchor.constraint(equalToConstant: 140).isActive = true
    //    serverVersion.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        v.addSubview(installationDate)
        installationDate.translatesAutoresizingMaskIntoConstraints  = false
        
        installationDate.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        installationDate.topAnchor.constraint(equalTo: serverVersion.bottomAnchor, constant: 32).isActive = true
        installationDate.heightAnchor.constraint(equalToConstant: 140).isActive = true
        installationDate.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        v.addSubview(startDate)
        startDate.translatesAutoresizingMaskIntoConstraints = false
        
        startDate.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        startDate.topAnchor.constraint(equalTo: installationDate.bottomAnchor, constant: 32).isActive = true
        startDate.heightAnchor.constraint(equalToConstant: 140).isActive = true
        startDate.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        
        v.addSubview(startupDuration)
        startupDuration.translatesAutoresizingMaskIntoConstraints = false
        
        startupDuration.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        startupDuration.topAnchor.constraint(equalTo: startDate.bottomAnchor, constant: 32).isActive = true
        startupDuration.heightAnchor.constraint(equalToConstant: 140).isActive = true
        startupDuration.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        v.addSubview(uptime)
        uptime.translatesAutoresizingMaskIntoConstraints = false
        
        uptime.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        uptime.topAnchor.constraint(equalTo: startupDuration.bottomAnchor, constant: 32).isActive = true
        uptime.heightAnchor.constraint(equalToConstant: 140).isActive = true
        uptime.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        v.addSubview(freeMemory)
        freeMemory.translatesAutoresizingMaskIntoConstraints = false
        
        freeMemory.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        freeMemory.topAnchor.constraint(equalTo: uptime.bottomAnchor, constant: 32).isActive = true
        freeMemory.heightAnchor.constraint(equalToConstant: 140).isActive = true
        freeMemory.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        v.addSubview(maxMemory)
        maxMemory.translatesAutoresizingMaskIntoConstraints = false
        
        maxMemory.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        maxMemory.topAnchor.constraint(equalTo: freeMemory.bottomAnchor, constant: 32).isActive = true
        maxMemory.heightAnchor.constraint(equalToConstant: 140).isActive = true
        maxMemory.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        v.addSubview(totalMemory)
        totalMemory.translatesAutoresizingMaskIntoConstraints = false
        
        totalMemory.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        totalMemory.topAnchor.constraint(equalTo: maxMemory.bottomAnchor, constant: 32).isActive = true
        totalMemory.heightAnchor.constraint(equalToConstant: 140).isActive = true
        totalMemory.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        v.addSubview(eventQueue)
        eventQueue.translatesAutoresizingMaskIntoConstraints = false
        
        eventQueue.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        eventQueue.topAnchor.constraint(equalTo: totalMemory.bottomAnchor, constant: 32).isActive = true
        eventQueue.heightAnchor.constraint(equalToConstant: 140).isActive = true
        eventQueue.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        v.addSubview(cpuLoad)
        cpuLoad.translatesAutoresizingMaskIntoConstraints = false
        
        cpuLoad.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        cpuLoad.topAnchor.constraint(equalTo: eventQueue.bottomAnchor, constant: 32).isActive = true
        cpuLoad.heightAnchor.constraint(equalToConstant: 332).isActive = true
        cpuLoad.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        v.addSubview(cpuLoadSystem)
        cpuLoadSystem.translatesAutoresizingMaskIntoConstraints = false
        
        cpuLoadSystem.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
        cpuLoadSystem.topAnchor.constraint(equalTo: cpuLoad.bottomAnchor, constant: 32).isActive = true
        cpuLoadSystem.heightAnchor.constraint(equalToConstant: 332).isActive = true
        cpuLoadSystem.widthAnchor.constraint(equalToConstant: 382).isActive = true
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(customNavBar)
        customNavBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 150))
        
    /*    view.addSubview(scroll)
        scroll.anchor(top: customNavBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor) */
        
        view.addSubview(scrollView)
        scrollView.contentSize.height = 2500
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.backgroundColor = .yellow
        scrollView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scroll.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        scroll.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = customNavBar.bounds
        scroll.frame = scrollView.bounds
        print(scrollView.bounds)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    
    
    override func viewWillAppear(_ animated: Bool) {
    }

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






