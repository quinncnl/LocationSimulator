//
//  LocationSimulatorProtocol.swift
//  LocationSimulator
//
//  Created by Qing Cai on 04/04/2020.
//

import Foundation

public protocol LocationSimulatorProtocol {
    
    func startSimulation()
    func stopSimulation()    

    func setPlaybackSpeed(intervalInMs: Double)
    
}
