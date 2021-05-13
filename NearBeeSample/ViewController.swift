//
//  ViewController.swift
//  NearBeeSample
//
//  Created by Sourobrata Sarkar on 30/03/21.
//

import UIKit
import NearBee
import CoreData
import UserNotifications
import CoreLocation
import Imaginary

class ViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    
    var nearBee: NearBee!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.requestAlwaysAuthorization()
        UNUserNotificationCenter.current().delegate = self
        
        if nearBee != nil {
            print("found")
        } else {
            print("not found")
        }
        nearBee = NearBee.initNearBee()
        nearBee.delegate = self
        nearBee.enableBackgroundNotification(true)
        
        nearBee.stopMonitoringGeoFenceRegions()
        nearBee.startScanning()
        nearBee.startMonitoringGeoFenceRegions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nearBee.delegate = self
    }
}

extension ViewController: NearBeeDelegate {
     // Callback for geofence enter event
    func didEnterGeofence(_ geofence: NearBeeGeoFence, _ attachment: GeoFenceAttachment) {
        NSLog("DemoApp: Geofence entered: \(geofence.id) - \(String(describing: attachment.getTitle()))")
    }
    
    func didFindBeacons(_ beacons: [NearBeeBeacon]) {
        print("did find beacon")
        NSLog("DemoApp: Beacon found: \(beacons.count)")
        }
        
        func didLoseBeacons(_ beacons: [NearBeeBeacon]) {
            print("did lose beacon")
            NSLog("DemoApp: Beacons lost")
        }
        
        func didUpdateBeacons(_ beacons: [NearBeeBeacon]) {
            print("did update beacon")
            NSLog("DemoApp: Beacon updated: \(beacons.count)")
        }
    
    func didThrowError(_ error: Error) {
    }
    
    func didUpdateState(_ state: NearBeeState) {
    }
}


extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let _ = nearBee.checkAndProcessNearbyNotification(response.notification)
        completionHandler()
    }
}

