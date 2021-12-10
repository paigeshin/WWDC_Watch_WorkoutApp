//
//  SessionPagingView.swift
//  WWDC_WatchApp WatchKit Extension
//
//  Created by paige on 2021/12/11.
//

import SwiftUI
import WatchKit

// MARK: - TABVIEW WITH ENUM 
struct SessionPagingView: View {
    
    //MARK: isLuminanceReduced
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    /*
     .tabViewStyle(
         PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic)
     )
     .onChange(of: isLuminanceReduced) { _ in
         dispayMetricsView()
     }
     */
    
    @EnvironmentObject private var workoutManager: WorkoutManager
    @State private var selection: Tab = .metrics
    
    enum Tab {
        case controls, metrics, nowPlaying
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ControlsView().tag(Tab.controls)
            MetricsView().tag(Tab.metrics)
            // MARK: NowPlayingView is provided by WatchKit
            NowPlayingView().tag(Tab.nowPlaying)
        }
        .navigationTitle(workoutManager.selectedWorkout?.name ?? "")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(selection == .nowPlaying)
        .onChange(of: workoutManager.running) { _ in
            dispayMetricsView()
        }
        .tabViewStyle(
            PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic)
        )
        .onChange(of: isLuminanceReduced) { _ in
            dispayMetricsView()
        }
    }
    
    private func dispayMetricsView() {
        withAnimation {
            selection = .metrics
        }
    }
}

struct SessionPagingView_Previews: PreviewProvider {
    static var previews: some View {
        SessionPagingView()
    }
}
