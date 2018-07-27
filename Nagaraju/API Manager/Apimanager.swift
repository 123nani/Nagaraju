import Foundation
import UIKit
typealias CompletionHandler = (_ response : NSDictionary?, _ error : Error?) -> Void
class Apimanager  {
    
static let sharedInstance = Apimanager()
    
func getCategoriesMethod(handler : @escaping CompletionHandler) {
    
    let urlString = "https://stark-spire-93433.herokuapp.com/json" // URL
    
    let url = URL(string: urlString)!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            // check for fundamental networking error
            print("error=\(error!)")
            return
        }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(response!)")
        }
        
        //  let responseString = String(data: data, encoding: .utf8)
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            
            handler(json,nil)
            
        } catch let error as NSError {
            print(error)
            
            handler(nil,error)
        }
        
    }
    task.resume()
    
}
}
