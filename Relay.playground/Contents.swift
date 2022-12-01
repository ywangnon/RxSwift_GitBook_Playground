import UIKit
import RxSwift
import RxCocoa

let bag = DisposeBag()

enum MyError: Error {
    case error
}

let prelay = PublishRelay<Int>()
prelay.subscribe { print("1: \($0)") }
    .disposed(by: bag)

prelay.accept(1)

let brelay = BehaviorRelay(value: 1)
brelay.accept(2)

brelay.subscribe { print("2: \($0)") }
    .disposed(by: bag)

brelay.accept(3)

print(brelay.value)
