import UIKit

// todo: document better
extension UINavigationController {
    func addProgressView(progressView: UIProgressView) {

        progressView.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.addSubview(progressView)
        navigationBar.clipsToBounds = false

        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalTo: navigationBar.widthAnchor),
            progressView.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 2.0),
            progressView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor)])
    }
}
