platform :ios, '14.3'
inhibit_all_warnings!

pod 'SwiftLint', '~> 0.59.1'
pod 'SkeletonView', '~> 1.30.4'

target 'GitHubExplorer' do
  use_frameworks!

  # Dependências do app principal
  pod 'PromiseKit', '~> 8.2.0'
  pod 'SnapKit', '~> 5.7.1'
  pod 'Alamofire', '~> 5.10.2'
  pod 'AlamofireImage', '~> 4.3.0'

  target 'GitHubExplorerTests' do
    inherit! :search_paths
    pod 'Quick', '~> 7.6.2'
    pod 'Nimble', '~> 13.7.1'
  end

  target 'GitHubExplorerUITests' do
    inherit! :search_paths
    pod 'Quick', '~> 7.6.2'
    pod 'Nimble', '~> 13.7.1'
  end
end
