import UIKit
import RxSwift

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let subject = AsyncSubject<Int>()

subject.subscribe { print($0) }
    .disposed(by: bag)

subject.onNext(1)
subject.onNext(2)
subject.onNext(3)

//subject.onCompleted()
subject.onError(MyError.error)
