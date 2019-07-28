//
//  WeatherService.swift
//  MyWearherApp
//
//  Created by D N on 25/07/2019.
//  Copyright © 2019 Daniel Nejezchleb. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation


class WeatherService: NSObject
{
    let lm = LocationManager()
    
    var currentWeather : [String : Any]? = nil
    var forecast : Array<Any> = Array()
    
    let WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather"
    let APPI_KEY = "343dd8945760b0829ccfd7bd002e40f3"
    
    func requestWeatherData(location : CLLocation, cb:@escaping (Bool)->())
    {
        let params : [String : String] = [
            "lat":      String(location.coordinate.latitude),
            "lon":      String(location.coordinate.longitude),
            "units": "metric",
            "APPID":    APPI_KEY]
        
        let request = Alamofire.request(WEATHER_URL, method: HTTPMethod.get, parameters: params)
        request.responseJSON { (responseData) in
            if((responseData.error) != nil) {return}
            
            if(responseData.result.isSuccess)
            {
                if let json : [String : Any] = responseData.result.value as! [String : Any]
                {
                    print("JSON: \(json)")
                    let weatherArray = json["weather"] as! NSArray
                    let name = json["name"] as! NSString
                    let main = json["main"] as! NSDictionary
                    let temp = main["temp"] as! NSNumber
                    let tempInt = temp.intValue

                    let weather = weatherArray[0] as! NSDictionary
                    let iconStr = weather["icon"] as! NSString
                    let weType = weather["main"] as! NSString
                    //let iconValue = weatherValue[0]
                    print(iconStr)
                    
                    self.currentWeather = json
                    
                    cb(true)
                }
            }else
            {
                cb(false)
            }
        }
    }
    
    let FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast"

    func requestForecast(location : CLLocation, cb: @escaping (Bool)->()) -> ()
    {
        let params : [String : String] = [
            "lat":      String(location.coordinate.latitude),
            "lon":      String(location.coordinate.longitude),
            "units": "metric",
            "cnt": "5",

            "APPID":    APPI_KEY]
        
        let request = Alamofire.request(FORECAST_URL, method: HTTPMethod.get, parameters: params)
        request.responseJSON { (responseData) in
            if((responseData.error) != nil) {return}
            
            if(responseData.result.isSuccess)
            {
                if let json : [String : Any] = responseData.result.value as! [String : Any]
                {
                    print("XXXXXX: \(json)")
                    let list = json["list"] as! Array<Any>
                    self.forecast = list
                    cb(true)
                }
            }else{
                cb(false)
            }
            
        }
    }
    
    
    
    static let ICON_URL = "https://openweathermap.org/img/wn/"

    static func fetchIcon(icon : String, cb: @escaping (Bool, UIImage?)->())
    {
        let url = ICON_URL + icon + "@2x.png"
        Alamofire.request(url).responseData(completionHandler: { (data) in
            if(data.result.isSuccess)
            {
                let image = UIImage(data: data.result.value!)
                cb(true, image)
            }else
            {
            cb(false, nil)
            }
        })
    }
    
    
    func loadLocalWeather(completion: @escaping (Bool)->())
    {
        lm.getLocation { (loc) in
            self.requestWeatherData(location: loc, cb: completion)
            self.requestForecast(location: loc, cb: completion)
        }
    }
}
