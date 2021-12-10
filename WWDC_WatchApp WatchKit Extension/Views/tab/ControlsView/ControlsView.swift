//
//  ControlsView.swift
//  WWDC_WatchApp WatchKit Extension
//
//  Created by paige on 2021/12/11.
//

import SwiftUI

struct ControlsView: View {
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        HStack {
            
            VStack {
                Button {
                    workoutManager.endWorkout()
                } label: {
                    Image(systemName: "xmark")
                } //: BUTTON
                .tint(.red)
                .font(.title2)
                
                Text("End") //: TEXT

            } //: VSTACK
            
            VStack {
                Button {
                    workoutManager.togglePuase()
                } label: {
                    Image(systemName: workoutManager.running ? "pause" : "play")
                } //: BUTTON
                .tint(.yellow)
                .font(.title2)
                Text("Pause")
            } //: VSTACK
            
        } //: HSTACK
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView()
    }
}
