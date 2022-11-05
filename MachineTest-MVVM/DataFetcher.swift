//
//  DataFetcher.swift
//  MachineTest-MVVM
//
//  Created by Mac on 05/11/22.
//

import Foundation

class DataFetcher{
    
    static let shared = DataFetcher()
    let urlString = "https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0"
    
    func getData(completion: @escaping (Response)->()){
        
        let apiCall = URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else{
                print("API call failed eith error \(String(describing: error))")
                return
            }
            
            var apiResponse: Response?
            do{
                apiResponse = try JSONDecoder().decode(Response.self, from: data)
            }
            catch{
                print("something went wrong \(error)")
            }
            
            guard let apiData = apiResponse else{
                return
            }
            completion(apiData)
        })
        apiCall.resume()
    }
}

//Model Classes

struct Response: Decodable {
    let status: Bool
    let homeData: [Values]
}

enum Type: String, Codable{
    case category, banners, products
}

struct Category: Codable {
    let id: Int
    let name: String
    let image_url: String
}

struct Banners: Codable {
    let id: Int
    let banner_url: String
}

struct Products: Codable {
    let id: Int
    let name: String
    let image: String
    let actual_price: String
    let offer_price: String
    let offer: Int
    let is_express: Bool
}



enum Values: Decodable {
    
    case category([Category])
    case banners([Banners])
    case products([Products])
    
    private enum ValueKeys: String, CodingKey{
        case type, values
    }
    
    init(from decoder: Decoder) throws {
        let homeData = try decoder.container(keyedBy: ValueKeys.self)
        let types = try homeData.decode(Type.self, forKey: .type)
        switch types {
        case .category:
            let category = try homeData.decode([Category].self, forKey: .values)
            self = .category(category)
        case .banners:
            let banner = try homeData.decode([Banners].self, forKey: .values)
            self = .banners(banner)
        case .products:
            let product = try homeData.decode([Products].self, forKey: .values)
            self = .products(product)
    }
   
}

}
