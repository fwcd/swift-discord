import Dispatch

protocol Lockable {
    var lock: DispatchSemaphore { get }

    func protected(_ block: () -> ())
    func get<T>(_ getter: @autoclosure () -> T) -> T
}

extension Lockable {
    func protected(_ block: () -> ()) {
        lock.wait()
        block()
        lock.signal()
    }

    func get<T>(_ getter: @autoclosure () -> T) -> T {
        defer { lock.signal() }

        lock.wait()

        return getter()
    }
}
