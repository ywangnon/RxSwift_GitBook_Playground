import UIKit
import RxSwift

let bag = DisposeBag()

Observable<Void>.empty()
    .subscribe { print($0) }
    .disposed(by: bag)
