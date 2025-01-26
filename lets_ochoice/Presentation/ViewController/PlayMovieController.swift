//
//  PlayMovieController.swift
//  lets_ochoice
//
//  Created by homechoic on 1/26/25.
//

import UIKit
import AVKit

class PlayMovieController: UIViewController {
    
    private var player: AVPlayer?
    private var playerViewController: AVPlayerViewController?
    private let movieUrl: String
    
    init(movieUrl: String) {
        self.movieUrl = movieUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        playVideo()
    }
    
    private func playVideo() {
        guard let url = URL(string: movieUrl) else {
            print("Error: Invalid movie URL")
            return
        }
        
        player = AVPlayer(url: url)
        playerViewController = AVPlayerViewController()
        
        guard let playerViewController = playerViewController else { return }
        playerViewController.player = player
        
        // 현재 뷰 컨트롤러에서 재생 화면 표시
        present(playerViewController, animated: true) {
            self.player?.play()
        }
    }
}
