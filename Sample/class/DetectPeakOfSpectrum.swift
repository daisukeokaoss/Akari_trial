//
//  DetectPeakOfSpectrum.swift
//  Sample
//
//  Created by 岡大輔 on 2018/07/29.
//  Copyright © 2018年 koherent.org. All rights reserved.
//

import UIKit
import EasyImagy


public class DetectPeakOfSpectrum: NSObject {
    
    /*public class func DetectPeakFromImage(inputImage:Image<RGBA<UInt8>>,PeakIndex:Int)->Bool
    {
        var TimeAXisWaveForm =TimeAXisWaveForm
    }*/
    
    public class func DetectPeakFromSpectrum(spectrum:Array<Float>)->Bool
    {
        var sumOfInsideOfIndex10 = Float(0.0)
        
        for i in 2..<10 {
            sumOfInsideOfIndex10 += spectrum[i]
        }
        var averageOfInsideOfIndex10 = sumOfInsideOfIndex10/10
        var peakValue = spectrum[4]
        
        var differenceOfPeakAndAverage = peakValue - averageOfInsideOfIndex10
        if(differenceOfPeakAndAverage > 3){
            return true
        }else{
            return false
        }
        
    }
    
    

}
