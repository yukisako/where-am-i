//
//  ViewController.swift
//  where am I?
//
//  Created by 迫 佑樹 on 2016/01/01.
//  Copyright © 2016年 迫 佑樹. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var adressLabel: UILabel!
    
    var manager: CLLocationManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        
        manager.delegate = self
        //デリゲートは自身のクラス

        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //ロケーションが変わった時に実行されるメソッド
        var userLocation: CLLocation = locations[0]
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courseLabel.text = "\(userLocation.course)"
        
        self.speedLabel.text = "\(userLocation.speed)"
        
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            if (error != nil){
                print(error)
            } else {
                if let p = placemarks?[0]{
                    //placemarksは配列
                    print(p)
                    
                    if (p.subThoroughfare != nil){
                        /*
                        self.adressLabel.text =  "\(p.country!) \(p.postalCode!) \(p.administrativeArea!) \(p.subAdministrativeArea!) \(p.subLocality!) \(p.thoroughfare!) \(p.subThoroughfare!)"
*/
                        
                    } else {
                        
                        
                            self.adressLabel.text =  "\(p.country!) \n \(p.postalCode!) \n \(p.administrativeArea!) \n \(p.subLocality!) \n \(p.thoroughfare!) \n "

                        
                        
                    }
                    

                    
                }
            }
        }
        
        
        print(locations)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

