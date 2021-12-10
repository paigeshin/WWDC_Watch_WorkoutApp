//
//  MetricsView.swift
//  WWDC_WatchApp WatchKit Extension
//
//  Created by paige on 2021/12/11.
//

import SwiftUI

struct MetricsView: View {
    
    @EnvironmentObject private var workoutManager: WorkoutManager
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                
                // MARK: TIMELINE VIEW, Timer
                TimelineView(
                    MetricsTimelinesSchedule(from: workoutManager.builder?.startDate ?? Date())) { context in
                        VStack(alignment: .leading) {
                            ElapsedTimeView(
                                elapsedTime: workoutManager.builder?.elapsedTime ?? 0,
                                showSubseconds: context.cadence == .live
                            )
                            .foregroundColor(.yellow)
    //                        Text(
    //                            Measurement(
    //
    //                            )
    //                        )
                        }
                    } //TimelineView

                    
                // MARK: - MEASUREMENT
                Text(
                    Measurement(
                        value: workoutManager.activeEnergy,
                        unit: UnitEnergy.kilocalories
                    )
                    .formatted(
                        .measurement(width: .abbreviated,
                                     usage: .workout,
                                     numberFormatStyle:
                                        FloatingPointFormatStyle
                                        .number
                                        .precision(
                                            .fractionLength(0)
                                        )
                                    )
                    )
                ) // CALORIES TEXT
                
                Text(
                    workoutManager.heartRate
                    .formatted(
                        .number
                        .precision(
                            .fractionLength(0)
                        )
                    )
                    +
                    " bpm"
                ) // BPM TEXT
                
                Text(
                    Measurement(
                        value: workoutManager.distance,
                        unit: UnitLength.meters
                    )
                    .formatted(
                        .measurement(width: .abbreviated,
                                     usage: .road)
                    )
                ) // ROAD TEXT
                
            } //: VSTACK - PAGE WRAPPER
        } //: SCROLLVIEW
        .font(
            .system(.title, design: .rounded)
                .monospacedDigit()
                .lowercaseSmallCaps()
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea(edges: .bottom)
        .scenePadding()
    }
}

struct MetricsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricsView()
    }
}

// MARK: TIMELINE SCHEDULE FOR TIMER 
private struct MetricsTimelinesSchedule: TimelineSchedule {
    
    var startDate: Date
    init(from startDate: Date) {
        self.startDate = startDate
    }
    
    func entries(from startDate: Date, mode: TimelineScheduleMode) -> PeriodicTimelineSchedule.Entries {
        PeriodicTimelineSchedule(
            from: self.startDate,
            by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0)
        )
            .entries(
                from: startDate,
                mode: mode
            )
    }
    
}
