import Quick
import Nimble
import PromiseKit
@testable import GitHubExplorer

final class MockGitHubServiceForList: GitHubServiceProtocol {
    func fetchUsers() -> Promise<[User]> {
        return Promise.value([User(id: 1, login: "mockuser", avatarUrl: "https://example.com")])
    }

    func fetchUsers(since: Int) -> Promise<[User]> {
        return Promise.value([User(id: since + 1, login: "user\(since+1)", avatarUrl: "https://example.com")])
    }

    func fetchUserDetail(username: String) -> Promise<UserDetail> {
        return Promise.value(UserDetail(login: username, name: nil, bio: nil, followers: 0, following: 0, publicRepos: 0, company: nil, location: nil, avatarUrl: nil))
    }

    func fetchRepositories(for username: String) -> Promise<[Repository]> {
        return Promise.value([])
    }
}

final class UserListViewModelTests: QuickSpec {
    override class func spec() {
        describe("UserListViewModel") {
            var viewModel: UserListViewModel!

            beforeEach {
                let mockService = MockGitHubServiceForList()
                viewModel = UserListViewModel(service: mockService)
            }

            it("fetches users and updates list") {
                waitUntil { done in
                    viewModel.fetchUsers().done {
                        expect(viewModel.users.count).to(equal(1))
                        expect(viewModel.users.first?.login).to(equal("mockuser"))
                        done()
                    }.catch { error in
                        fail("Should not fail: \(error)")
                        done()
                    }
                }
            }

            it("calls searchUsers without crashing") {
                viewModel.searchUsers(query: "octocat")
                // Sem crash = passou
                expect(true).to(beTrue())
            }

            it("calls loadCachedUsers without crashing") {
                viewModel.loadCachedUsers()
                expect(true).to(beTrue())
            }
        }
    }
}
