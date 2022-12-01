import UIKit
import RxSwift

let disposeBag = DisposeBag()

enum MyError: Error {
    case error
}

let rs = ReplaySubject<Int>.create(bufferSize: 3)

(1...10).forEach { rs.onNext($0) }

rs.subscribe { print("Observer 1 >>", $0) }
    .disposed(by: disposeBag)

rs.subscribe { print("Observer 2 >>", $0) }
    .disposed(by: disposeBag)

rs.onNext(11)

rs.subscribe { print("Observer 3 >>", $0) }
    .disposed(by: disposeBag)

//rs.onCompleted()
rs.onError(MyError.error)

rs.subscribe { print("Observer 4 >>", $0) }
    .disposed(by: disposeBag)

