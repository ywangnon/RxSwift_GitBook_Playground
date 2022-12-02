import UIKit
import RxSwift

let bag = DisposeBag()

Observable.range(start: 1, count: 10)
    .subscribe {
        print($0)
    }
    .disposed(by: bag)

