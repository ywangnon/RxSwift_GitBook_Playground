import UIKit
import RxSwift

let bag = DisposeBag()
let element = "^^"

enum MyError: Error {
    case error
}

Observable.just(element)
    .subscribe { event in
        print(event)
    }
    .disposed(by: bag)

Observable.just([1,2,3])
    .subscribe { event in
        print(event)
    }
    .disposed(by: bag)

