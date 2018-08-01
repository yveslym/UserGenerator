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

class User {
    var firstName: String
    var lastName: String
    var email: String
    var id: String
    var title: String
    var phoneNumber: String
    var headline: String
    var password: String
    var username: String
    var profilePic: String
    var creditCard = [BankAccount]()
    var address = Address()
    var prefix: String
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
        let bank = BankAccount()
        creditCard.append(bank)
        id = UUID().uuidString
        prefix = faker.name.prefix()
        profilePic = faker.internet.image()
    }
    /// method to add multiple card
    func addNewCard(number: Int){
        for _ in 1...number{
            creditCard.append(BankAccount())
        }
    }
    /// func to generate user with address based on coordinate and radius
    static func generateUser( longitude: Double, latitude: Double, radius: Double, completion: @escaping(User) -> ()){
       
        let user = User()
        Address.generateAddress(longitude: longitude, latitude: latitude, radius: radius) { (address) in
            user.address = address
            completion(user)
            }
    }
    /// Method to generate multiple user
    static func generateMultipleUser( number: Int, longitude: Double, latitude: Double, radius: Double, completion: @escaping([User]) -> ()){
        
        let dg = DispatchGroup()
        var users = [User]()
        for _ in 0...number{
            dg.enter()
        let user = User()
        Address.generateAddress(longitude: longitude, latitude: latitude, radius: radius) { (address) in
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
