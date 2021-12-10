//
//  ActivityRingsView.swift
//  WWDC_WatchApp WatchKit Extension
//
//  Created by paige on 2021/12/11.
//

import Foundation
import HealthKit
import SwiftUI

// MARK: ACTIVITY RINGS VIEW
// How to use
/*
 Text("Activity Rings")
 ActivityRingsView(heatlStore: HKHealthStore())
     .frame(width: 50, height: 50)
 */
struct ActivityRingsView: WKInterfaceObjectRepresentable {

    let heatlStore: HKHealthStore
    
    func makeWKInterfaceObject(context: Context) -> some WKInterfaceObject {
        let activityRingsObject = WKInterfaceActivityRing()
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.era, .year, .month, .day], from: Date())
        components.calendar = calendar
        
        let predicate = HKQuery.predicateForActivitySummary(with: components)
        
        let query = HKActivitySummaryQuery(predicate: predicate) { query, summaries, error in
            DispatchQueue.main.async {
                activityRingsObject.setActivitySummary(summaries?.first, animated: true)
            }
        }
        
        heatlStore.execute(query)

        return activityRingsObject
    }
    
    func updateWKInterfaceObject(_ wkInterfaceObject: WKInterfaceObjectType, context: Context) {
        
    }
    
}
