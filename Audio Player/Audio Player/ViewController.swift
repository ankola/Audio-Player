import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var lbl:UILabel!
    @IBOutlet var btnMute:UIButton!
    @IBOutlet var btnUp:UIButton!
    @IBOutlet var btnDown:UIButton!

    @IBOutlet weak var slider: UISlider!

    var audioplayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        let url = Bundle.main.url(forResource: "Oh Humsafar", withExtension: "mp3")
        do{
            audioplayer = try AVAudioPlayer(contentsOf: url!)
            audioplayer.prepareToPlay()
            audioplayer.currentTime = 0
            lbl.text = "\(audioplayer.currentTime)"
            
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (Timer) in
                self.lbl.text = "\(round(self.audioplayer.currentTime*10)/10)"
                self.slider.value = Float(self.audioplayer.currentTime)

                if self.audioplayer.volume == 0 {
                    self.btnMute.isHidden = true
                } else {
                    self.btnMute.isHidden = false
                }
                
                if self.audioplayer.volume > 99 {
                    self.btnUp.isHidden = true
                } else {
                    self.btnUp.isHidden = false
                }
                
                if self.audioplayer.volume < 1 {
                    self.btnDown.isHidden = true
                } else {
                    self.btnDown.isHidden = false
                }
                
            })
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        audioplayer.stop()
        audioplayer.currentTime = TimeInterval(slider.value)
        audioplayer.prepareToPlay()
        audioplayer.play()
    }
    
    @IBAction func btnPlay(_sender : UIButton){
        audioplayer.play()
    }
    
    @IBAction func btnPause(_sender : UIButton){
        audioplayer.pause()
    }
    
    @IBAction func btnStop(_sender : UIButton){
     audioplayer.stop()
    audioplayer.currentTime = 0
    }
    
    @IBAction func btnVolumeUp(_sender : UIButton){
        audioplayer.volume = audioplayer.volume + 1
        print(audioplayer.volume)
    }
    
    @IBAction func btnVolumeDown(_sender : UIButton){
        audioplayer.volume = audioplayer.volume - 1
        print(audioplayer.volume)

    }
    @IBAction func btnVolumeMute(){
        audioplayer.volume = 0
    }
    

}
