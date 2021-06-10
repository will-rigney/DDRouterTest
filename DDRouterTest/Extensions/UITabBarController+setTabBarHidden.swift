import UIKit

extension UITabBarController {

    func setTabBarHidden(_ hidden: Bool, animated: Bool, duration: TimeInterval = 0.2) {

        // status is the same, don't need to do anything
        guard tabBar.isHidden != hidden else {
            return
        }

        // show the tabbar before the animation in case it has to appear
        if !hidden {
            tabBar.isHidden = false
        }

        // how much of the frame height to add to the current origin
        let factor: CGFloat = hidden
            ? 1
            : 0

        let tabBarY = tabBar.frame.origin.y
        let tabBarHeight = tabBar.frame.size.height
        
        var y = tabBarY + (tabBarHeight * factor)
        
        // if tabBar Y coordinate is at end of screen then adjust y 
        if tabBarY == UIScreen.main.bounds.height {
            y = tabBarY - tabBarHeight
        }

        // simple case, don't need to animate
        guard animated else {
            tabBar.frame = CGRect(
                x: tabBar.frame.origin.x,
                y: y,
                width: tabBar.frame.width,
                height: tabBar.frame.height)
            tabBar.isHidden = hidden
            return
        }

        // animate the change
        UIView.transition(
            with: tabBar,
            duration: duration,
            options: .curveEaseInOut,
            animations: { [weak self] in
                guard let self = self else { return }
                self.tabBar.frame = CGRect(
                    x: self.tabBar.frame.origin.x,
                    y: y,
                    width: self.tabBar.frame.width,
                    height: self.tabBar.frame.height)
            },
            completion: { [weak self] _ in
                // hide the tabbar after the animation in case it has to be hidden
                if hidden {
                    self?.tabBar.isHidden = true
                }
            })
    }
}
