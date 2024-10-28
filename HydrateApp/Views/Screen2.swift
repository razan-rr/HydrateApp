//
//  Screen2.swift
//  HydrateApp
//
//  Created by Razan on 25/04/1446 AH.
//

import UserNotifications
import SwiftUI

struct Screen2: View {
    @EnvironmentObject var waterModel : WaterIntakeModel
    @State private var startHour = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        .components(separatedBy: ":")[0] + ":00"
    @State private var startPeriod = Calendar.current.component(.hour, from: Date()) < 12 ? "AM" : "PM"
    @State private var endHour = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        .components(separatedBy: ":")[0] + ":00"
    @State private var endPeriod = Calendar.current.component(.hour, from: Date()) < 12 ? "AM" : "PM"
    @State private var selectedOption = "15 Mins"
    private let options = [
        ["15 Mins", "30 Mins", "60 Mins", "90 Mins"],
        ["2 Hours", "3 Hours", "4 Hours", "5 Hours"]
    ]
    private let times = (1...12).flatMap { hour in
        (0...45).filter { $0 % 15 == 0 }.map { "\(hour):\(String(format: "%02d", $0))" }
    }+["12:00"]
    
    var body: some View {
        
        NavigationStack{
            VStack(alignment:.leading){//1
                
                
             
               
                Text("Notification Preferences")
                    .padding(.trailing,110)
                    .font(.system(size:22))
                    .bold()
                
                
                Spacer().frame(height:32)
                
                Text("The start and end hour")
                
                    .font(.system(size:17))
                    .bold()
                
                Spacer().frame(height:8)
                
                Text("Specify the start and end date to receive the notification")
                
                    .font(.system(size:16))
                    .foregroundColor(.grey1)
                
            }//VStack1
            
            
            Spacer().frame(height:32)
            VStack{//2
                
                
                HStack{//1
                    
                    Text("Start hour ")
                        .font(.system(size:17))
                    
                    Spacer().frame(width:30)
                    
                    Picker("Time", selection: $startHour) {
                        ForEach(times, id: \.self, content: Text.init)
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100, height: 50)
                    
                    
                    Picker("", selection: $startPeriod) {
                        ForEach(["AM", "PM"], id: \.self, content: Text.init)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 120)
                }//HStack1
                Divider().frame(width:300)
                Spacer().frame(height:-16)
                
                
                HStack{
                    Text("End hour  ")
                        .font(.system(size:17))
                    
                    Spacer().frame(width:30)
                    
                    Picker("Time", selection: $endHour) {
                        ForEach(times, id: \.self, content: Text.init)
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100, height: 50)
                    
                    
                    Picker("", selection: $endPeriod) {
                        ForEach(["AM", "PM"], id: \.self, content: Text.init)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 120)
                }
                
                
            }//VStack2
            .frame(width:355,height:108)
            .background(Color.system1)
            
            Spacer().frame(height:40)
            
            VStack(){//3
                
                Text("Notification interval")
                    .padding(.trailing,190)
                    .font(.system(size:17))
                    .bold()
                Spacer().frame(height:8)
                Text("How often would you like to receive notificatons \nwithin the specified time interval")
                    .padding(.trailing,70)
                    .foregroundColor(.grey1)
                    .font(.caption)
            }//VStack3
            
            Spacer().frame(height:21)
            
            VStack(spacing: 16) {//4
                ForEach(options, id: \.self) { row in
                    HStack(spacing: 16) {
                        ForEach(row, id: \.self) { option in
                            VStack {
                                Text(option.split(separator: " ")[0])
                                    .foregroundColor(selectedOption == option ? .white : .blue1)
                                Text(option.split(separator: " ")[1])
                                    .foregroundColor(selectedOption == option ? .white : .black)
                            }
                            .frame(width: 77, height: 70)
                            .background(selectedOption == option ? Color.blue1 : Color(.system1))
                            .cornerRadius(10)
                            .onTapGesture { selectedOption = option }
                        }
                    }
                }
            }//VStack4
            
            Spacer().frame(height:90)
         
            
            NavigationLink(destination: Screen3().environmentObject(waterModel)){
                        Text("Start")
                            .foregroundColor(.white)
                            .frame(width: 355, height: 50)
                            .background(Color.blue1)
                            .cornerRadius(10)
                    }
            .onTapGesture {
                requestNotificationPermission()
                scheduleNotification()
            }
                
                
                
            
        }.navigationBarBackButtonHidden(true)

    }
    
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Permission denied: \(error.localizedDescription)")
            }
        }
    }
    
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Time to Hydrate!"
        content.body = "Stay on track with your hydration goal!"
        content.sound = .default

        // Convert user’s input into seconds
        let interval = selectedOption.contains("Mins") ?
                       (Int(selectedOption.split(separator: " ")[0]) ?? 15) * 60 :
                       (Int(selectedOption.split(separator: " ")[0]) ?? 1) * 3600

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(interval), repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for every \(selectedOption).")
            }
        }
    }
    
}

#Preview {
    Screen2()
        .environmentObject(WaterIntakeModel())
}
