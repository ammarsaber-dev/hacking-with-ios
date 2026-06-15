//
//  Order.swift
//  CupcakeCorner
//
//  Created by Ammar Saber on 14/06/2026.
//

import Foundation

@Observable
final class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool {
        // Challenge 1 Done
        ![name, streetAddress, city, zip]
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .contains(where: \.isEmpty)
    }

    var cost: Decimal {
        let decimalQuantity = Decimal(quantity)

        // $2 per cake
        var cost = decimalQuantity * 2

        // complicated cakes cost more
        cost += Decimal(type) / 2

        // $1 per cake for extra frosting
        if extraFrosting {
            cost += decimalQuantity
        }

        // $0.50 per cake for sprinkles
        if addSprinkles {
            cost += decimalQuantity / 2
        }

        return cost
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "savedOrder")
        }
    }

    static func load() -> Order {
        guard let data = UserDefaults.standard.data(forKey: "savedOrder"),
            let order = try? JSONDecoder().decode(Order.self, from: data)
        else {
            return Order()
        }

        return order
    }
}
