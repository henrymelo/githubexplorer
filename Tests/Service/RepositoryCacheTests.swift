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
                    Repository(name: "test", description: "", language: "", stargazersCount: 1, forksCount: 1, openIssuesCount: 1, updatedAt: "test", isPrivate: false, isArchived: false, htmlUrl: "http://www.test.com")
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
