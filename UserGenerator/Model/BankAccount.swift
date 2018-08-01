//
//  BankAccount.swift
//  UserGenerator
//
//  Created by Yves Songolo on 8/1/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import Fakery

struct BankAccount{
    let CarNumber: String
    let CardType: String
    let expirationDate: Date
    
    init(){
         let faker = Faker(locale: "en")
        
        CarNumber = faker.business.creditCardNumber()
        CardType = faker.business.creditCardType() 
        expirationDate = faker.business.creditCardExpiryDate()!
    }
}
