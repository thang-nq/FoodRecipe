//
//  DateTimeFormat.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 16/09/2023.
//

import Foundation
import FirebaseFirestore
func formatTimestamp(_ timestamp: Timestamp) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss" // Customize the format
    dateFormatter.timeZone = TimeZone.current // Use the device's current time zone

    let date = timestamp.dateValue()
    return dateFormatter.string(from: date)
}
