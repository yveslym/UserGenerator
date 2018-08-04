//
//  Address.swift
//  UserGenerator
//
//  Created by Yves Songolo on 7/31/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import CoreLocation
import Fakery

class AddressGen: NSObject {
    var city: String?
    var zipCode: Int?
    var street: String?
    var state: String?
    var longitude: Double?
    var latitude: Double?
    var country: String?
    
    /// generate dumy address
    override init(){
        let faker = Faker(locale: "en")
        self.street = faker.address.streetAddress(includeSecondary: true)
        
        self.zipCode = Int(faker.address.postcode())
        self.state = faker.address.state()
        self.country = "United State"//faker.address.country()
        self.longitude =  faker.address.longitude()
        self.latitude = faker.address.latitude()
        self.city = faker.address.city()
        
    }
    
    /// generate address based on coordinate
    static func generateAddress( longitude: Double, latitude: Double, radius: Double, completion: @escaping (AddressGen)-> ()){
        let faker = Faker(locale: "en")
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let fakeAddr = faker.address.coordinate(inRadius: radius, fromCenter: coordinate)
        let location = CLLocation(latitude: fakeAddr.latitude, longitude: fakeAddr.longitude)
        
        var address = AddressGen()
        
        self.lookUpCurrentLocation(location: location) { (placeMark) in
            if placeMark != nil{
                address.city = placeMark?.locality
                address.country = placeMark?.country
                address.street = placeMark?.name
                address.zipCode = Int(placeMark?.postalCode ?? "00000")
                address.state = placeMark?.administrativeArea
                address.longitude = location.coordinate.longitude
                address.longitude = location.coordinate.longitude
                completion(address)
            }
            else{
                completion(address)
            }
        }
    }
    
    /// generate multiple addresses based on coordinate
    
    static func generateMultipleAddress( number: Int, longitude: Double, latitude:
        Double, radius: Double, completion: @escaping ([AddressGen])-> ()){
        
        var addresses = [AddressGen]()
        
        let faker = Faker(locale: "en")
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let dg = DispatchGroup()
        for _ in 1...number{
            dg.enter()
           
           
            let fakeAddr = faker.address.coordinate(inRadius: radius, fromCenter: coordinate)
            
            let location = CLLocation(latitude: fakeAddr.latitude, longitude: fakeAddr.longitude)
            
            var address = AddressGen()
            
            self.lookUpCurrentLocation(location: location) { (placeMark) in
                if placeMark != nil{
                    address.city = placeMark?.locality
                    address.country = placeMark?.country
                    address.street = placeMark?.name
                    address.zipCode = Int(placeMark?.postalCode ?? "00000")
                    address.state = placeMark?.administrativeArea
                    address.longitude = location.coordinate.longitude
                    address.longitude = location.coordinate.longitude
                    addresses.append(address)
                    
                    dg.leave()
                }
                
                dg.notify(queue: .main, execute: {
                    completion(addresses)
                })
                
            }
        }
    }
    
    // convert the geo location into place mark
    private static func lookUpCurrentLocation(location: CLLocation, completionHandler: @escaping (CLPlacemark?)
        -> Void ) {
        let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                completionHandler(firstLocation)
            }
            else {
                // An error occurred during geocoding.
                completionHandler(nil)
            }
        })
    }
    
}
