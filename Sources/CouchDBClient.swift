import CouchDB
import RxSwift
import SwiftyJSON

extension CouchDBClient: ReactiveCompatible {}
extension Reactive where Base: CouchDBClient {

    public func dbExists(_ name: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            self.base.dbExists(name, callback: forwardToObserver(observer))
            return Disposables.create()
        }
    }

    public func createDB(_ name: String) -> Observable<Database> {
        return Observable<Database>.create { observer in
            self.base.createDB(name, callback: forwardToObserver(observer))
            return Disposables.create()
        }
    }

    public func deleteDB(_ dbName: String) -> Observable<Void> {
        return Observable<Void>.create { observer in
            self.base.deleteDB(dbName, callback: forwardToObserver(observer))
            return Disposables.create()
        }
    }

    public func getUUIDs(count: UInt) -> Observable<[String]> {
        return Observable<[String]>.create { observer in
            self.base.getUUIDs(count: count, callback: forwardToObserver(observer))
            return Disposables.create()
        }
    }

    public func getUUID() -> Observable<String> {
        return Observable<String>.create { observer in
            self.base.getUUID(callback: forwardToObserver(observer))
            return Disposables.create()
        }
    }

    public func setConfig(keyPath: String, value: CouchDBValue) -> Observable<Void> {
        return Observable<Void>.create { observer in
            self.base.setConfig(keyPath: keyPath, value: value, callback: forwardToObserver(observer))
            return Disposables.create()
        }
    }

    public func getConfig(keyPath: String) -> Observable<JSON> {
        return Observable<JSON>.create { observer in
            self.base.getConfig(keyPath: keyPath, callback: forwardToObserver(observer))
            return Disposables.create()
        }
    }

    public func createSession(name: String, password: String) -> Observable<(String, JSON)> {
        return Observable.create { observer in
            self.base.createSession(name: name, password: password) { cookie, document, error in 
                if error != nil {
                    observer.onError(error!)
                } else {
                    observer.onNext((cookie!, document!))
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }

    public func getSession(cookie: String) -> Observable<(String, JSON)> {
        return Observable.create { observer in
            self.base.getSession(cookie: cookie) { cookie, document, error in 
                if error != nil {
                    observer.onError(error!)
                } else {
                    observer.onNext((cookie!, document!))
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }

    public func deleteSession(cookie: String) -> Observable<(String, JSON)> {
        return Observable.create { observer in
            self.base.deleteSession(cookie: cookie) { cookie, document, error in 
                if error != nil {
                    observer.onError(error!)
                } else {
                    observer.onNext((cookie!, document!))
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }

}