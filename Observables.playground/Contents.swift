import UIKit
import RxSwift

let o1 = Observable<Int>.create { (observer) -> Disposable in
    observer.on(.next(0))
    observer.onNext(1)
    
    observer.onCompleted()
    
    // 메모리 정리에 필요한 객체
    return Disposables.create()
}

o1.subscribe {
    print($0)
    
    if let elem = $0.element {
        print(elem)
    }
}

Observable.from(optional: [0, 1])

// #2
o1.subscribe(onNext: { elem in
    print(elem)
})
