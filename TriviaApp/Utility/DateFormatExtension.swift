//
//  DateFormatExtension.swift
//  TriviaApp
//
//  Created by Neelamegam Pradeepkumar, Sowmiya on 07/01/21.
//  Copyright © 2021 Sowmiya. All rights reserved.
//

import Foundation

extension Date {

    func dateFormatWithSuffix() -> String {
        return "d'\(self.daySuffix())' MMM, hh:mm a"
    }

    func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}
