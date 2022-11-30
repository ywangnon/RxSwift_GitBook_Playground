import UIKit
import RxSwift

let subscription1 = Observable.from([1,2,3])
    .subscribe(onNext: { elem in
        print("Next", elem)
    }, onError: { error in
        print("Error", error)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: {
        print("Disposed")
    })
// 메모리 해제
subscription1.dispose()

// bag으로 담아서 한 번에 해제하는 것이 좋음
var bag = DisposeBag()

Observable.from([1,2,3])
    .subscribe({
        print($0)
    })
    .disposed(by: bag)

// DisposeBag이 해제되는 시점에서 모두 메모리 해제 됨. auto releasepool과 같음

let subscription2 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .subscribe(onNext: { elem in
        print("Next", elem)
    }, onError: { error in
        print("Error", error)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: {
        print("Disposed")
    })

DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3, execute: {
    subscription2.dispose()
})

// dispose 이후에는 즉시 메모리에서 해제. 즉시 해제하기 때문에 complete 작동 안함. 고로 특정 시점 이후 해제하는 것은 takeuntil 사용. 
