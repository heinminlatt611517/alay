//
//  YoutubePlayerViewController.swift
//  Starter
//
//  Created by Admin on 07/07/2021.
//

import UIKit
import YouTubePlayer

class YoutubePlayerViewController: UIViewController {

    @IBOutlet var videoPlayer: YouTubePlayerView!

    var youtubeKey : String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if let key = youtubeKey {
            let myVideoURL = URL(string: "https://www.youtube.com/watch?v=\(key)")
            videoPlayer.loadVideoURL(myVideoURL!)

        }else {
            //invalid id..
            print("invalid id....")
        }
    }

    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
