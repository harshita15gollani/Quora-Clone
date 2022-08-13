//
//  LaunchScreenViewController.swift
//  Quora
//
//  Created by Harshita Gollani on 07/08/22.
//

import UIKit
import AVKit

class LaunchScreenViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
                   super.viewDidAppear(animated)

                   self.setupAVPlayer()

               }



           func setupAVPlayer() {

                   let videoURL = Bundle.main.url(forResource: "splashScreen", withExtension: "mp4")

               if let URL = videoURL{

                   let avAssets = AVAsset(url: URL) // Create assets to get duration of video.



                   let avPlayer = AVPlayer(url: URL) // Create avPlayer instance



                   let avPlayerLayer = AVPlayerLayer(player: avPlayer) // Create avPlayerLayer instance



                   avPlayerLayer.frame = self.view.bounds // Set bounds of avPlayerLayer



                   self.view.layer.addSublayer(avPlayerLayer)

                   avPlayer.play()

                   avPlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1) , queue: .main) { [weak self] time in

                       if time == avAssets.duration {

                           let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController

                           self?.navigationController?.pushViewController(vc, animated: true)

                       }

                   }

               }else{

                   print("No file found")

               }

               }



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
