//
//  API.swift
//  OndeEstive
//
//  Created by Lucas Menezes on 1/18/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

import Foundation
import Alamofire

struct CoordinateParam {
    var personId : Int
    var date : Date
    var lat : Float
    var long : Float
}
class API {
    let baseAPI = "http://localhost:8080/"
    func insertCoordinates(personId : Int,date : Date, lat : Float, long : Float, completion : @escaping (Bool) -> ()){
        let params = [
            "personID" : "\(personId)",
            "latitude" : "\(lat)",
            "longitude" : "\(long)",
            //"date" : ""
        ]
        Alamofire.request("\(baseAPI)registerCoordinate", method: .post, parameters: params, headers: .none).responseString { (res) in
            switch res.result {
            case .success(let str):
                completion(str.contains("inserted!"))
            case .failure(let err):
                print(err)
                completion(false)
            }
        }
    }
    func insertBulkCoordinates(array : [CoordinateParam], completion : @escaping (Bool) -> ()){
        let array = array.map { (coord) -> [String : String] in
            return [ "personID" : "\(coord.personId)",
                "latitude" : "\(coord.lat)",
                "longitude" : "\(coord.long)" ]
        }
        print(array.count)
        print(array.map({ (dict) -> String in
            return "{\(dict["personID"]! ),\(dict["latitude"]!),\(dict["longitude"]!)}"
        }))
        let params1 = ["array " : array]
        let params2 = array.asParameters()
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(array) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        }
        
        
        Alamofire.request("\(baseAPI)registerBunchOfCoordinate", method: .post, parameters: params2, headers: .none).responseString { (res) in
            switch res.result {
            case .success(let str):
                completion(str.contains("inserted!"))
            case .failure(let err):
                completion(false)
            }
        }
    }
    func insertBulkCoordinates2(array : [CoordinateParam], completion : @escaping (Bool) -> ()){
        let array = array.map { (coord) -> [String : String] in
            return [ "personID" : "\(coord.personId)",
                "latitude" : "\(coord.lat)",
                "longitude" : "\(coord.long)" ]
        }
        print(array.count)
        print(array.map({ (dict) -> String in
            return "{\(dict["personID"]! ),\(dict["latitude"]!),\(dict["longitude"]!)}"
        }))
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(array) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                let params = ["json" : jsonString]
                Alamofire.request("\(baseAPI)registerBunchOfCoordinate", method: .post, parameters: params, headers: .none).responseString { (res) in
                    switch res.result {
                    case .success(let str):
                        completion(str.contains("inserted!"))
                    case .failure(let err):
                        print(err)
                        completion(false)
                    }
                }
            }
        }
        
        
        
    }
    
}
