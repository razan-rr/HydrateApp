//
//  WaterIntake.swift
//  HydrateApp
//
//  Created by Razan on 25/04/1446 AH.
//

import Foundation

struct WaterIntake {
    var totalWaterIntake: Double
    var currentIntake: Double

    // Initialize the water intake model with 0 values
    init(totalWaterIntake: Double = 0.0, currentIntake: Double = 0.0) {
        self.totalWaterIntake = totalWaterIntake
        self.currentIntake = currentIntake
    }

    // Calculate the total water intake based on body weight
    static func calculateTotalWaterIntake(for weight: Double) -> Double {
        return weight * 0.033  // 33 ml per kg of body weight
    }

    // Check if the user has reached their goal
    func hasReachedGoal() -> Bool {
        return currentIntake >= totalWaterIntake
    }

    // Calculate remaining intake needed to reach the goal
    func remainingIntake() -> Double {
        return max(totalWaterIntake - currentIntake, 0.0)
    }
}
