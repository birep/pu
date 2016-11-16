import AVFoundation

/// **must** define instance variable outside, because .play() will deallocate AVAudioPlayer 
/// immediately and you won't hear a thing
var player: AVAudioPlayer?

extension Collection where Index == Int {

    /**
     Picks a random element of the collection.

     - returns: A random element of the collection.
     */
    func randomElement() -> Iterator.Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(endIndex)))]
    }

}

let soundList = ["pu1","pu2","pu3","pu4"]

func playSound(sound: String) {
    guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else {
        print("url not found")
        return
    }

    do {
        /// this codes for making this app ready to takeover the device audio
        try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try AVAudioSession.sharedInstance().setActive(true)

        /// change fileTypeHint according to the type of your audio file (you can omit this)
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3)

        // no need for prepareToPlay because prepareToPlay is happen automatically when calling play()
        player!.play()
    } catch let error as NSError {
        print("error: \(error.localizedDescription)")
    }
}
