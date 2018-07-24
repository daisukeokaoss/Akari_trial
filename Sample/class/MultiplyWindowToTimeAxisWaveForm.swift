//
//  MultiplyWindowToTimeAxisWaveForm.swift
//  EasyCamery
//
//  Created by 岡大輔 on 2018/07/23.
//  Copyright © 2018年 koherent.org. All rights reserved.
//

import UIKit
import Surge

public class MultiplyWindowToTimeAxisWaveForm: NSObject {
    
    public class func MultiplyWindowAndZerofillToTimeAxisWaveForm(timeAxisWaveForm:Array<Double>)->Array<Double>
    {
        if(timeAxisWaveForm.count <= 1024){
            //1024までゼロフィルする
            var wave = timeAxisWaveForm
            var initial = timeAxisWaveForm.count
            while(initial < 1024){
                wave.append(Double(0.0))
                initial += 1
            }
            return Array(Surge.fft(wave).dropFirst(wave.count/2))
            
        }else if(timeAxisWaveForm.count <= 2048){
            //2048までゼロフィルする
            var wave = timeAxisWaveForm
            
            var CuttedWave = timeAxisWaveForm.dropLast(timeAxisWaveForm.count - 1024)
            
            var waveformAfterWindow = [Double]()
            for i in 0..<CuttedWave.count{
                waveformAfterWindow.append(CuttedWave[i]/10000 * (0.54 - 0.46 * cos(2.0 * .pi * Double(i)/Double(CuttedWave.count))))
            }
            
            //return waveformAfterWindow
            
            return  Array<Double>(Surge.fft(waveformAfterWindow))
            //return Array<Double>(afterfft.dropLast(Int(afterfft.count/2)))
        }else if(timeAxisWaveForm.count <= 4096){
            //4096までゼロフィルする
            var wave = timeAxisWaveForm
            var initial = timeAxisWaveForm.count
            while(initial < 4096){
                wave.append(Double(0.0))
                initial += 1
            }
            return Array(Surge.fft(wave).dropFirst(wave.count/2))
        }else{
            return [0]
        }
    }

}
