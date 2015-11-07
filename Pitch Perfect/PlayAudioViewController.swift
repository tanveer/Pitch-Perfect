//
//  PlayAudioViewController.swift
//  Pitch Perfect
//
//  Created by Tanveer Bashir on 11/7/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import UIKit
import AVFoundation

class PlayAudioViewController: UIViewController {
    
    @IBOutlet weak var chipMunk: UIButton!
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var darthVader: UIButton!
    var audioPlayer:AVAudioPlayer!
    var audioFiles:[NSURL] = []
    var audioData:AudioData!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioFile = try! AVAudioFile(forReading: audioData.filePathURL)
        audioEngine = AVAudioEngine()
        audioPlayer = try! AVAudioPlayer(contentsOfURL: audioData.filePathURL)
        audioPlayer.enableRate = true
    }

    @IBAction func playSlowAudio(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        audioControl(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
        audioControl(1.5)
    }
    
    @IBAction func chipmunkSound(sender: UIButton) {
        changeAudioPitch(1500)
    }
    
    @IBAction func darthVaderSoundEffect(sender: UIButton) {
        changeAudioPitch(-1000)
    }
    
    @IBAction func stopPlayingAudio(sender: UIButton) {
        audioPlayer.stop()
        stateOfButton(true)
    }
    
    //MARK:- Helper methods
    func changeAudioPitch(pitch:Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        let audioPitch = AVAudioUnitTimePitch()
        audioPitch.pitch = pitch
        audioEngine.attachNode(audioPitch)
        audioEngine.connect(audioPlayerNode, to: audioPitch, format: nil)
        audioEngine.connect(audioPitch, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile!, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
    }
    
    func audioControl(rate:Float){
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func stateOfButton(state:Bool) {
        fastButton.enabled = state
        slowButton.enabled = state
        chipMunk.enabled = state
        darthVader.enabled = state
    }
}
