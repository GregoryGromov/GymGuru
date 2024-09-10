import Foundation
import CoreData

final class ProgramStorageService: CoreDataService {
    
    //  MARK: - Adding
    
    func addProgram(_ program: Program) {
        createProgramEntity(from: program)
        save()
    }
    
    private func createProgramEntity(from program: Program) -> ProgramEntity {
        let programEntity = ProgramEntity(context: context)
        
        programEntity.id = program.id
        programEntity.name = program.name
        programEntity.comment = program.comment
        programEntity.dateCreation = Int64(program.dateCreation)
        programEntity.colorThemeID = program.colorThemeID
        
        if let encodedExerciseTypeIDs = program.exerciseTypeIDs.toNSData() {
            programEntity.exerciseTypeIDs = encodedExerciseTypeIDs
        }
        
        return programEntity
    }
    
    
    //  MARK: - Fetching
    
    func fetchPrograms() throws -> [Program] {
        guard let programEntities = fetch(ProgramEntity.self) else {
            throw CoreDaraErrors.fecthFailed
        }
        
        var programs = [Program]()
        
        for programEntity in programEntities {
            let program = try! convertToProgram(from: programEntity)
            programs.append(program)
        }
        
        return programs
    }
    
    
    private func convertToProgram(from programEntity: ProgramEntity) throws -> Program {
        var exerciseTypeIDs: [String] = []
        
        guard let data = programEntity.exerciseTypeIDs as? NSData else {
            throw CoreDaraErrors.convertingFailed
        }
        exerciseTypeIDs = Array<String>.fromNSData(data) ?? []
        
        guard let id = programEntity.id else {
            throw CoreDaraErrors.programEntityHasNoId
        }
        guard let name = programEntity.name else {
            throw CoreDaraErrors.programEntityHasNoName
        }
        
        return Program(
            id: id,
            name: name,
            comment: programEntity.comment,
            exerciseTypeIDs: exerciseTypeIDs,
            dateCreation: Int(programEntity.dateCreation),
            colorThemeID: programEntity.colorThemeID
        )
    }
    
    
    //  MARK: - Deleting
    
    func deleteProgram(byId id: String) {
        let fetchRequest: NSFetchRequest<ProgramEntity> = ProgramEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if let trainingEntity = results.first {
                context.delete(trainingEntity)
                try context.save()
                print("DEBUG: Successfully deleted ProgramEntity with id \(id)")
            } else {
                print("DEBUG: No ProgramEntity found with id \(id)")
            }
        } catch {
            print("DEBUG: Failed to delete ProgramEntity: \(error)")
        }
    }
}
