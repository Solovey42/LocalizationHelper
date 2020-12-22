import Foundation
import Fluent
import Vapor

func routes(app: Application) throws {
    app.get() { req -> EventLoopFuture<View> in
        return req.view.render("hello")
    }
    let container = Container()
    let showClass = container.show
    let deleteClass = container.delete
    let updateClass = container.update
    try app.register(collection: ShowController(showClass: showClass))
    try app.register(collection: DeleteController(deleteClass: deleteClass))
    try app.register(collection: UpdateController(updateClass: updateClass))
}