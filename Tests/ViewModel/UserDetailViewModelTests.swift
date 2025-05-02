import XCTest
import Quick
import Nimble
import PromiseKit
@testable import GitHubExplorer

class MockGitHubService: GitHubServiceProtocol {
    func fetchUsers(since: Int) -> PromiseKit.Promise<[GitHubExplorer.User]> {
        return Promise.value([])
    }
    
    func fetchUsers() -> Promise<[User]> {
        return Promise.value([])
    }

    func fetchUserDetail(username: String) -> Promise<UserDetail> {
        return .value(UserDetail(login: "tst", name: "tst", bio: "tst", followers: 1, following: 1, publicRepos: 1, company: "tst", location: "tst", avatarUrl: "tst"))
    }

    func fetchRepositories(for username: String) -> Promise<[Repository]> {
        return .value([
            Repository(name: "test", description: "", language: "", stargazersCount: 1, forksCount: 1, openIssuesCount: 1, updatedAt: "test", isPrivate: false, isArchived: false, htmlUrl: "http://www.test.com")
        ])
    }
}

class UserDetailViewModelTests: QuickSpec {
    override class func spec() {
        describe("UserDetailViewModel") {
            var viewModel: UserDetailViewModel!

            beforeEach {
                let mockService = MockGitHubService()
                viewModel = UserDetailViewModel(service: mockService)
            }

            it("fetches user detail correctly") {
                waitUntil { done in
                    viewModel.fetchUserDetail(username: "mock").done {
                        expect(viewModel.userDetail?.name).to(beNil())
                        done()
                    }.catch { _ in
                        fail("Should not fail")
                        done()
                    }
                }
            }

            it("fetches repositories correctly") {
                waitUntil { done in
                    viewModel.fetchRepositories(for: "mock").done {
                        expect(viewModel.repositories.count).to(equal(8))
                        expect(viewModel.repositories[0].name).to(equal("benpackbot"))
                        done()
                    }.catch { _ in
                        fail("Should not fail")
                        done()
                    }
                }
            }
        }
    }
}
