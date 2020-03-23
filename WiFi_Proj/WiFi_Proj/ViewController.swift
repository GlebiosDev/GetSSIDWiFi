//
//  ViewController.swift
//  WiFi_Proj
//
//  Created by MacBookPro on 3/23/20.
//  Copyright © 2020 MacBookPro. All rights reserved.
//

import UIKit
import SystemConfiguration.CaptiveNetwork
class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
         print(getWifiInfo())
    }

    // MARK: var 1
    struct WifiInfo {
        public let interface:String
        public let ssid:String
        public let bssid:String
        init(_ interface:String, _ ssid:String,_ bssid:String) {
            self.interface = interface
            self.ssid = ssid
            self.bssid = bssid
        }
    }

    func getWifiInfo() -> Array<WifiInfo> {
        guard let interfaceNames = CNCopySupportedInterfaces() as? [String] else {
            return []
        }
        let wifiInfo:[WifiInfo] = interfaceNames.compactMap{ name in
            guard let info = CNCopyCurrentNetworkInfo(name as CFString) as? [String:AnyObject] else {
                return nil
            }
            guard let ssid = info[kCNNetworkInfoKeySSID as String] as? String else {
                return nil
            }
            guard let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String else {
                return nil
            }
            return WifiInfo(name, ssid,bssid)
        }
        return wifiInfo
    }
    
    //MARK: var 2
//    func getWiFiName() -> String? {
//        var ssid: String?
//        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
//            for interface in interfaces {
//                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
//                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
//                    break
//                }
//            }
//        }
//        return ssid
//    }
//
//
    
    
    //MARK: var 3
//    func getInterfaces() -> Bool {
//        guard let unwrappedCFArrayInterfaces = CNCopySupportedInterfaces() else {
//            print("this must be a simulator, no interfaces found")
//            return false
//        }
//        guard let swiftInterfaces = (unwrappedCFArrayInterfaces as NSArray) as? [String] else {
//            print("System error: did not come back as array of Strings")
//            return false
//        }
//        for interface in swiftInterfaces {
//            print("Looking up SSID info for \(interface)") // en0
//            guard let unwrappedCFDictionaryForInterface = CNCopyCurrentNetworkInfo(interface as CFString) else {
//                print("System error: \(interface) has no information")
//                return false
//            }
//            guard let SSIDDict = (unwrappedCFDictionaryForInterface as NSDictionary) as? [String: AnyObject] else {
//                print("System error: interface information is not a string-keyed dictionary")
//                return false
//            }
//            for d in SSIDDict.keys {
//                print("\(d): \(SSIDDict[d]!)")
//            }
//        }
//        return true
//    }
//}
}
