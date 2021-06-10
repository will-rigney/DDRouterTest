import Foundation
import UIKit

// todo: remove logout requirements or move into a library
protocol Coordinator {
    associatedtype Route
    associatedtype RootViewController: UIViewController

    var root: RootViewController { get }
    func trigger(route: Route)
}

protocol ChildCoordinator: Coordinator, LogoutCoordinator {
    associatedtype Parent: Coordinator

    var parent: Parent? { get set }
}

extension Coordinator {
    func dismiss() {
        root.dismiss(animated: true)
    }
}

extension Coordinator where RootViewController: UINavigationController {
    func back() {
        root.popViewController(animated: true)
    }
}

// todo: this should only be coordinators, definitely not AnyObject
protocol LogoutCoordinator: AnyObject {
    func logout()
}

extension ChildCoordinator {
    func logout() {
        if let parent = parent as? LogoutCoordinator {
            parent.logout()
        }
    }
}
