import Foundation

class ArticleRoutingHelper {
    static func getRoute(item: JourneyItem, lastArticleId: String, isPersonaJourney: Bool) -> HomeCoordinator.Route {
        // Determine if it is an article or question type
        // to redirect user to correct route
        if item.isProfileBuilderType {
            //direct to profile builder complete if profile builder question has already been answered
             return item.isAnswered == true
                ? .profileBuilderComplete(item: item, lastArticleId: lastArticleId, isPersonaJourney: isPersonaJourney)
                : .profileBuilderQuestion(item: item, lastArticleId: lastArticleId, isPersonaJourney: isPersonaJourney)
        } else {
            return .articleContent(currentJourneyItem: item, lastArticleId: lastArticleId, isPersonaJourney: isPersonaJourney)
        }
    }
}
