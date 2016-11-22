import RxSwift

func forwardToObserver<T, V>(_ observer: AnyObserver<(T, V)>) -> (T?, V?, Error?) -> Void {
    return { first, second, error in
        if error != nil {
            observer.onError(error!)
        } else {
            observer.onNext((first!, second!))
            observer.onCompleted()
        }
    }
}

func forwardToObserver<Result>(_ observer: AnyObserver<Result>) -> (Result?, Error?) -> Void {
    return { result, error in
        if error != nil {
            observer.onError(error!)
        } else {
            observer.onNext(result!)
            observer.onCompleted()
        }
    }
}

func forwardToObserver<Result>(_ observer: AnyObserver<Result>) -> (Error?) -> Void {
    return { error in
        if error != nil {
            observer.onError(error!)
        } else {
            observer.onCompleted()
        }
    }
}

func forwardToObserver<Result>(_ observer: AnyObserver<Result>) -> (Result, Error?) -> Void {
    return { result, error in
        if error != nil {
            observer.onError(error!)
        } else {
            observer.onNext(result)
            observer.onCompleted()
        }
    }
}