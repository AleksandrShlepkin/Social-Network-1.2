//
//  Extention.swift
//  Social Network
//
//  Created by Alex on 24.06.2021.
//

import Foundation
import UIKit

//MARK: Расшерение для печати JSON
extension Data {
    var prettyJSON: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            return nil
        }
        return prettyPrintedString
    }
}


//MARK: Расшерение для Даты и Времени
extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
}

//MARK: Расшерение для UIColor Flyweight

extension UIColor {
    static let greenColor = UIColor(red: 0.01, green: 1, blue: 0.02, alpha: 0.5)
    static let redColor = UIColor(red: 1, green: 0.01, blue: 0.02, alpha: 0.5)
}
