//
//  User.swift
//  UserGenerator
//
//  Created by Yves Songolo on 7/31/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Fakery

class UserGen {
    let firstName: String
    let lastName: String
    let email: String
    let id: String
    let title: String
    let phoneNumber: String
    let headline: String
    let password: String
    let username: String
    let profilePic: String
    var creditCard = [BankAccountGen]()
    var address = AddressGen()
    let prefix: String
    /// generate user with dumy data
    init(){
       let faker = Faker(locale: "en")
       firstName = faker.name.firstName()
       lastName = faker.name.lastName()
       email = faker.internet.email()
        title = faker.name.title()
        phoneNumber = faker.phoneNumber.cellPhone()
        let number = faker.number.randomInt(min: 1, max:10)
        headline = faker.lorem.paragraph(sentencesAmount: number)
        password = faker.internet.password(minimumLength: 10, maximumLength: 15)
        username = faker.internet.username(separator: "_")
        let bank = BankAccountGen()
        creditCard.append(bank)
        id = UUID().uuidString
        prefix = faker.name.prefix()
        profilePic = faker.internet.image()
    }
    /// method to add multiple card
    func addNewCard(number: Int){
        for _ in 1...number{
            creditCard.append(BankAccountGen())
        }
    }
    /// func to generate user with address based on coordinate and radius
    static func generateUser( longitude: Double, latitude: Double, radius: Double, completion: @escaping(UserGen) -> ()){
       
        let user = UserGen()
        AddressGen.generateAddress(longitude: longitude, latitude: latitude, radius: radius) { (address) in
            user.address = address
            completion(user)
            }
    }
    /// Method to generate multiple user
    static func generateMultipleUser( number: Int, longitude: Double, latitude: Double, radius: Double, completion: @escaping([UserGen]) -> ()){
        
        let dg = DispatchGroup()
        var users = [UserGen]()
        for _ in 0...number{
            dg.enter()
        let user = UserGen()
        AddressGen.generateAddress(longitude: longitude, latitude: latitude, radius: radius) { (address) in
            user.address = address
            users.append(user)
            dg.leave()
            }
            dg.notify(queue: .main) {
                completion(users)
            }
        }
        
       
    }
    
}















//
