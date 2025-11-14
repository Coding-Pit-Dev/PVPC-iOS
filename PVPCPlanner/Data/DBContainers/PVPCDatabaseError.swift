enum PVPCDatabaseError: Error {
    case errorInsert
    case errorFetch
    case errorDelete
    case errorUpdate
    case errorInsertWithContext(error: Error)
}
