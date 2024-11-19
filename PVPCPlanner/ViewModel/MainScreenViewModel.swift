import Foundation

@Observable
class MainScreenViewModel {
    @MainActor
     func createPricesVM() -> PricesVM {
        return PricesVM(
            getPricesUseCase: GetPricesUseCase(repository: NetworkRepository()),
            addPVPCTOLocalDBUseCase: AddPVPCToLocaDBUseCase(dataSource: .shared),
            getPVPCByDayFromLocalDBUseCase: GetPVPCByDayFromLocalDBUseCase(dataSource: .shared)
        )
    }
}
