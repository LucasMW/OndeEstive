//
//  GetNameUtil.swift
//  OndeEstive
//
//  Created by Lucas Menezes on 1/18/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

import Foundation

func parseDeviceName(deviceName : String) -> String{
    let unparsedName = deviceName
    let name = unparsedName.replacingOccurrences(of: "'s iPhone", with: "").replacingOccurrences(of: "'s iPad", with: "").replacingOccurrences(of: "iPhone de ", with: "").replacingOccurrences(of: "iPad de ", with: "")
    return name
}
