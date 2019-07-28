//
//  ForecastView.swift
//  MyWearherApp
//
//  Created by D N on 27/07/2019.
//  Copyright © 2019 Daniel Nejezchleb. All rights reserved.
//

import Foundation
import UIKit

class ForecastView : UIView {
    
    override func awakeFromNib() {
        
        //self.backgroundColor = .red
        
        let viewFromNib: UIView? = Bundle.main.loadNibNamed("ForecastView",
                                                            owner: nil,
                                                            options: nil)?.first as! UIView

        self.addSubview(viewFromNib!)
    }
    
    func updateForecastViews(forecasts : Array<NSDictionary>) ->()
    {
        var i = 0
        for item in forecasts {
            if(i == 4){break}
            
            let time = item["dt"] as! NSNumber
            
            let main = item["main"] as! NSDictionary
            let temp = main["temp"] as! NSNumber
            
            let weatherArray = item["weather"] as! NSArray
            let weather = weatherArray[0] as! NSDictionary
            let icon = weather["icon"] as! NSString
            
            let forecastView = self.viewWithTag(200) as! UIView
            let cell = forecastView.viewWithTag((i+1)) as! ForecastCellView
            cell.tempLabel.text = String(temp.intValue) + " ℃"
            
            //let myTimeInterval = TimeInterval(time)
            let datetime = Date(timeIntervalSinceNow: time.doubleValue)
            let calendar = Calendar.current
            let comp = calendar.dateComponents([.hour, .minute], from: datetime)
            let hour = comp.hour
            cell.dayLabel.text = String(hour!)
            
            WeatherService.fetchIcon(icon: icon as String) { (success, image) in
                if(success)
                {
                    cell.weatherIcon.image = image
                }
            }
            
            i += 1
        }
    }
}
