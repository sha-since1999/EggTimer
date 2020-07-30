//
//  ViewController.swift
//  EggTimer
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    var secondRemaining=60
    var timer :Timer?
    var player: AVAudioPlayer?
    @IBOutlet weak var msg: UILabel!
    
    @IBOutlet weak var showTime: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var eagTime = 0
    @IBAction func eagPressed(_ sender: UIButton)
    {   player?.pause()
        showTime.text = "0 second"
        msg.text=sender.currentTitle
        msg.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
           timer?.invalidate()
            let hardness :[String:Int]=["Soft" :3,"Medium" :5,"Hard" :7]
         eagTime = hardness[sender.currentTitle!]!
            secondRemaining = hardness[sender.currentTitle!]!

             timer=Timer.scheduledTimer(timeInterval: 1.0,
                                 target: self,
                                 selector: #selector(updateTimer),
                                 userInfo: nil,
                                 repeats: true)
        }
    


    

    func playSound()
    {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!

        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()
          

        } catch let error as NSError {
            print(error.description)
        }
        
    }
    
    // Timer expects @objc selector
    @objc func updateTimer()
    {
        if secondRemaining >= 0
        {
            progressBar.progress=1-Float(secondRemaining)/Float(eagTime)
        print("\(secondRemaining) second.")
            showTime.text = " \(secondRemaining) second ."
        secondRemaining -= 1
            
        }
        else
        {   timer?.invalidate()
            msg.text = "well done"
            playSound()
            showTime.text = " Time Up"
            msg.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            
        }
            
            
    }
    

}

    


