//
//  RecorderViewController.swift
//  Pitch Perfect
//
//  Created by Tanveer Bashir on 11/6/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import UIKit
import AVFoundation

class RecorderViewController: UIViewController, AVAudioRecorderDelegate{
    
    var audioRecorder:AVAudioRecorder!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var recordButtonOutlet: UIButton!
    @IBOutlet weak var stopRecordingBtn: UIButton!
    var audioData:AudioData!
    
    override func viewWillAppear(animated: Bool) {
         stopRecordingBtn.hidden = true
    }
    
    @IBAction func recordAudion(sender: UIButton) {
        messageLabel.text = "Rocording in progress..."
        stopRecordingBtn.hidden = false
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as
            String
        let recordingName = "myAudio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord,
            withOptions:AVAudioSessionCategoryOptions.DefaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecordingButton(sender: UIButton) {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        messageLabel.text = "Tap to Record"
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            if let title = recorder.url.lastPathComponent {
                let fileURL = recorder.url
                audioData = AudioData(title: title, fileURL: fileURL)
                self.performSegueWithIdentifier("secondVC", sender: audioData)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let identifier = "secondVC"
        if segue.identifier == identifier {
            let playAudioVC = segue.destinationViewController as! PlayAudioViewController
            playAudioVC.audioData = sender as! AudioData
        }
    }
}

