//
//  Extention.swift
//  Social Network
//
//  Created by Alex on 24.06.2021.
//

import Foundation
import UIKit
import TTTAttributedLabel

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

extension TTTAttributedLabel {
      func showTextOnTTTAttributeLable(str: String, readMoreText: String, readLessText: String, font: UIFont?, charatersBeforeReadMore: Int, activeLinkColor: UIColor, isReadMoreTapped: Bool, isReadLessTapped: Bool) {

        let text = str + readLessText
        let attributedFullText = NSMutableAttributedString.init(string: text)
        let rangeLess = NSString(string: text).range(of: readLessText, options: String.CompareOptions.caseInsensitive)
//Swift 5
       // attributedFullText.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.blue], range: rangeLess)
        attributedFullText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue], range: rangeLess)

        var subStringWithReadMore = ""
        if text.count > charatersBeforeReadMore {
          let start = String.Index(encodedOffset: 0)
          let end = String.Index(encodedOffset: charatersBeforeReadMore)
          subStringWithReadMore = String(text[start..<end]) + readMoreText
        }

        let attributedLessText = NSMutableAttributedString.init(string: subStringWithReadMore)
        let nsRange = NSString(string: subStringWithReadMore).range(of: readMoreText, options: String.CompareOptions.caseInsensitive)
        //Swift 5
       // attributedLessText.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.blue], range: nsRange)
        attributedLessText.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue], range: nsRange)
      //  if let _ = font {// set font to attributes
      //   self.font = font
      //  }
        self.attributedText = attributedLessText
        self.activeLinkAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
        //Swift 5
       // self.linkAttributes = [NSAttributedStringKey.foregroundColor : UIColor.blue]
        self.linkAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
                self.addLink(toTransitInformation: ["ReadMore":"1"], with: nsRange)

                if isReadMoreTapped {
                  self.numberOfLines = 0
                  self.attributedText = attributedFullText
                  self.addLink(toTransitInformation: ["ReadLess": "1"], with: rangeLess)
                }
                if isReadLessTapped {
                  self.numberOfLines = 3
                  self.attributedText = attributedLessText
                }
              }
            }

extension ThirdCell: TTTAttributedLabelDelegate {
  func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWithTransitInformation components: [AnyHashable : Any]!) {
    if let _ = components as? [String: String] {
      if let value = components["ReadMore"] as? String, value == "1" {
        self.readMore(readMore: true)
      }
      if let value = components["ReadLess"] as? String, value == "1" {
        self.readLess(readLess: false)
      }
    }
  }
}
