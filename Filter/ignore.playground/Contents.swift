import UIKit
import RxSwift

let bag = DisposeBag()
let fruits = ["🍏", "🍎", "🍐", "🍊", "🍌", "🍇"]
let numbsers = [1,2,3,4,5,6,7,8,9,10]

enum MyError: Error {
    case error
}

// ignoreElements
Observable.from(fruits)
    .ignoreElements()
    .subscribe { print($0) }
    .disposed(by: bag)
//completed

//element(at:)
Observable.from(fruits)
    .element(at: 1)
    .subscribe { print($0) }
    .disposed(by: bag)

//filter
Observable.from(numbsers)
    .filter { $0.isMultiple(of: 2) }
    .subscribe { print($0) }
    .disposed(by: bag)

//skip
print("skip")
Observable.from(numbsers)
    .skip(3)
    .subscribe { print($0) }
    .disposed(by: bag)

//skip(while:)
print("skip while")
Observable.from(numbsers)
    .skip(while: { !$0.isMultiple(of: 2) })
    .subscribe { print($0) }
    .disposed(by: bag)

//skip(until:)
print("skip until")

let subject = PublishSubject<Int>()
let trigger = PublishSubject<Int>()

subject.skip(until: trigger)
    .subscribe { print($0) }
    .disposed(by: bag)

subject.onNext(1)

trigger.onNext(0)

subject.onNext(2)

// next(2) - 트리거의 next이벤트가 있기 전의 요소는 무시, 트리거의 next이벤트 무시

//take
print("take")
Observable.from(numbsers)
    .take(5)
    .subscribe { print($0) }
    .disposed(by: bag)

//take(while:)
print("take(while:)")
Observable.from(numbsers)
    .take(while: { !$0.isMultiple(of: 2) })
    .subscribe { print($0) }
    .disposed(by: bag)

//take(until:)
print("take until")

let takeSubject = PublishSubject<Int>()
let takeTrigger = PublishSubject<Int>()

takeSubject.take(until: takeTrigger)
    .subscribe { print($0) }
    .disposed(by: bag)

takeSubject.onNext(1)
takeSubject.onNext(2)

takeTrigger.onNext(0)

takeSubject.onNext(3)

//takeLast
print("take last")

let lastSubject = PublishSubject<Int>()
let lastTrigger = PublishSubject<Int>()

lastSubject.takeLast(2)
    .subscribe { print($0) }
    .disposed(by: bag)

numbsers.forEach { lastSubject.onNext($0) }

lastSubject.onNext(11)

//lastSubject.onCompleted()

lastSubject.onError(MyError.error)

//Single
print("single")
Observable.just(1)
    .single()
    .subscribe { print($0) }
    .disposed(by: bag)

Observable.from(numbsers)
//    .single()
    .single { $0 == 4 }
    .subscribe { print($0) }
    .disposed(by: bag)

let singleSubject = PublishSubject<Int>()

singleSubject.single()
    .subscribe { print($0) }
    .disposed(by: bag)

singleSubject.onNext(100)
singleSubject.onError(MyError.error)

// distinctUntileChanged
let distinctNumbsers = [1,1,3,2,2,3,1,5,5,6,7,7,7]

Observable.from(distinctNumbsers)
    .distinctUntilChanged()
    .subscribe { print($0) }
    .disposed(by: bag)

// debounce
let buttonTap = Observable.create { observer in
    DispatchQueue.global().async {
        for i in 1...10 {
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.3)
        }
        
        Thread.sleep(forTimeInterval: 3.2)
        
        for i in 11...20 {
            observer.onNext("Tap \(i)")
            Thread.sleep(forTimeInterval: 0.5)
        }
        
        observer.onCompleted()
    }
    
    return Disposables.create {
        
    }
}
//print("debounce")
//buttonTap
//    .debounce(.milliseconds(1000), scheduler: MainScheduler.instance)
//    .subscribe { print($0) }
//    .disposed(by: bag)

// throttle
print("throthle")
buttonTap
    .throttle(.milliseconds(1000), latest: true, scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: bag)
