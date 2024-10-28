//
//  WaterIntakeModel.swift
//  HydrateApp
//
//  Created by Razan on 25/04/1446 AH.
//



import SwiftUI

class WaterIntakeModel: ObservableObject{
    
    @Published var totalWaterIntake: Double = 0.0
    
    @Published var waterIntake: Double = 0.0
    
    func calculateWaterIntake(weight: Double) {
            totalWaterIntake = weight * 0.033  // 33 ml per kg of body weight
            print("Calculated Total Water Intake: \(totalWaterIntake)")
        }
    
}
