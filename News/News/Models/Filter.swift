//
//  Filter.swift
//  News
//
//  Created by Philipp Ollmann on 22.06.21.
//

import Foundation

enum Countries: String {
    case austria = "AUSTRIA"
    case germany = "GERMANY"
    case america = "AMERICA"
    case england = "ENGLAND"
    case italy = "ITALY"
    case netherlands = "NETHERLANDS"
    case russia = "RUSSIA"
    
    func getCountryCode() -> String {
        switch self {
        case .austria: return "at"
        case .germany: return "de"
        case .america: return "us"
        case .england: return "gb"
        case .italy: return "it"
        case .netherlands: return "nl"
        case .russia: return "ru"
        }
    } 
}

enum Categories: String {
    case business = "BUSINESS"
    case entertainment = "ENTERTAINMENT"
    case general = "GENERAL"
    case health = "HEALTH"
    case science = "SCIENCE"
    case sports = "SPORTS"
    case technology = "TECHNOLOGY"
}

struct Filter {
    var searchTerm: String?
    var country: Countries = .austria
    var category: Categories?
    
    func getFilterString() -> String {
        var rv = country.rawValue
        if let category = category {
            rv += " | \(category.rawValue)"
        }
        if let searchTerm = searchTerm, searchTerm.trimmingCharacters(in: .whitespaces).count > 0 {
            rv += " | \(searchTerm.uppercased())"
        }
        return rv
    }
}
