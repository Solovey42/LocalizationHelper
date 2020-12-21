import Foundation
import Fluent
import Vapor

func routes(app: Application) throws {
    let container = Container()
    let showClass = container.showDB
    let deleteClass = container.deleteDB
    let updateClass = container.updateDB
    try app.register(collection: ShowController(showClass: showClass))
    try app.register(collection: DeleteController(deleteClass: deleteClass))
    try app.register(collection: UpdateController(updateClass: updateClass))
}