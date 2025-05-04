import UIKit
import RxSwift

let bag = DisposeBag()
let animals = ["🐶", "🐱", "🐭", "🐰", "🐯", "🦁", "🐮"]
let fruits = ["🍏", "🍎", "🍐", "🍊", "🍌", "🍇"]
var flag = true

let factory = Observable.deferred {
    flag.toggle()
    
    if flag {
        return Observable.from(animals)
    } else {
        return Observable.from(fruits)
    }
}

factory.subscribe { print($0) }
    .disposed(by: bag)

factory.subscribe { print($0) }
    .disposed(by: bag)

factory.subscribe { print($0) }
    .disposed(by: bag)
