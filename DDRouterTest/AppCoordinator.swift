import Foundation
import UIKit

// this is the top level - root coordinator

class AppCoordinator: Coordinator {

    enum Route {
        case home
    }

    var root: UIViewController

    init() {
        root = RootViewController()
    }

    func trigger(route: Route) {
        switch route {
        case .home:
            let vc = StoryboardScene.Main.quotesViewController.instantiate()
            vc.vm = QuotesViewModel(coordinator: self)
            root.embed(vc)
        }
    }
    
}
