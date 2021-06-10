import Lottie

extension AnimationView {
    enum AnimationType: String {
        case emailSuccess = "email-success"
        case loadingIndicator = "loading-indicator"
        case congratsTick = "congrats-tick"
    }

    func getAnimation(for type: AnimationType) -> Animation {
        guard let animation = Animation.named(type.rawValue, animationCache: LRUAnimationCache.sharedCache) else {
            fatalError("Animation asset is missing")
        }
        return animation
    }
}
