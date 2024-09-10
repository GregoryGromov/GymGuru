import Foundation

enum ModificationMode {
    case creation
    case editing
}

final class ProgramModificationViewModel: ObservableObject, ExerciseAddable {
    let programManager: ProgramManager
    let exerciseManager: ExerciseManager
    
    let modificationMode: ModificationMode
    
    let id: String
    let dateCreation: Int
    
    @Published var name: String
    @Published var commnet: String?
    @Published var exerciseTypes: [ExerciseType]
    @Published var selectedColorThemeId: String?
    
    @Published var addExerciseViewIsShown = false
    
    init(
        modificationMode: ModificationMode,
        program: Program? = nil,
        programManager: ProgramManager,
        exerciseManager: ExerciseManager
    ) {
        self.modificationMode = modificationMode
        self.programManager = programManager
        self.exerciseManager = exerciseManager
        
        switch modificationMode {
        case .creation:
            self.id = UUID().uuidString
            self.dateCreation = Date().toInt
            self.name = ""
            self.exerciseTypes = []
            print("DEBUG: ProgramModificationViewModel инициализированна в режиме Creation")

        case .editing:
            guard let program = program else {
                fatalError("Program must be provided for editing mode")
            }
            self.id = program.id
            self.dateCreation = program.dateCreation
            self.name = program.name
            self.commnet = program.comment
            self.exerciseTypes = exerciseManager.getExerciseTypes(byIDs: program.exerciseTypeIDs)
            self.selectedColorThemeId = program.colorThemeID
            print("DEBUG: ProgramModificationViewModel инициализированна в режиме Editing")
        }
    }
    
    
    func showAddExerciseView() {
        addExerciseViewIsShown = true
    }
    
    func addExerciseType(_ exerciseType: ExerciseType) {
        exerciseTypes.append(exerciseType)
        print("Хм, вроде как добавили упражнение в программу")
    }
    
    //КОСТЫЛЬ
    func addExercise(_ exercise: Exercise) {}
    
    func addProgram() {
        let program = createProgram()
        programManager.addProgram(program)
    }
    
    func deleteProgram() {
        programManager.deleteProgram(byId: id)
    }
    
    private func createProgram() -> Program {
        return Program(
            id: id,
            name: name,
            comment: commnet,
            exerciseTypeIDs: getIDs(from: exerciseTypes),
            dateCreation: modificationMode == .creation ? Date().toInt : dateCreation,
            colorThemeID: selectedColorThemeId
        )
    }
    
    private func getIDs<T: Identifiable>(from array: [T]) -> [String] where T.ID: CustomStringConvertible {
        var IDs = [String]()
        
        for element in array {
            IDs.append(element.id.description)
        }
        
        return IDs
    }
    
    func updateProgram() {
        let program = createProgram()  //  TODO: не Create, а скорее "собери"
        programManager.updateProgram(with: program)
    }
    
    func getNavigationTitle() -> String {
        if modificationMode == .creation {
            return "Создание программы"
        } else {
            return "Редактирование программы"
        }
    }
}

















