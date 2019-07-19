//
//  AuthModel.swift
//  Server Status
//
//  Created by Дмитрий Стариков on 10/07/2019.
//  Copyright © 2019 dmitrystar. All rights reserved.
//

import UIKit

struct Credimentals:Decodable {
    let token : String
}

// MARK: - ServerElement
struct ServerElement: Codable {
    let startupDuration, eventQueueLength: Int
    let installationDate, version: String
    let maxMemory, uptime: Int
    let cpuLoad: Double
    let totalMemory, eventsProcessed: Int
    let name: String
    let cpuLoadSystem: Double
    let startTime: String
    let eventsScheduled, freeMemory: Int
    let diskUtilization: [DiskUtilization]
}

// MARK: - DiskUtilization
struct DiskUtilization: Codable {
    let diskUtilizationName: String
    let diskUtilizationSpace: Double
}

typealias Server = [ServerElement]
