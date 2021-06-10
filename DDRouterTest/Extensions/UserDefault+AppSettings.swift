import Foundation

extension UserDefaults {

    /// A change in the value of root.plist properties eg: user_real_apis, the toggle reflects accordingly in Settings app, but the value behind it is not in sync
    /// This function is used to sync DefaultValues with Root.plist in Settings.Bundle at the start of the app launch
    /**
     todo: this seems like it would be really useful for ddmock
     */
    static func registerDefaultValuesToAppSettings() {

        // Access all properties/preferences of this app in Settings (settings.bundle)
        guard let rootPath = Bundle.main.url(forResource: Constants.PropertyList.settings.rawValue, withExtension: "bundle")?.appendingPathComponent(Constants.PropertyList.rootPlistName.rawValue),
            let settingsPlist = NSDictionary(contentsOf: rootPath),
            let preferences = settingsPlist[Constants.PropertyList.preferenceSpecifiers.rawValue] as? [NSDictionary] else {
            return
        }
        var defaultsToRegister: [String: Any] = [:]

        for preference in preferences {
            guard let key = preference[Constants.PropertyList.key.rawValue] as? String else {
                continue
            }
            defaultsToRegister[key] = preference[Constants.PropertyList.defaultValue.rawValue]
        }
        // Register UserDefaults to the values found in Settings (settings.bundle)
        UserDefaults.standard.register(defaults: defaultsToRegister)
    }
}
