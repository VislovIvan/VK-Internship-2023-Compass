//
//  MotionManager.swift
//  VK Internship Infrastructure 2023
//
//  Created by Ivan Vislov on 09.05.2023.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {

    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    @Published var rotation: Double = 0.0
    
    var motion: CMMotionManager

    init() {
        motion = CMMotionManager()
        motion.deviceMotionUpdateInterval = 1/60
        motion.startDeviceMotionUpdates(to: .main) { (motionData, error) in
            guard error == nil else { return }

            if let motionData = motionData {
                self.pitch = motionData.attitude.pitch
                self.roll = motionData.attitude.roll
                self.rotation = motionData.rotationRate.x
            }
        }
    }
}
