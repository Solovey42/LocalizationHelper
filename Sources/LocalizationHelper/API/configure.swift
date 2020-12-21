import Fluent
import FluentPostgresDriver
import Vapor

public func configure(app: Application ) throws {
    app.databases.use(.postgres(hostname: "localhost", username: "postgres", password: "postgres", database: "TestBD"), as: .psql)
  //  app.migrations.add(CreateLanguage())
  //  app.migrations.add(CreateWords())
    app.migrations.add(CreateLang())
    let _ = app.autoMigrate()
    try routes(app: app)
}
