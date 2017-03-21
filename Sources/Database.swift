import RxSwift
import CouchDB
import SwiftyJSON
import Foundation

extension Database: ReactiveCompatible {}
extension Reactive where Base: Database {

    public func retrieve(_ id: String) -> Observable<JSON> {
        return Observable<JSON>.create { observer in
            self.base.retrieve(id, callback: forwardToObserver(observer))
            return Disposables.create()
        }
    }

    public func retrieveAll(includeDocuments: Bool = false) -> Observable<JSON> {
        return Observable<JSON>.create { observer in
            self.base.retrieveAll(includeDocuments: includeDocuments, callback: forwardToObserver(observer))
            return Disposables.create()
        } 
    }

    public func update(_ id: String, rev: String, document: JSON) -> Observable<(String, JSON)> {
        return Observable<(String, JSON)>.create { observer in
            self.base.update(id, rev: rev, document: document) { rev, document, error in
               if error != nil {
                    observer.onError(error!)
                } else {
                    observer.onNext(rev!, document!)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }

    public func delete(_ id: String, rev: String, failOnNotFound: Bool = false) -> Observable<Void> {
        return Observable<Void>.create { observer in
            self.base.delete(id, rev: rev, failOnNotFound: failOnNotFound, callback: forwardToObserver(observer))
            return Disposables.create()
        }
    }

    public func create(_ json: JSON) -> Observable<JSON> {
        return Observable<JSON>.create { observer in
            self.base.create(json) { id, rev, document, error in
                if error != nil {
                    observer.onError(error!)
                } else {
                    observer.onNext(document!)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }

    public func queryByView(_ view: String, ofDesign design: String, 
            usingParameters parameters: [Database.QueryParameters] = []) -> Observable<JSON> {
        return Observable<JSON>.create { observer in
            self.base.queryByView(view, ofDesign: design, usingParameters: parameters, callback: forwardToObserver(observer))
            return Disposables.create()
        }
    }

    public func createDesign(_ designName: String, document: JSON) -> Observable<JSON> {
        return Observable<JSON>.create { observer in
            self.base.createDesign(designName, document: document, callback: forwardToObserver(observer))
            return Disposables.create()
        }
    }

    public func deleteDesign(_ designName: String, revision: String, failOnNotFound: Bool = false) -> Observable<Void> {
        return Observable<Void>.create { observer in
            self.base.deleteDesign(designName, revision: revision, 
                failOnNotFound: failOnNotFound, callback: forwardToObserver(observer))
            return Disposables.create() 
        }
    }

    public func createAttachment(_ docId: String, docRevison: String, 
            attachmentName: String, attachmentData: Data, contentType: String) -> Observable<(String, JSON)> {
        return Observable<(String, JSON)>.create { observer in
            self.base.createAttachment(docId, docRevison: docRevison, 
                attachmentName: attachmentName, attachmentData: attachmentData, 
                contentType: contentType, callback: forwardToObserver(observer))
            return Disposables.create() 
        }
    }

    public func retrieveAttachment(_ docId: String, attachmentName: String) -> Observable<(Data, String)> {
        return Observable<(Data, String)>.create { observer in
            self.base.retrieveAttachment(docId, attachmentName: attachmentName) { data, error, contentType in
                if error != nil {
                    observer.onError(error!)
                } else {
                    observer.onNext(data!, contentType!)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }

    public func deleteAttachment(_ docId: String, docRevison: String, attachmentName: String, failOnNotFound: Bool = false) -> Observable<Void> {
        return Observable<Void>.create { observer in
            self.base.deleteAttachment(docId, docRevison: docRevison, attachmentName: attachmentName, 
                    failOnNotFound: failOnNotFound, callback: forwardToObserver(observer))
            return Disposables.create()
        }
    }

}