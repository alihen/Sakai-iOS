//
//  SessionService.swift
//  Alamofire
//
//  Created by Alastair Hendricks on 2018/05/25.
//

import Foundation

public class SessionService {

    public func prepAuthedRoute(completion: @escaping NetworkServiceResponse<SakaiSession?>) {
        if SakaiAPIClient.shared.ensureUserIsAuthorized() {
            completion(.success(nil))
            return
        }

        guard
            let username = SakaiAPIClient.shared.username,
            let password = SakaiAPIClient.shared.password else {
                assertionFailure("Configure your Sakai instance with a configuration and login details before using the service.")
                return
        }

        self.loginUser(username: username, password: password) { sessionResult in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            completion(.success(nil))
            return
        }
    }

    public func loginUser(username: String, password: String, completion: @escaping NetworkServiceResponse<SakaiSession>) {
        sakaiProvider.request(.session(username, password)) { response in
            let loginStatusCode = response.value?.statusCode
            if loginStatusCode != 201 {
                let error = SakaiError.init(kind: .client, code: loginStatusCode, localizedDescription: response.error?.errorDescription, title: "An error occurred", message: nil)
                completion(.failure(error))
                return
            }


            self.getSession(completion: { (sessionResult) in
                if sessionResult.error != nil {
                    completion(sessionResult)
                    return
                }

                SakaiAPIClient.shared.loggedInUserSession = sessionResult.value
                SakaiAPIClient.shared.username = username
                SakaiAPIClient.shared.password = password
                completion(sessionResult)
                return
            })
        }
    }

    public func getSession(completion: @escaping NetworkServiceResponse<SakaiSession>) {
        sakaiProvider.request(.sessionCurrent) { result in
            completion(ResponseHelper.handle(SakaiSession.self, result: result))
        }
    }

    public func getUser(completion: @escaping NetworkServiceResponse<SakaiUser>) {
        sakaiProvider.request(.userCurrent) { result in
            completion(ResponseHelper.handle(SakaiUser.self, result: result))
        }
    }
}

