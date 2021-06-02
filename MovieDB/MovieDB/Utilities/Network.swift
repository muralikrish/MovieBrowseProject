//
//  Network.swift
//  MovieDB
//
//  Created by Teja Bethina on 6/1/21.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias ErrorHandler = (String) -> Void

class Network {
    
    func execute(urlString: String,
                 successHandler: @escaping (Data) -> Void,
                 errorHandler: @escaping ErrorHandler) {
        
        let url = URL(string: urlString)!
        let urlReq = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlReq,
                                   completionHandler: {
                                    (data, urlResponse, error) in
                                    if let error = error {
                                        print("Error: ", error.localizedDescription)
                                        errorHandler(Constants.errorMsg)
                                        return
                                    }
                                    if let data = data {
                                        successHandler(data)
                                    }}
        ).resume()
    }
}
