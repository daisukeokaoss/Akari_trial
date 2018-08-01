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
    
    public class func MultiplyWindowAndZerofillToTimeAxisWaveForm(timeAxisWaveForm:Array<Float>)->Array<Float>
    {
        if(timeAxisWaveForm.count <= 2048){
            //2048までゼロフィルする
            var wave = timeAxisWaveForm
            
            var CuttedWave = timeAxisWaveForm.dropLast(timeAxisWaveForm.count - 1024)
            
            var waveformAfterWindow = [Float]()
            for i in 0..<CuttedWave.count{
                //waveformAfterWindow.append(CuttedWave[i]/10000 * (0.54 - 0.46 * cos(2.0 * .pi * Float(i)/Float(CuttedWave.count))))
                waveformAfterWindow.append(CuttedWave[i]/1000 * (0.42 - 0.5 * cos(2.0 * .pi * Float(i)/Float(CuttedWave.count)) + 0.08 * cos(4.0 * .pi * Float(i)/Float(CuttedWave.count)) ))
            }
            
            //return waveform
            
            //return waveformAfterWindow
            
            var ArrayAfterFFT = Array<Float>(Surge.fft(waveformAfterWindow))
            var CuttedFFT = Array<Float>(ArrayAfterFFT.dropLast(900))
            
            return CuttedFFT
            //return Array<Double>(afterfft.dropLast(Int(afterfft.count/2)))
           // return FFT_Customise(timeAxisWaveForm)
        }
        
        return []
    }
    
    public class func FFT_Customise(inputData:[Float])->Array<Float>
    {
        let samplingHz = Int(pow(2.0, 10.0))        // 1024
        let log2n : vDSP_Length = vDSP_Length(log2(Double(samplingHz)))     // 10
        
        // テスト波形データ作成
        //var inputData = [Float](repeating: 0, count: samplingHz)
        let freq : Float = 440.0        // 周波数
        
 
        
        // FFT準備
        var fftObj : FFTSetup = vDSP_create_fftsetup(log2n, Int32(kFFTRadix2))!
        
        // 窓関数
        var windowData = [Float](repeating: 0, count: samplingHz)
        var windowOutput = [Float](repeating: 0, count: samplingHz)
        
        vDSP_hann_window(&windowData, vDSP_Length(samplingHz), Int32(0))
        vDSP_vmul(inputData, 1, &windowData, 1, &windowOutput, 1, vDSP_Length(samplingHz))
        
        // Complex
        var imaginaryData = [Float](repeating: 0, count: samplingHz)
        var dspSplit = DSPSplitComplex(realp: &windowOutput, imagp: &imaginaryData)
        
    
        
 
       // vDSP_ctoz(ctozinput, 2, &dspSplit, 1, vDSP_Length(samplingHz / 2))
        
        // FFT解析
        vDSP_fft_zrip(fftObj, &dspSplit, 1, log2n, Int32(FFT_FORWARD))
        vDSP_destroy_fftsetup(fftObj)
        
        var ReturnArray:Array<Float> = []
        for i in 0..<samplingHz/2 {
            var real = dspSplit.realp[i];
            var imag = dspSplit.imagp[i];
            var distance = sqrt(pow(real, 2) + pow(imag, 2))
            ReturnArray.append(distance/1000000)
        }
        return ReturnArray
    }

}
