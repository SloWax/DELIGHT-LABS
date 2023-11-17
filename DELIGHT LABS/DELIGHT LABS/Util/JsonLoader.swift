//
//  JsonLoader.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//

import Foundation

class JsonLoader {
    
    static let shared = JsonLoader()
    
    func loadJson(result: (Result<Data, Error>) -> Void) {
        let fileNm: String = "delightlabs-ios-hometest-mockdata"
        let extensionType = "json"
        let file = Bundle.main.url(forResource: fileNm, withExtension: extensionType)
        
        if let fileLocation = file {
            do {
                let data = try Data(contentsOf: fileLocation)
                result(.success(data))
            } catch {
                print("error: \(error)")
                result(.failure(error))
            }
        }
    }
}
