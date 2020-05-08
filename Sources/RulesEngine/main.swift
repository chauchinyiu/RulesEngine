import ArgumentParser

struct RulesEngine: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to manage blog post banners",
        subcommands: [Generate.self])

    init() { }
}

RulesEngine.main()

