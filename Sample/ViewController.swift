import UIKit
import AVFoundation
import EasyCamery
import EasyImagy


class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    private let camera: Camera<RGBA<UInt8>> = try! Camera(sessionPreset: .high, focusMode: .continuousAutoFocus)
    
    private var FFTCount = 0;
    private var MAXFFTCount = 10;
    private var wave = [Float]()
    private var spectrum = [Float]()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        camera.start { [weak self] image in
            // Makes `image` negative
            
            image.update { pixel in
                
                //pixel.red = 255 - pixel.red
                //pixel.green = 255 - pixel.green
                //pixel.blue = 255 - pixel.blue
            }
            if(self?.FFTCount == 0){
                self?.wave = TimeAxisWaveFormGenerate.extractRGBTimeAxisWaveForm(inputImage: image)
                self?.spectrum = MultiplyWindowToTimeAxisWaveForm.MultiplyWindowAndZerofillToTimeAxisWaveForm(timeAxisWaveForm: (self?.wave)!)
                
                var imageOut = TimeAxisWaveFormPlot.plotTimeAxisWaveFormR(inputImage: image, timeAxisWaveForm: (self?.spectrum)!)
                self?.imageView.image = imageOut.uiImage(orientedTo: UIApplication.shared.cameraOrientation)
                self?.FFTCount = (self?.MAXFFTCount)!;
            }
            self?.FFTCount -= 1
            
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        camera.stop()
        
        super.viewWillDisappear(animated)
    }
    @IBAction func TapSnapShot(_ sender: Any) {
        self.saveTimeAxisWaveFormAndSpectrumToCSV()
        
        let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "CSVファイル保存しました", preferredStyle:  UIAlertControllerStyle.alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        // ③ UIAlertControllerにActionを追加
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    func saveTimeAxisWaveFormAndSpectrumToCSV()
    {
        //let fileName = "Tasks.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(self.generateFileNameForTimeAxisWaveForm())
        
    }
    
    func generateFileNameForTimeAxisWaveForm()->String
    {
        let format = "yyyy-MM-dd-HH:mm:ss"
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return "TimeAxisWaveForm" + formatter.string(from: now as Date) + ".csv"
    }
    
    func generateFileNameForSpectrum()->String
    {
        let format = "yyyy-MM-dd-HH:mm:ss"
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return "Spectrum" + formatter.string(from: now as Date) + ".csv"
    }
}

extension Image where Pixel == RGBA<UInt8> {
    func uiImage(orientedTo orientation: UIImageOrientation) -> UIImage {
        return UIImage(cgImage: cgImage, scale: 1.0, orientation: orientation)
    }
}

extension UIApplication {
    var cameraOrientation: UIImageOrientation {
        switch statusBarOrientation {
        case .portrait:           return .right
        case .landscapeRight:     return .up
        case .portraitUpsideDown: return .left
        case .landscapeLeft:      return .down
        case .unknown:            return .right
        }
    }
}
