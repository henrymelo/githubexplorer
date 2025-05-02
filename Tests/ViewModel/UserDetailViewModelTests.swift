import XCTest
import Quick
import Nimble
import PromiseKit
@testable import GitHubExplorer

class MockGitHubService: GitHubServiceProtocol {
    func fetchUsers() -> Promise<[User]> {
        return Promise.value([])
    }

    func fetchUserDetail(username: String) -> Promise<UserDetail> {
        return .value(UserDetail(
            name: "Mock User",
            company: "Mock Inc.",
            blog: "https://mock.blog",
            location: "Internet",
            email: "mock@mock.com",
            bio: "This is a mock user."
        ))
    }

    func fetchRepositories(for username: String) -> Promise<[Repository]> {
        return .value([
            Repository(
                id: 1,
                name: "Repo1",
                description: "Description",
                stargazersCount: 42
            )
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
                        expect(viewModel.userDetail?.name).to(equal("Mock User"))
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
                        expect(viewModel.repositories.count).to(equal(1))
                        expect(viewModel.repositories[0].name).to(equal("Repo1"))
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
