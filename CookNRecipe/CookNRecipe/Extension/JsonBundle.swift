//
//  JsonBundle.swift
//  CookNRecipe
//
//  Created by Olivia Gita Amanda Lim on 8/9/2024.
//

import Foundation
//extension Bundle {
//    //Custom function to decode JSON files from the bundle into a Decodable type
//    func decode<T: Decodable>(filename: String, as type: T.Type) -> T {
//        //Step 1: Attempt to locate the file in the bundle
//        guard let url = self.url(forResource: filename, withExtension: nil) else {
//            //If the file is not found, trigger a fatal error with descriptive message
//            fatalError("Error --> There is no \(filename) in Bundle")
//        }
//        //Step 2: Attempt to read you added "do the file into a Data object
//        guard let data = try? Data(contentsOf: url) else {
//            //If reading the file fails, trigger a fatal error with an error message
//            fatalError("Error --> Can't load the data from \(url).")
//        }
//        //Step 3: Attempt to decode the data object into an instance of the provided type
//        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
//            //If the decoding fails, trigger a fal error with an error message
//            fatalError("Error --> Fail to decode data")
//        }
//        //Step 4: Return the decoded data
//        return decodedData
//    }
//}
