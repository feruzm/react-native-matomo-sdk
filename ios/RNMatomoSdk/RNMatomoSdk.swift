import Foundation
import MatomoTracker

@objc(RNMatomoSdk)
class RNMatomoSdk: NSObject {
    var tracker:MatomoTracker?

    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }

    @objc(initialize:siteId:resolver:rejecter:)
    func initialize(
        apiUrl: String,
        siteId: NSNumber,
        resolver: RCTPromiseResolveBlock,
        rejecter: RCTPromiseRejectBlock
    ) -> Void {
        do {
            tracker = MatomoTracker(siteId: siteId.stringValue, baseURL: URL(string: apiUrl)!)
            resolver(nil)
        } catch let error {
            rejecter("tracker_failure", "Tracker operation failed", error)
        }
    }

    @objc(trackView:resolver:rejecter:)
    func trackView(
        route: Array<String>,
        resolver: RCTPromiseResolveBlock,
        rejecter: RCTPromiseRejectBlock
    ) -> Void {
        do {
            if let tracker = tracker {
                tracker.track(view: route)
                resolver(nil)
            } else {
                rejecter("not_initialized", "The tracker has not been initialized", NSError())
            }
        } catch let error {
            rejecter("tracker_failure", "Tracker operation failed", error)
        }
    }

    @objc(trackEvent:action:optionalParameters:resolver:rejecter:)
    func trackEvent(
        category: String,
        action: String,
        optionalParameters: NSDictionary,
        resolver: RCTPromiseResolveBlock,
        rejecter: RCTPromiseRejectBlock
    ) -> Void {
        do {
            if let tracker = tracker {
                tracker.track(eventWithCategory: category,
                              action: action,
                              name: optionalParameters.value(forKey:"name") as? String,
                              number: optionalParameters.value(forKey:"value") as? NSNumber
                )
                resolver(nil)
            } else {
                rejecter("not_initialize", "The tracker has not been initialized", NSError())
            }
        } catch let error {
            rejecter("tracker_failure", "Tracker operation failed", error)
        }
    }
}
