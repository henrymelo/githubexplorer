#!/usr/bin/env python3
import os

GITHUB_OWNER = "SEU_USUARIO"  # Substituir pelo owner do GitHub
GITHUB_REPO = "SEU_REPOSITORIO"  # Substituir pelo nome do repositório

MODULE_TYPE = input("Tipo de módulo (core/feature): ").strip().lower()
MODULE_NAME = input("Nome do módulo (ex.: Analytics ou Payments): ").strip()

if MODULE_TYPE not in ["core", "feature"]:
    print("❌ Tipo inválido. Use 'core' ou 'feature'.")
    exit(1)

base_path = f"Modules/{MODULE_TYPE.capitalize()}/{MODULE_NAME}"
src_path = f"{base_path}/Sources/{MODULE_NAME}"
test_path = f"{base_path}/Tests/{MODULE_NAME}Tests"

os.makedirs(src_path, exist_ok=True)
os.makedirs(test_path, exist_ok=True)

# Criar Package.swift do módulo
package_content = f"""
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "{MODULE_NAME}",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "{MODULE_NAME}", targets: ["{MODULE_NAME}"])
    ],
    dependencies: [],
    targets: [
        .target(name: "{MODULE_NAME}", dependencies: []),
        .testTarget(name: "{MODULE_NAME}Tests", dependencies: ["{MODULE_NAME}"])
    ]
)
"""
with open(f"{base_path}/Package.swift", "w") as f:
    f.write(package_content)

# Criar teste unitário inicial
test_file = f"""
import XCTest
@testable import {MODULE_NAME}

final class {MODULE_NAME}Tests: XCTestCase {{
    func testExample() throws {{
        XCTAssertTrue(true, "Teste inicial do módulo {MODULE_NAME}")
    }}
}}
"""
with open(f"{test_path}/{MODULE_NAME}Tests.swift", "w") as f:
    f.write(test_file)

# Criar Sample App SwiftUI
sample_app_path = f"{base_path}/SampleApp"
os.makedirs(sample_app_path, exist_ok=True)

sample_app_content = f"""
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "{MODULE_NAME}SampleApp",
    platforms: [.iOS(.v13)],
    products: [
        .executable(name: "{MODULE_NAME}SampleApp", targets: ["{MODULE_NAME}SampleApp"])
    ],
    dependencies: [
        .package(path: "../")
    ],
    targets: [
        .executableTarget(
            name: "{MODULE_NAME}SampleApp",
            dependencies: ["{MODULE_NAME}"],
            path: "Sources"
        ),
        .testTarget(
            name: "{MODULE_NAME}SampleAppUITests",
            dependencies: ["{MODULE_NAME}SampleApp"],
            path: "UITests"
        )
    ]
)
"""
with open(f"{sample_app_path}/Package.swift", "w") as f:
    f.write(sample_app_content)

# Criar código SwiftUI para Sample App
os.makedirs(f"{sample_app_path}/Sources/{MODULE_NAME}SampleApp", exist_ok=True)
sample_swiftui_content = f"""
import SwiftUI
import {MODULE_NAME}

@main
struct {MODULE_NAME}SampleApp: App {{
    var body: some Scene {{
        WindowGroup {{
            ContentView()
        }}
    }}
}}

struct ContentView: View {{
    var body: some View {{
        Text("Hello from {MODULE_NAME} Sample App")
            .padding()
    }}
}}
"""
with open(f"{sample_app_path}/Sources/{MODULE_NAME}SampleApp/ContentView.swift", "w") as f:
    f.write(sample_swiftui_content)

# Criar UI Tests
ui_tests_path = f"{sample_app_path}/UITests"
os.makedirs(ui_tests_path, exist_ok=True)
ui_test_file = f"""
import XCTest

final class {MODULE_NAME}SampleAppUITests: XCTestCase {{
    func testLaunch() throws {{
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.staticTexts["Hello from {MODULE_NAME} Sample App"].exists)
    }}
}}
"""
with open(f"{ui_tests_path}/{MODULE_NAME}SampleAppUITests.swift", "w") as f:
    f.write(ui_test_file)

# Atualizar project.yml
project_yml_path = "project.yml"
if os.path.exists(project_yml_path):
    with open(project_yml_path, "a") as f:
        f.write(f"  {MODULE_TYPE.capitalize()}{MODULE_NAME}:
")
        f.write(f"    path: Modules/{MODULE_TYPE.capitalize()}/{MODULE_NAME}
")
    print(f"✅ Módulo {MODULE_NAME} adicionado no project.yml")

# Criar workflow CI para o módulo
workflow_dir = ".github/workflows"
os.makedirs(workflow_dir, exist_ok=True)
workflow_path = f"{workflow_dir}/ci-{MODULE_NAME.lower()}.yml"
workflow_content = f"""
name: CI-{MODULE_NAME}

on:
  push:
    paths:
      - 'Modules/{MODULE_TYPE.capitalize()}/{MODULE_NAME}/**'
      - '.github/workflows/ci-{MODULE_NAME.lower()}.yml'

jobs:
  build-test:
    runs-on: macos-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Build Package
        run: swift build --package-path Modules/{MODULE_TYPE.capitalize()}/{MODULE_NAME}
      
      - name: Run Unit Tests
        run: swift test --package-path Modules/{MODULE_TYPE.capitalize()}/{MODULE_NAME}
"""
with open(workflow_path, "w") as f:
    f.write(workflow_content)

# Criar README com badge
readme_path = f"{base_path}/README.md"
badge_content = f"""
# {MODULE_NAME} Module

[![CI](https://github.com/{GITHUB_OWNER}/{GITHUB_REPO}/actions/workflows/ci-{MODULE_NAME.lower()}.yml/badge.svg)](https://github.com/{GITHUB_OWNER}/{GITHUB_REPO}/actions/workflows/ci-{MODULE_NAME.lower()}.yml)
"""
with open(readme_path, "w") as f:
    f.write(badge_content)

print(f"✅ Módulo {MODULE_TYPE}:{MODULE_NAME} criado com sucesso com Sample App SwiftUI, UI Tests, CI Workflow e Badge no README!")
