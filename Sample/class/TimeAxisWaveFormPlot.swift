//
//  TimeAxisWaveFormPlot.swift
//  EasyCamery
//
//  Created by 岡大輔 on 2018/07/23.
//  Copyright © 2018年 koherent.org. All rights reserved.
//

import UIKit
import EasyImagy

public class TimeAxisWaveFormPlot: NSObject {
    public class func plotTimeAxisWaveFormR(inputImage:Image<RGBA<UInt8>>,timeAxisWaveForm:Array<Double>)->Image<RGBA<UInt8>>
    {
        let maxGaugeOfGraph = 10
        
        var outputImage:Image<RGBA<UInt8>> = inputImage;
        
        for w in 0..<inputImage.width{
            for h in 0..<inputImage.height{
                if(w >= timeAxisWaveForm.count){
                    
                }else if(Double(inputImage.width)*Double(timeAxisWaveForm[w])/Double(maxGaugeOfGraph) > Double(h)){
                    outputImage[w,h].red = 255
                    outputImage[w,h].green = 0
                    outputImage[w,h].blue = 0
                }
            }
        }
        return outputImage
    }
}
