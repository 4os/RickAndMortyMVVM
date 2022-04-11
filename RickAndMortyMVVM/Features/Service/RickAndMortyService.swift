//
//  RickAndMortyService.swift
//  RickAndMortyMVVM
//
//  Created by Machine on 11.04.2022.
//

import Alamofire

enum RickMortyServiceEndPoint: String {
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    
    static func characterPath() -> String {
        
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickAndMortyService {
    func fetchAllDatas(response: @escaping ([Result]?) -> Void)
        
}

struct RickMortyService: IRickAndMortyService {
    func fetchAllDatas(response: @escaping ([Result]?) -> Void) {
        AF.request(RickMortyServiceEndPoint.characterPath()).responseDecodable(of: PostModel.self) { (model) in
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.results)
        }
    }
}
