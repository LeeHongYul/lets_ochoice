import UIKit

extension UIViewController {
    func showToast(message: String, font: UIFont = .systemFont(ofSize: 14)) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true

        let textSize = toastLabel.intrinsicContentSize
        let padding: CGFloat = 20
        let width = min(textSize.width + padding * 2, self.view.frame.width - 40)
        let height = textSize.height + padding
        toastLabel.frame = CGRect(x: (self.view.frame.width - width) / 2, y: self.view.frame.height - 100, width: width, height: height)

        self.view.addSubview(toastLabel)

        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
}

