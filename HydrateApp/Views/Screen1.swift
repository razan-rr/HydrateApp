//
//  ContentView.swift
//  HydrateApp
//
//  Created by Razan on 25/04/1446 AH.
//

import SwiftUI
 
 struct ContentView: View {
     
    @StateObject private var waterModel = WaterIntakeModel()
    @State private var bodyWeight: String = ""
    
    
     var body: some View {
        
         NavigationStack{
              
             VStack(alignment:.leading,spacing:20) {
                 
                 Spacer()
                 Spacer()
                  
                 Image(systemName: "drop.fill")
                     .frame(width:50)
                     .font(.system(size: 56))
                     .foregroundColor(.blue1)
                 
                 Text("Hydrate")
                     .frame(width:95)
                     .font(.system(size:22))
                     .bold()
                 
                 Text("Start with Hydrate to record and track water intake daily based on your needs and stay hydrated")
                     .frame(width:355)
                     .font(.system(size:17))
                     .foregroundColor(.grey1)
                 
                 
                 HStack{
                     
                     
                     Text("Body weight")
                     
                     TextField("Value", text: $bodyWeight)
                         .keyboardType(.numberPad)
                         .onChange(of: bodyWeight) { newValue in
                                 waterModel.calculateWaterIntake(weight: Double(newValue) ?? 0)
                             }
                     
                     Button(action: {
                         bodyWeight = ""
                         waterModel.calculateWaterIntake(weight: Double(bodyWeight) ?? 0)
                     
                     }) {
                         Image(systemName: "xmark.circle.fill")
                             .foregroundColor(.gray)
                         
                     }
                     
                 }//HStack
                 .padding(8)
                 .background(Color.system1)
                 .frame(width:355,height:44)
                 
                 
                 
                 Spacer().frame(height:290)
                 
                 VStack{
                     
                     
                    
                     Button(action:{
                         waterModel.calculateWaterIntake(weight: Double(bodyWeight) ?? 0)
                         
                        
                         
                     })  {
                         NavigationLink(destination: Screen2().environmentObject(waterModel)){
                             Text("Next")
                                 .foregroundColor(.white)
                                 .frame(width: 355, height: 50)
                                 .background(bodyWeight.isEmpty ? Color.gray :  Color.blue1)
                                 .cornerRadius(10)
                         }
                     }
                     .disabled(bodyWeight.isEmpty)
                    
                   
                 }
                 Spacer()
                 
             }//VStack
             .navigationBarBackButtonHidden(true)

         }//navigationlink
         .environmentObject(waterModel)
    }//body
    
    
    private func calculateWaterIntake() {
        let weight = Double(bodyWeight) ?? 0
        waterModel.totalWaterIntake = weight * 0.033
      
    }
    
    
}//struct

#Preview {
    ContentView()
        .environmentObject(WaterIntakeModel())
}
