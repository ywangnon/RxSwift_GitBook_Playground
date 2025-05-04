import UIKit
import RxSwift

let bag = DisposeBag()
let element = "❤️"

Observable.repeatElement(element)
    .take(7)
    .subscribe { print($0) }
    .disposed(by: bag)
