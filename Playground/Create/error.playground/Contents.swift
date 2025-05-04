import UIKit
import RxSwift

let bag = DisposeBag()

enum MyError: Error {
    case error
}

Observable<Void>.error(MyError.error)
    .subscribe { print($0) }
    .disposed(by: bag)

