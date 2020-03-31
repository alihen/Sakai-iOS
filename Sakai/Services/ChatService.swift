//
//  ChatService.swift
//  Sakai
//
//  Created by Alastair Hendricks on 2020/03/31.
//

import Foundation

public class ChatService {

    public func getChatChannels(siteId: String, completion: @escaping NetworkServiceResponse<SakaiChatChannelCollection>) {
        SakaiAPIClient.shared.session.prepAuthedRoute { (sessionResult) in
            if let authError = sessionResult.error {
                completion(.failure(authError))
                return
            }

            sakaiProvider.request(.chatChannels(siteId)) { result in
                completion(ResponseHelper.handle(SakaiChatChannelCollection.self, result: result))
            }
        }
    }
}
