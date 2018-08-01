# **USER GENERATOR**

User generator is an awesome pod that help you to create 1 to infinite number of user
with address, bank account, and profile image url within a single line of code.

## Model:
### User:
```
     firstName: String
     lastName: String
     email: String
     id: String
     title: String
     phoneNumber: String
     headline: String
     password: String
     username: String
     profilePic: String
     creditCard : [BankAccount]
     address = Address()
     prefix: String
```

### Address:
```
     city: String?
     zipCode: Int?
     street: String?
     state: String?
     longitude: Double?
     latitude: Double?
     country: String?
```

### Bank:
```
     CarNumber: String
     CardType: String
     expirationDate: Date
```

## use case:

#### Generate single user
```
let user = User() //==> generate a new user
```
#### Generate single address
```
 let address = Address() //==> generate new address
```
#### Generate single credit card

```
let debit = BankAccount()
```

### Generate multiple user

use a real coordinate to get address in a radius region
```
User.generateMultipleUser(number: 100, longitude: -122.40641700, latitude: 37.78583399, radius: 300) { (users) in
            print(users)
        }
```

### Generate multiple address
```
Address.generateMultipleAddress(number: 65, longitude:  -122.40641700, latitude: 37.78583399, radius: 350) { (addresses) in
            print(addresses)
        }
```

## Credit:
My pod use [Fakery](https://github.com/vadymmarkov/Fakery) pod to create those dummy data, if you want more freedom, you can always visit their repository
