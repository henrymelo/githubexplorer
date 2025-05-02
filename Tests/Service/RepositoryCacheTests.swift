import Quick
import Nimble
@testable import GitHubExplorer

final class RepositoryCacheTests: QuickSpec {
    override class func spec() {
        describe("RepositoryCache") {
            var cache: RepositoryCache!
            var testRepos: [Repository]!

            beforeEach {
                cache = RepositoryCache()
                testRepos = [
                    Repository(
                        id: 1,
                        name: "Test1",
                        description: "Desc",
                        stargazersCount: 1
                    )
                ]
            }

            it("saves and loads repositories correctly") {
                cache.save(testRepos)
                let loaded = cache.load()
                expect(loaded.count).to(equal(1))
                expect(loaded.first?.name).to(equal("Test1"))
            }
        }
    }
}
