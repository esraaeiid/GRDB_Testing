//
//  TimeFormatting.swift
//  Coordinators_HWS
//
//  Created by Esraa Eid on 12/02/2021.
//

import UIKit

extension Int{
    func timeString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        
        let formattedString = formatter.string(from: TimeInterval(self)) ?? "0"
        
        if formattedString == "0"{
            return "GMT"
        }else{
            if formattedString.hasPrefix("-"){
                return "GMT\(formattedString)"
            }else{
                return "GMT+\(formattedString)"
            }
        }
    }
}
