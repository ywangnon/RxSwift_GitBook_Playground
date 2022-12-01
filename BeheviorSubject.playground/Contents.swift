import UIKit
import RxSwift


let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let p = PublishSubject<Int>()

p.subscribe { print("PublishSubject >> $0") }
    .disposed(by: disposeBag)

let b = BehaviorSubject<Int>(value: 0)

b.subscribe { print("BehaviorSubject >>", $0) }
    .disposed(by: disposeBag)

b.onNext(1)

b.onNext(2)

b.subscribe { print("BehaviorSubject2 >>", $0) }
    .disposed(by: disposeBag)

b.onCompleted()

b.subscribe { print("BehaviorSubject3 >>", $0) }
    .disposed(by: disposeBag)
