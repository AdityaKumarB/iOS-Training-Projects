import UIKit

import Foundation


// MARK: Error Handling
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed snack: String, person name: String) throws {
        guard let item = inventory[snack] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[snack] = newItem

        print("Dispensing \(snack) to \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Liquorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName, person: person)
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 100
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}


class A {
    var x: Int
    init(x: Int) {
        self.x = x
    }
    convenience init(x: Double) {
        self.init(x: Int(x))
    }

    convenience init(x: String) {
      if let y = Double(x) {
        self.init(x: y)
      } else {
        self.init(x: 0)
      }
    }
}

let a = A(x: 4)
print(a.x)

let b = A(x: 4.5)
print(b.x)

let c = A(x: "3.45")
print(c.x)

let d = A(x: "Chandu")
print(d.x)

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}


var things: [Any] = []

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })


for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}


class X {
    var x: Int
    
    required init(x: Int) {
        print("X is required")
        self.x = x
    }
}

class Y: X {
    var y: Int
    override init() {
        y = 5
        super.init(x: y)
    }
    
    required init(x: Int) {
        fatalError("init(x:) has not been implemented")
    }
}

let y = Y()
print(y.x)
