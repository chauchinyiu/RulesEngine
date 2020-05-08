//
//  Generate.swift
//  
//
//  Created by Chinyiu Chau on 06.05.20.
//

import ArgumentParser
import Foundation
import CSV


enum RuleType: String {
    case Initial = "initial-state"
    case PhysicalCardOnboarding = "onboarding-physical-card"
    case VirtualCardOnboarding = "onboarding-virtual-card"
    case VerificationOnboarding = "onboarding-verification"
}

struct Generate: ParsableCommand {

    public static let configuration = CommandConfiguration(abstract: "Generate codes and tests from the given CSV")

    @Argument(help: "The CSV file")
    private var pathToFile: String

    @Option(name: .shortAndLong, default: "initial-state", help: "The rule type for the CSV")
    private var rule: String

    @Flag(name: .long, help: "Show extra logging for debugging purposes")
    private var verbose: Bool

    func run() throws {
        if verbose {
            print("Generate codes for CVS file \"\(pathToFile)\" for rule: \(rule )")
        
            guard let stream =  InputStream(fileAtPath: pathToFile)  else {
                print("cannot find the file in \(pathToFile)")
                return
            }
            shell("pwd")
            let csv = try CSVReader(stream: stream, delimiter:";")
          
           
            while let row = csv.next() {
                print("\(row)")
            }
        }
 
    }
    
    func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
    
    
}
