//
//  ElapsedTimeView.swift
//  WWDC_WatchApp WatchKit Extension
//
//  Created by paige on 2021/12/11.
//

import SwiftUI

struct ElapsedTimeView: View {
    
    var elapsedTime: TimeInterval = 0
    var showSubseconds = true
    @State private var timeFormatter = ElapsedTimeFormatter()
    
    var body: some View {
        Text(
            NSNumber(value: elapsedTime),
            formatter: timeFormatter
        ) // TEXT - ELAPSED TIME
            .fontWeight(.semibold)
            .onChange(of: showSubseconds) {
                timeFormatter.showSubseconds = $0
            }
    }
}

// MARK: Elasped Time Formatter
class ElapsedTimeFormatter: Formatter {
    
    // MARK: CUSTOM FORMATTER
    let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        /*
         The add padding zeroes behavior. This behavior pads values with zeroes as appropriate. For example, consider the value of one hour formatted using the positional and abbreviated unit styles. When days, hours, minutes, and seconds are allowed, the value is displayed as “0d 1:00:00” using the positional style, and as “0d 1h 0m 0s” using the abbreviated style.
         */
        /*
         How to use
         Text(
             NSNumber(value: elapsedTime),
             formatter: timeFormatter
         ) // TEXT - ELAPSED TIME
             .fontWeight(.semibold)
             .onChange(of: showSubseconds) {
                 timeFormatter.showSubseconds = $0
             }
         */
        return formatter
    }() // Custom Formatter, show minute & second, subseconds are hsown
    var showSubseconds = true
    
    override func string(for value: Any?) -> String? {
        guard let time = value as? TimeInterval else {
            return nil
        }
        
        guard let formattedString = componentsFormatter.string(from: time) else {
            return nil
        }
        
        if showSubseconds {
            // Calculate subseconds
            let hundredths = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
            let decimalSeparator = Locale.current.decimalSeparator ?? "."
            return String(format: "%@%@%0.2d", formattedString, decimalSeparator, hundredths)
        }
        
        return formattedString
    }
    
}

struct ElapsedTimeView_Previews: PreviewProvider {
    static var previews: some View {
        ElapsedTimeView()
    }
}
