//
//  DataService.swift
//  FoodTruck
//
//  Created by Javier Gomez on 1/5/19.
//  Copyright © 2019 Javier Gomez. All rights reserved.
//

import Foundation

protocol DataServiceDelegate: class {
    func trucksLoaded()
    func reviewsLoaded()
}

class DataService {
    static let instance = DataService()
    
    weak var delegate: DataServiceDelegate?
    var foodTrucks = [FoodTruck]()
    var reviews = [FoodTruckReview]()
    
    func getAllFoodTrucks() {
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: GET_ALL_FT) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("getAllFoodTrucks Succeeded: HTTP \(statusCode)")
                if let data = data {
                    self.foodTrucks = FoodTruck.parseFoodTruckJSONData(data: data)
                    self.delegate?.trucksLoaded()
                }
            } else {
                print("getAllFoodTrucks Failed: \(error!.localizedDescription)")
            }
        })
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func getAllReviews(for truck: FoodTruck) {
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let URL = URL(string: "\(GET_ALL_FT_REVIEWS)/\(truck.id)/review") else { return }
        print(URL)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("getAllReviews Succeeded: HTTP \(statusCode)")
                
                if let data = data {
                    self.reviews = FoodTruckReview.parseReviewJSONData(data: data)
                    self.delegate?.reviewsLoaded()
                }
            } else {
                print("getAllReviews Failed: \(String(describing: error?.localizedDescription))")
            }
        })
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func addNewFoodTruck(_ name: String, foodType: String, avgcost: Double, latitude: Double, longitude: Double, completion: @escaping callback) {
        let json: [String: Any] = [
            "name": name,
            "foodType": foodType,
            "avgCost": avgcost,
            "geometry": [
                "coordinates": [
                    "lat": latitude,
                    "long": longitude
                ]
            ]
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            let sessionConfig = URLSessionConfiguration.default
            
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let URL = URL(string: POST_ADD_NEW_FT) else { return }
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            
            guard let token = AuthService.instance.authToken else {
                completion(false)
                return
            }
            
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if (error == nil) {
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("addNewFoodTruck Succeeded: HTPP \(statusCode)")
                    
                    if statusCode != 200 {
                        completion(false)
                        return
                    } else {
                        self.getAllFoodTrucks()
                        completion(true)
                    }
                } else {
                    print("addNewFoodTruck Failed: \(String(describing: error?.localizedDescription))")
                    completion(false)
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
        } catch let err {
            completion(false)
            print(err)
        }
    }
    
    func addNewReview(_ foodTruckId: String, title: String, text: String, completion: @escaping callback) {
        let json: [String: Any] = [
            "title": title,
            "text": text,
            "foodtruck": foodTruckId
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            let sessionConfig = URLSessionConfiguration.default
            
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            guard let URL = URL(string: "\(POST_ADD_NEW_FT)/\(foodTruckId)/review") else { return }
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            
            guard let token = AuthService.instance.authToken else {
                completion(false)
                return
            }
            
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = jsonData
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if (error == nil) {
                    // Success
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("addNewReview Succeeded: HTTP \(statusCode)")
                    if statusCode != 200 {
                        completion(false)
                        return
                    } else {
                        completion(true)
                    }
                } else {
                    // Failure
                    print("addNewReview Failed: \(error!.localizedDescription)")
                    completion(false)
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
            
        } catch let err {
            print(err)
            completion(false)
        }
    }
}
