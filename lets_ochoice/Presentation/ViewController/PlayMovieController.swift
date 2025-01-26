import UIKit

class PlayMovieController: UIViewController {
    
    private let playViewModel: PlayMovieViewModel
    
    init(movieUrl: String) {
        self.playViewModel = PlayMovieViewModel(movieUrl: movieUrl)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        // 동영상 재생 시작
        playViewModel.setupPlayer { [weak self] playerViewController in
            guard let self = self else { return }
            self.present(playerViewController, animated: true) {
                playerViewController.player?.play()
            }
        }
    }
}
