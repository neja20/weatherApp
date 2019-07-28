//
//  ViewController.swift
//  MyWearherApp
//
//  Created by D N on 25/07/2019.
//  Copyright © 2019 Daniel Nejezchleb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currentWeatherView: BlurView!
    @IBOutlet weak var scrollView: CustomSV!
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var effects: EffectsView!
    var weatherSvc = WeatherService()
    @IBOutlet weak var forecastView: ForecastView!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.scrollView.refreshControl?.addTarget(self, action: #selector(refreshControlChanged), for: .valueChanged)
        
    }
    
    override func viewDidLayoutSubviews() {
        weatherSvc.loadLocalWeather { (success) in
            if(success)
            {
                self.updateWeatherData()
                self.updateScene()
                self.forecastView.updateForecastViews(forecasts: self.weatherSvc.forecast as! Array<NSDictionary>)
            }
        }
    }
    
    @objc func refreshControlChanged()
    {
        if((self.scrollView.refreshControl?.isRefreshing)!)
        {
            weatherSvc.loadLocalWeather { (success) in
                if(success)
                {
                    self.updateWeatherData()
                    self.updateScene()
                    self.forecastView.updateForecastViews(forecasts: self.weatherSvc.forecast as! Array<NSDictionary>)
                }
            }
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    func updateWeatherData() -> () {
        
        let degreesView = self.currentWeatherView.viewWithTag(20) as! UILabel
        let main = weatherSvc.currentWeather!["main"] as! NSDictionary
        let temp = main["temp"] as! NSNumber
        let tempInt = temp.intValue
        degreesView.text = String(tempInt)
        
        let cityView = self.currentWeatherView.viewWithTag(30) as! UILabel
        cityView.text = (weatherSvc.currentWeather!["name"] as! String)
        
        let weatherArray = weatherSvc.currentWeather!["weather"] as! NSArray
        let weather = weatherArray[0] as! NSDictionary
        let iconStr = weather["icon"] as! NSString
        let weType = weather["main"] as! NSString
        
        let weatherTypeView = self.currentWeatherView.viewWithTag(40) as! UILabel
        weatherTypeView.text = weType as String
        
        WeatherService.fetchIcon(icon: iconStr as String) { (success, image) in
            if(success)
            {
                let iconView = self.currentWeatherView.viewWithTag(10) as! UIImageView
                iconView.image = image
            }
        }
    }
    
    func updateScene()->()
    {
        let currentTime = self.weatherSvc.currentWeather?["dt"] as! NSNumber
        let sys = self.weatherSvc.currentWeather?["sys"] as! NSDictionary
        let sunrise = sys["sunrise"] as! NSNumber
        let sunset = sys["sunset"] as! NSNumber
        
        if((currentTime.intValue < sunrise.intValue)||(currentTime.intValue > sunset.intValue))
        {
            //its night
            background.image = #imageLiteral(resourceName: "nightSky.jpg")
            self.effects.isDay(day: false)
        }else
        {
            //its day
            background.image = #imageLiteral(resourceName: "daySky.jpg")
            self.effects.isDay(day: true)
        }
        
        
        
        let weatherArray = weatherSvc.currentWeather!["weather"] as! NSArray
        let weather = weatherArray[0] as! NSDictionary
        let weType = weather["main"] as! NSString
        
        switch weType {
        case "Clear":
            self.effects.startClear()
            break
        case "Clouds":
            self.effects.StartCloudy()
            break
        case "Rain":
            self.effects.startRain()
            break
        case "Mist":
            self.effects.startMist()
            break
        default:
            self.effects.hideAll()
            break
        }
        
        
    }
}

