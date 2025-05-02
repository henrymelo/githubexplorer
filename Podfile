platform :ios, '14.3'
inhibit_all_warnings!

pod 'SwiftLint'
pod 'SkeletonView'

target 'GitHubExplorer' do
  use_frameworks!

  # Dependências do app principal
  pod 'PromiseKit', '~> 8.2'
  pod 'SnapKit'
  pod 'Alamofire'
  pod 'AlamofireImage'

  target 'GitHubExplorerTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end

  target 'GitHubExplorerUITests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end
end
