<h1 align="center">Sakai-iOS</h1>

<p align="center">
    <a href="https://travis-ci.org/github/alihen/Sakai-iOS">
        <img src="https://travis-ci.org/alihen/Sakai-iOS.svg?branch=master" alt="Travis-CI" />
    </a>
    <a href="https://codecov.io/gh/alihen/Sakai-iOS">
        <img src="https://codecov.io/gh/alihen/Sakai-iOS/branch/master/graph/badge.svg" />
    </a>
    <a href="https://cocoapods.org/pods/Sakai">
        <img src="https://img.shields.io/cocoapods/v/Sakai.svg" alt="CocoaPods" />
    </a>
    <a href="https://twitter.com/ali_hen">
    <img src="https://img.shields.io/badge/contact-@ali_hen-purple.svg?style=flat" alt="Twitter: @ali_hen" />
    </a>
</p>

Sakai-iOS provides an easy way to build out a [Sakai LMS](https://github.com/sakaiproject/sakai) learning experience within an iOS app.

**Sakai-iOS is currently in Alpha and has limited support for the Sakai `/direct` API. Refer to the [docs](docs/VISION.md) and issues for more informations.**

## How to use Sakai-iOS
Initialize the Sakai instance with the instance configuration and a login details.
```swift
let configuration = SakaiConfiguration(baseURL: URL(string: "https://example-sakai.com")!)
Sakai.shared.start(
    configuration: configuration,
    username: "STUDENT001",
    password: "password")
```

To ensure that the user's details are valid, log the user in.
```swift
Sakai.shared.session.loginUser(
    username: "STUDENT001", 
    password: "password", 
    completion: { sessionResult in
                    // Get the result from sessionResult
    })
```

The following actions are currently supported:
- Get Recent Announcements
- Get Announcement by ID
- Get Site Announcements
- Get Sites
- Get Site by ID
- Get Session
- Get Site Resources
- Get User Profile
- Get Chat Channels
- Get Chat Messages

Don't see an action that you need? First read our [docs](docs/VISION.md), and then submit an issue. If you feel like implementing the action yourself, go ahead and submit a PR. 🎉

Looking for more integration documentation? Check out the tests for end-to-end integration tests that demonstrate all the supported actions.

## Testing compatibility with your Sakai Instance

You will be able to run the example project's test suite in order to test compatibility with your Sakai instance.

The variables which the tests use are taken from environmental variables from the machine. Ensure you set the following environmental variables in the environment you run the tests in.

```bash
export SAKAI_TEST_BASE_URL=https://example-instance.com
export SAKAI_TEST_USERNAME=STUDENT001
export SAKAI_TEST_PASSWORD=password
export SAKAI_TEST_SITE_ID=a-test-site-id
export SAKAI_TEST_ANNOUNCEMENT_ID=a-test-announcement-id-the-user-can-access
export SAKAI_TEST_FOLDER_NAME=a-folder-name-in-the-test-sites-resources
export SAKAI_TEST_CHAT_CHANNEL_ID=valid-chat-channel-id
```

## Examples

- [Sharing a session to a WKWebView](docs/sessions.md)

## Requirements

- Swift 5
- Tested on Sakai 11, 12 & 19

## Installation

Sakai is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Sakai', '~> 0.0.5'
```

## Author

Alastair Hendricks - [@ali_hen](https://twitter.com/ali_hen)

## License

Sakai is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
