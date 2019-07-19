//
//  ViewControllerTips.swift
//  Aqurate
//
//  Created by Patrick Leonardus on 19/07/19.
//  Copyright © 2019 Patrick Leonardus. All rights reserved.
//

import UIKit
import AVKit

class ViewControllerTips: UIViewController {
    
    let videoPlay : [String] = ["Bola bagian Bawah", "Posisi Badan", "Bola Tengah"]
    let randomVideo = Int.random(in: 0...2)
    let tips = ["Kick the bottom of the ball to get the ball up", "Try not to straighten your body when shooting", "Kick the center of the ball to straight forward shoot"]

    
    @IBOutlet weak var lblTips: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTips.text = tips[randomVideo]
        thumbnail.image = UIImage(named: videoPlay[randomVideo])
        thumbnail.layer.cornerRadius = 10
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(watchVideo))
        thumbnail.isUserInteractionEnabled = true
        thumbnail.addGestureRecognizer(tap)

    }
    
    
    @objc func watchVideo(){
        if let path = Bundle.main.path(forResource: videoPlay[randomVideo], ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion: {
                video.play()
            })
        }
    }    
    
    @IBAction func btnStart(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "Location")
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    

}
