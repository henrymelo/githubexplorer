//
//  LocationService.swift
//  GitHub Explorer
//
//  Created by Henrique Melo on 01/05/2025.
//  Copyright © 2025 Henrique Melo. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class LocationService: NSObject, CLLocationManagerDelegate {
    static let shared = LocationService()
    private let locationManager = CLLocationManager()

    func requestLocationAndApplySeasonIcon() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let latitude = location.coordinate.latitude
        let isNorthern = latitude >= 0

        let month = Calendar.current.component(.month, from: Date())
        var iconName: String?

        switch month {
        case 3...5:
            iconName = isNorthern ? "SpringIcon" : "AutumnIcon"
        case 6...8:
            iconName = isNorthern ? "SummerIcon" : "WinterIcon"
        case 9...11:
            iconName = isNorthern ? "AutumnIcon" : "SpringIcon"
        default:
            iconName = isNorthern ? "WinterIcon" : "SummerIcon"
        }

        if UIApplication.shared.alternateIconName != iconName {
            UIApplication.shared.setAlternateIconName(iconName) { error in
                if let error = error {
                    print("Erro ao trocar ícone: \(error.localizedDescription)")
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Erro ao obter localização: \(error.localizedDescription)")
    }
}
