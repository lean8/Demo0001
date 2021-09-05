//
//  Show.swift
//  Demo0001
//
//  Created by lean on 2021/9/2.
//

import Foundation


final class ShowAPI {
    static let shared = ShowAPI()
    
    func fetchShowList(onCompletion: @escaping ([ShowData]) -> ()) {
        let urlString = "https://api.jikan.moe/v3/top/anime"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                print("data was nil")
                return
            }
            guard let showList = try? JSONDecoder().decode(ShowList.self, from: data) else {
                print("could't decode json")
                return
            }
            onCompletion(showList.top)
    }
        task.resume()
 }
}

 struct ShowList: Codable{
    
//    let request_hash: String
//    let request_cached: Bool
//    let request_cache_expiry: Int
    
     let top: [ShowData]
}

 struct ShowData: Codable {
     let mal_id: Int
     let image_url: String
     let title: String
     let score: Double
     let rank: Int
     let url: String
     let type: String
     let start_date: String
     let end_date: String
     let members: Int
     let episodes: Int
}


