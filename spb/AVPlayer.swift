
import Foundation
import AVFoundation



class AVDPlayer: NSObject, AVAudioPlayerDelegate {

    var audioPlayer:AVAudioPlayer!
    
    func playLaugh() {
        
        
//        let bundle = Bundle.main
        
        //let path = bundle.path(forResource: "fever", ofType: "mp3")
        
//        if let p = path {
//            let string = try! NSString(contentsOfFile: p, encoding: String.Encoding.utf8.rawValue)
////            (contentsOfFile: p,
////             encoding: NSUTF8StringEncoding,
////             error: nil)
//            
//            print(string)
//        } else {
//            print("Could not find path")
//        }
        
        
        // 再生する audio ファイルのパスを取得
//        let audioPath = Bundle.main.path(forResource: "fever", ofType:"mp3")!
        
        let audioUrl = URL(fileURLWithPath: "fever.mp3")
        
        

        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        } catch let error as NSError {
            audioError = error
            audioPlayer = nil
        }
        
        // エラーが起きたとき
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
    }
}
