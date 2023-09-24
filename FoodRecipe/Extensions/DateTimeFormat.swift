/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tuan Le
  ID: s3836290
  Created  date: 16/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation
import FirebaseFirestore
func formatTimestamp(_ timestamp: Timestamp) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d, yyyy" // Format for "September 1, 2023"
    dateFormatter.timeZone = TimeZone.current // Use the device's current time zone

    let date = timestamp.dateValue()
    
    // Create a Calendar instance to work with date components
    let calendar = Calendar.current
    let day = calendar.component(.day, from: date)
    
    // Add the appropriate ordinal suffix to the day (e.g., "1st", "2nd", "3rd", "4th", etc.)
    let dayString: String
    switch day {
    case 1, 21, 31:
        dayString = "\(day)st"
    case 2, 22:
        dayString = "\(day)nd"
    case 3, 23:
        dayString = "\(day)rd"
    default:
        dayString = "\(day)th"
    }

    // Format the date string with the day and return it
    return dateFormatter.string(from: date).replacingOccurrences(of: "d", with: dayString)
}
