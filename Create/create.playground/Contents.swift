import UIKit
import RxSwift

let bag = DisposeBag()


enum MyError: Error {
    case error
}

Observable<String>.create { observer -> Disposable in
    guard let url = URL(string: "https://www.apple.com") else {
        observer.onError(MyError.error)
        
        // 주의 Disposable은 타입이고, Disposables에서 생성한 값 하나가 disposable이 된다.
        return Disposables.create()
    }
    
    guard let html = try? String(contentsOf: url, encoding: .utf8) else {
        observer.onError(MyError.error)
        return Disposables.create()
    }
    // 요소를 방출할 때는 onNext 사용
    observer.onNext(html)
    observer.onCompleted()
    // 종료를 위해서는 onError, onComplete 반드시 호출해야 함
    
    // 종료되면 반응 없음
    observer.onNext("After complete")
    
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: bag)
