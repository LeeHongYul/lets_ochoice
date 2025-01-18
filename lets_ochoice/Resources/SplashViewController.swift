import UIKit

class SplashViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star.fill") // SF Symbols 아이콘 설정
        imageView.tintColor = .systemBlue // 아이콘 색상
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupImageView()
        //navigateToNextScreen()
    }

    private func setupImageView() {
        view.addSubview(imageView)

        // Auto Layout 설정
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func navigateToNextScreen() {
        // 2초 후 실행
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let mainViewController = MainViewController() // 메인 화면 ViewController
            let navigationController = UINavigationController(rootViewController: mainViewController)
            navigationController.modalTransitionStyle = .crossDissolve
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}


