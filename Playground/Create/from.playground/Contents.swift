import UIKit
import RxSwift

let bag = DisposeBag()
let fruits = ["apple", "mango", "딸기", "포도"]

Observable.from(fruits)
    .subscribe { element in
        print(element)
    }
    .disposed(by: bag)
