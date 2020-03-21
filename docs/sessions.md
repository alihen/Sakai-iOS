## Sakai Sessions

### Sharing a session with a WKWebView
As Sakai uses cookie-based authentication instead of JWTs, you'll need to pass your cookies from the networking library (Alamofire) over to the WKWebView. This can be done by getting the Alamofire cookies and setting them on the `httpCookieStore` of the WKWebView.

Before loading the request, pass the `SessionManager` cookies to the `httpCookieStore`.
```swift
let cookies = Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.cookies  ?? []
for cookie in cookies {
    webview.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
}
loadRequest(url: url)
```
