//
//  Screen3.swift
//  HydrateApp
//
//  Created by Razan on 25/04/1446 AH.
//

import UserNotifications
import SwiftUI

struct Screen3: View {
    @EnvironmentObject var waterModel : WaterIntakeModel
     
    var body: some View {
        NavigationStack{
            VStack{//1
                VStack{//2
                
                    Text("Today's Water Intake")
                        .padding(.trailing,200)
                        .font(.system(size:16))
                        .foregroundColor(.grey1)
                    
                    Text("\(String(format: "%.1f",  waterModel.waterIntake)) / \(String(format: "%.1f", waterModel.totalWaterIntake)) liter")
                        .padding(.trailing,230)
                        .font(.system(size:22))
                        .bold()
                }//VStack2
                Spacer().frame(height:100)
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 33)
                        .foregroundColor(.gray.opacity(0.3))
                    
                    Circle()
                        .trim(from: 0.0, to: progress)
                        .stroke(style: StrokeStyle(lineWidth: 33, lineCap: .round))
                        .foregroundColor(.blue1)
                        .rotationEffect(.degrees(-90))
                    
                    Image(systemName: currentSymbol)
                        .font(.system(size:76))
                        .foregroundColor(.yellow)
                }
                .frame(width: 300, height: 300)
                .padding()
                
                Spacer().frame(height:77)
                
                Text("\(String(format: "%.1f",  waterModel.waterIntake)) L")
                    .font(.system(size:22))
                    .bold()
                
                Spacer().frame(height:16)
                
                Stepper("", value: $waterModel.waterIntake, in: 0...waterModel.totalWaterIntake, step: 0.5)
                    .padding(.trailing,155)
                
                
            }//VStack1
            .navigationBarBackButtonHidden(true)
             }
        }//body
        
        private var progress: CGFloat {
            waterModel.totalWaterIntake > 0 ? CGFloat(waterModel.waterIntake / waterModel.totalWaterIntake) : 0
        }
        
        private var currentSymbol: String {
            switch progress {
            case 0.0..<0.33: return "zzz"
            case 0.33..<0.66: return "tortoise.fill"
            case 0.66..<1.0: return "hare.fill"
            default: return "hands.clap.fill"
            }
        }
        
        
        private func increaseIntake() {
            let remainingAmount = waterModel.totalWaterIntake - waterModel.waterIntake  // Calculate remaining amount
            if remainingAmount >= 0.5 {
                waterModel.waterIntake += 0.5
                sendMotivationalNotification()
            } else {
                waterModel.waterIntake += remainingAmount
                sendAchievementNotification()
            }
        }
        
        private func decreaseIntake() {
            if waterModel.waterIntake - 0.5 <= 0.0 {
                waterModel.waterIntake = 0.0  // Set to 0.0 directly when it's close to 0
            } else {
                waterModel.waterIntake -= 0.5  // Decrease by 0.5 liters
            }
            
        }
    
    
    private func sendMotivationalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Great job on staying hydrated!"
        content.body = "Keep up the good work. Every sip brings you closer to your health goals."
        content.sound = .default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
   
    
    private func sendAchievementNotification() {
        let content = UNMutableNotificationContent()
        content.title = "You're almost there!"
        content.body = "Just a few more sips to reach today's water goal. You're doing fantastic!"
        content.sound = .default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
    
}

#Preview {
    Screen3()
        .environmentObject(WaterIntakeModel())
}
