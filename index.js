import { NativeModules } from "react-native";
const { RNMatomoSdk } = NativeModules;

export function initialize(apiUrl, siteId) {
  return RNMatomoSdk.initialize(apiUrl, siteId);
}

export function trackView(route, url) {
  return RNMatomoSdk.trackView(route, url);
}

export function trackEvent(category, event, url, name, value) {
  return RNMatomoSdk.trackEvent(category, event, url, { name: name, value: value });
}

export function setCustomDimension(id, value) {
  return RNMatomoSdk.setCustomDimension(id, value);
}

export function setUserId(userId) {
  return RNMatomoSdk.setUserId(userId);
}

export default {
  initialize: initialize,
  trackView: trackView,
  trackEvent: trackEvent,
  setUserId: setUserId,
  setCustomDimension: setCustomDimension,
};
