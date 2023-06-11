// Importing
import Foundation

// Main class
class Main {
    // Parse IEP input
    private static func parseIEP(_ input: String) throws -> Bool {
        // Check if the input is "y"
        if input.lowercased() == "y" {
            return true
        }
        // Check if the input is "n"
        else if input.lowercased() == "n" {
            return false
        }
        else {
            // Display error
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid input format for IEP: \(input)"])
        }
    }
    
    // Main method
    static func main() {
        // Create a list to store student objects.
        var listOfStudents: [Student] = []
        
        do {
            // Create and read the input file
            let inputURL = URL(fileURLWithPath: "input.txt")
            let inputText = try String(contentsOf: inputURL, encoding: .utf8)
            // Split the input into lines
            let lines = inputText.components(separatedBy: .newlines)
            
            // Go over each line
            for line in lines {
                // Trim the line.
                let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Skip blank lines
                if trimmedLine.isEmpty {
                    // Display if a blank line is found
                    print("Blank line found. Skipping.")
                    continue
                }
                
                // Split the line into an array of strings every space
                let data = trimmedLine.components(separatedBy: " ")
                
                // Check if the input format is valid (5 or 4 elements)
                if data.count < 4 || data.count > 5 {
                    // Display if input is invalid
                    print("Invalid input format: \(trimmedLine)")
                    continue
                }
                
                // Initialize variables
                let firstName = data[0]
                var middleInitial = ""
                let lastName: String
                let grade: Int
                let iep: Bool?
                
                // If there are 4 elements in the array, parse the input
                if data.count == 4 {
                    lastName = data[1]
                    grade = Int(data[2]) ?? 0
                    iep = try? parseIEP(data[3])
                }
                // If there are 5 elements in the array, parse the input
                else {
                    middleInitial = data[1]
                    lastName = data[2]
                    grade = Int(data[3]) ?? 0
                    iep = try? parseIEP(data[4])
                }
                
                // Create a student object with the parsed data
                if let iepValue = iep {
                    let aStudent = Student(firstName: firstName, middleInitial: middleInitial, lastName: lastName, grade: grade, iep: iepValue)
                    // Add the student object to the list of students
                    listOfStudents.append(aStudent)
                }
            }
        } catch {
            // Check for error.
            if let error = error as NSError? {
                // Display error
                print("Error: \(error.localizedDescription)")
            }
        }
        
        do {
            // Create the output file
            let outputURL = URL(fileURLWithPath: "output.txt")
            
            // Create the output string
            var outputString = ""
            outputString += "There are \(listOfStudents.count) students in the student list.\n"
            outputString += "The students are:\n"
            
            // Add each student's info to the output string
            for student in listOfStudents {
                outputString += student.description + "\n"
            }
            
            // Write the output string to the output file
            try outputString.write(to: outputURL, atomically: true, encoding: .utf8)
        } catch {
            // Check for error.
            if let error = error as NSError? {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

// Student class
class Student {
    // Properties
    private let firstName: String
    private let middleInitial: String
    private let lastName: String
    private let grade: Int
    private let iep: Bool
    
    // Initializer with middle initial
    init(firstName: String, middleInitial: String, lastName: String, grade: Int, iep: Bool) {
        // Assign variables.
        self.firstName = firstName
        self.middleInitial = middleInitial
        self.lastName = lastName
        self.grade = grade
        self.iep = iep
    }
    
    // Initializer without middle initial
    convenience init(firstName: String, lastName: String, grade: Int, iep: Bool) {
        self.init(firstName: firstName, middleInitial: "", lastName: lastName, grade: grade, iep: iep)
    }
    
    // Description
    var description: String {
        var output = "\(firstName) \(middleInitial) \(lastName) is in grade \(grade)"

        // Check if student has a iep
        if iep {
            output += " and has an IEP."
        } else {
            output += " and does not have an IEP."
        }
        // Return the output
        return output
    }
}

// Call the main method
Main.main()
