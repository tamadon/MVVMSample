//
//  ViewModel.swift
//

import RxSwift
//import SwiftyJSON

import Alamofire

public final class ViewModel {
    
    private(set) var tracks = Variable<[Track]>([])
    
    let disposeBag = DisposeBag()
    
    // MARK: - Public
    
    public func fetch() {
        self.send()
            .subscribe { [weak self] (event) -> Void in
                switch event {
                case .Next(let value):
                    self?.tracks.value = value
                case .Error(_):
                    ()
                case .Completed:
                    ()
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    // MARK: - Private
    
    // TODO: ここもクラス化
    private func send() -> Observable<[Track]> {
        return Observable.create{ (observer) in
            
            APIClient<[Track]>().iTunesSearch(["term" : "larcenciel", "country" : "jp"]) { (response) -> () in
                switch response {
                case .Success(let result):

                    print(result)

                    let tracks = result

                    observer.on(.Next(tracks))
                    observer.on(.Completed)

                    break
                case .Error(let error):
                    print(error)
                    break
                }
            }
            
            return AnonymousDisposable {}
        }
    }
}

