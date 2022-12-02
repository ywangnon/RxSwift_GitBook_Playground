import UIKit
import RxSwift

let bag = DisposeBag()
let apple = "apple"
let orange = "orange"
let kiwi = "kiwi"

Observable.of(apple, orange, kiwi)
    .subscribe { element in
        print(element)
    }
    .disposed(by: bag)

Observable.of([1,2], [3,4], [5,6])
    .subscribe { element in
        print(element)
    }
    .disposed(by: bag)
