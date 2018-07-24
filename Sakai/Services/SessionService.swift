//
//  SessionService.swift
//  Alamofire
//
//  Created by Alastair Hendricks on 2018/05/25.
//

import Foundation

public class SessionService {

    public func prepAuthedRoute(completion: @escaping (Result<SakaiSession?>) -> Void) {
        if Sakai.shared.ensureUserIsAuthorized() {
            completion(.success(nil))
            return
        }

        guard
            let username = Sakai.shared.username,
            let password = Sakai.shared.password else {
                print("Configure your Sakai instance with a configuration and login details before using the service.")
                return
        }

        self.loginUser(username: username, password: password) { (sessionResult) in
            if sessionResult.error != nil {
                completion(.failure(sessionResult.error!))
                return
            }
            completion(.success(nil))
            return
        }
    }

    public func loginUser(username: String, password: String, completion: @escaping (Result<SakaiSession?>) -> Void) {
        sakaiProvider.request(.session(username, password)) { response in
            if let responseError: Error = response.error {
                completion(.failure(responseError))
                return
            }

            self.getSession(completion: { (sessionResult) in
                if let sessionError: Error = sessionResult.error {
                    completion(.failure(sessionError))
                    return
                }
                Sakai.shared.loggedInUserSession = sessionResult.result
                Sakai.shared.username = username
                Sakai.shared.password = password
                completion(.success(sessionResult.result))
            })
        }
    }

    public func getSession(completion: @escaping (Result<SakaiSession>) -> Void) {
        sakaiProvider.request(.sessionCurrent) { result in
            do {
                let response = try result.dematerialize()
                let session = try response.map(SakaiSession.self)
                completion(.success(session))
                return
            } catch {
                completion(.failure(error))
                return
            }
        }
    }

    public func getUserData(completion: @escaping (Result<Data>) -> Void) {
        sakaiProvider.request(.userCurrent) { result in
            do {
                let response = try result.dematerialize()
                let data = response.data
                completion(.success(data))
                return
            } catch {
                completion(.failure(error))
                return
            }
        }
    }

    public func getUser(completion: @escaping (Result<SakaiUser>) -> Void) {
        self.getUserData { (result: Result<Data>) in
            switch result {
            case .success(let response):
                do {
                    let user = try JSONDecoder().decode(SakaiUser.self, from: response)
                    completion(.success(user))
                    return
                } catch {
                    completion(.failure(error))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
}

