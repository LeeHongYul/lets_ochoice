import Foundation
import AVKit

class PlayMovieViewModel {
    
    private let movieUrl: String
    private var player: AVPlayer?
    private var playerViewController: AVPlayerViewController?
    
    init(movieUrl: String) {
        self.movieUrl = movieUrl
    }
    
    func setupPlayer(completion: @escaping (AVPlayerViewController) -> Void) {
        guard let url = URL(string: movieUrl) else {
            print("Error: Invalid movie URL")
            return
        }
        
        player = AVPlayer(url: url)
        playerViewController = AVPlayerViewController()
        
        guard let playerViewController = playerViewController else {
            print("Error: Unable to create AVPlayerViewController")
            return
        }
        
        playerViewController.player = player
        completion(playerViewController)
    }
}

