import Foundation

@MainActor
@Observable
class MainScreenViewModel {
    func createPricesVM() -> PricesVM {
        let container = PVPCDatabaseContainer.shared.container
        let dataSource = PVPCLocalDataSource(container: container)
        return PricesVM(
            getPricesUseCase: GetPricesUseCase(repository: NetworkRepository()),
            addPVPCTOLocalDBUseCase: AddPVPCToLocaDBUseCase(dataSource: dataSource),
            getPVPCByDayFromLocalDBUseCase: GetPVPCByDayFromLocalDBUseCase(dataSource: dataSource)
        )
    }
}
