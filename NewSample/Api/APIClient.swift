//
//  APIClient.swift
//

import Alamofire
import ObjectMapper

enum Result<T> {
    case Success(T)
    case Error(NSError)
}

class APIClient<T> {
    // iTunes検索
    func iTunesSearch(params : [String: AnyObject], completionHandler: (Result<T>) -> () = {_ in}) {
        
        Alamofire.request(Router.apiSearch(params))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    print("\(response.result.value)")
                    if let resp: [Track] = Mapper<Track>().mapArray(response.result.value?["results"]) {
                        completionHandler(Result<T>.Success(resp as! T))
                    }
                case .Failure(let error):
                    completionHandler(Result<T>.Error(error))
                }
        }
    }
}

enum Router: URLRequestConvertible {
    static let baseURLString = "https://itunes.apple.com"
    
    case apiSearch([String: AnyObject])
    
    var URLRequest: NSMutableURLRequest {
        
        let URL = NSURL(string: Router.baseURLString)
        
        let (method, path, parameters) : (String, String, [String: AnyObject]) = {
            
            switch self {
            // iTunes検索
            case .apiSearch(let params):
                return ("GET", "/search", params)
            }
        }()
        
        let URLRequest = NSMutableURLRequest(URL: URL!.URLByAppendingPathComponent(path)!)
        URLRequest.HTTPMethod = method
        let encoding = Alamofire.ParameterEncoding.URL
        print("encode:\(encoding.encode(URLRequest, parameters: parameters).0)")
        return encoding.encode(URLRequest, parameters: parameters).0
    }
}
