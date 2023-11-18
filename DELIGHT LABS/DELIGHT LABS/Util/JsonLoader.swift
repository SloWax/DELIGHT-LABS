//
//  JsonLoader.swift
//  DELIGHT LABS
//
//  Created by 표건욱 on 2023/11/17.
//

import Foundation
import RxSwift

class JsonLoader {
    
    static let shared = JsonLoader()
    
    func loadJson()-> Observable<Data> {
        return Observable.create() { observer in
            DispatchQueue.global().async {
                let fileNm: String = "delightlabs-ios-hometest-mockdata"
                let extensionType = "json"
                let file = Bundle.main.url(forResource: fileNm, withExtension: extensionType)
                
                if let fileLocation = file {
                    do {
                        let data = try Data(contentsOf: fileLocation)
                        observer.onNext(data)
                    } catch {
                        print("error: \(error)")
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
    }
}
