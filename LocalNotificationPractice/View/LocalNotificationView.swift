//
//  LocalNotificationView.swift
//  LocalNotificationPractice
//
//  Created by Seungchul Ha on 2023/02/10.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
	
	static let instance = NotificationManager() // Singleton
	
	// MARK: Request Notification Permission
	func requestAuthorization() {
		
		let options: UNAuthorizationOptions = [.alert, .sound, .badge]
		
		UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
			if let error = error {
				print("ERROR: \(error.localizedDescription)")
			} else {
				print("SUCCESS")
			}
		}
	}
	
	func scheduleNotification() {
		
		let content = UNMutableNotificationContent() // Edible content for notification
		content.title = "This is my first notification!"
		content.subtitle = "This was soooo Easy!"
		content.sound = .default // Alarm Sound
		content.badge = 1 // the number to apply to the apps icon
		
		/// Important: Notification will not ring and pop up if the app is running ,
		/// therefore, minimize or close app if you want to check whether notification is working or not
		
		// Trigger Type
		// time
//		let unrepeatTimetrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false) // One time
		
		// when repeats is true, timeInterval must be more than 60 seconds
		let repeatTimeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 60.0, repeats: true) // Repeat
		
		// calendar
//		var dateComponents = DateComponents()
//		dateComponents.hour = 1
//		dateComponents.minute = 28 // Everyday 1:26, notification will be popped up
//		dateComponents.weekday = 6 // 1 = Sun , 2 = Mon , 3 = Tue, 4 = Wed, 5 = Thu, 6 = Fri, 7 = Sat
//		let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
		
		// location
//		let coordinates = CLLocationCoordinate2D(
//			latitude: 37.477000007897125,
//			longitude: 126.98757526059052)
//
//		let region = CLCircularRegion(
//			center: coordinates,
//			radius: 100,
//			identifier: UUID().uuidString)
//
//		region.notifyOnEntry = true
//		region.notifyOnExit = false
//
//		let locationTrigger = UNLocationNotificationTrigger(region: region, repeats: true)
		
		let request = UNNotificationRequest(
			identifier: UUID().uuidString,
			content: content,
			trigger: repeatTimeTrigger)
		
		UNUserNotificationCenter.current().add(request)
	}
	
	func cancelNotification() {
		UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // Cancel Upcoming Notification
		UNUserNotificationCenter.current().removeAllDeliveredNotifications() // Remove Notifications Which are Already Delivered
		UIApplication.shared.applicationIconBadgeNumber = 0
	}
	
}

struct LocalNotificationView: View {
    var body: some View {
		VStack(spacing: 40) {
			Button("Request Permission") {
				NotificationManager.instance.requestAuthorization()
			}
			
			Button("Schedule Notification") {
				NotificationManager.instance.scheduleNotification()
			}
			
			Button("Cancel Notification") {
				NotificationManager.instance.cancelNotification()
			}
		}
		.onAppear {
			// When Run App, Badge on App Icon will be disappeared
			UIApplication.shared.applicationIconBadgeNumber = 0
		}
    }
}

struct LocalNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationView()
    }
}
