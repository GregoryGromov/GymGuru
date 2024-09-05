import SwiftUI

struct ProgramListView: View {
    
    @StateObject var viewModel: ProgramListViewModel
    
    init(stateService: TrainingStateService, trainingManager: TrainingManager, exerciseManager: ExerciseManager) {
        _viewModel = StateObject(
            wrappedValue:
                ProgramListViewModel(
                    stateService: stateService,
                    trainingManager: trainingManager,
                    exerciseManager: exerciseManager
                )
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button("Добавить тренировку 1") {
                        viewModel.addProgram(viewModel.testProgram1)
                    }
                    Button("Добавить тренировку 2") {
                        viewModel.addProgram(viewModel.testProgram2)
                    }
                    Button("Загрузить все тренировки") {
                        viewModel.loadPrograms()
                    }
                    
                }
                
                Section {
                    ForEach(viewModel.programs) { program in
                        HStack {
                            Image(systemName: "circle")
                                .font(.title)
                                .bold()
                            
                            NavigationLink {
                                ProgramModificationView(
                                    modificationMode: .editing,
                                    program: program,
                                    programManager: viewModel.programManager,
                                    exerciseManager: viewModel.exerciseManager
                                )
                            } label: {
                                HStack {
                                    VStack {
                                        Text(program.name)
                                            .bold()
                                        Text(program.id)
                                            .foregroundStyle(.purple)
                                    }
                                    
                                    Spacer()
                                    Text("\(program.exerciseTypeIDs.count)")
                                        .foregroundStyle(.orange)
                                }
                                .swipeActions(allowsFullSwipe: true) {
                                    Button() {
                                        viewModel.deleteProgram(byId: program.id)
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                            .tint(.red)
                                    }
                                    
                                    Button() {
                                        print("DEBUG: Вы выбрали программу с id = \(program.id)")
                                        viewModel.selectProgram(with: program)
                                    } label: {
                                        Label("Выбрать", systemImage: "hand.tap.fill")
                                            .tint(Color.cyan)
                                    }
                                }
                            }
                        }
                    }
                }
                
                Section {
                    HStack {
                        Button("Добавить программу") {
                            viewModel.programCreationViewIsShown = true
                        }
                    }
                    .background(Color.pink)
                    
                }
            }
            .fullScreenCover(isPresented: $viewModel.programCreationViewIsShown) {
                ProgramModificationView(
                    modificationMode: .creation,
                    programManager: viewModel.programManager,
                    exerciseManager: viewModel.exerciseManager
                )
            }
            .sheet(item: $viewModel.selectedProgram) { program in
                ProgramDetailView(
                    program: program,
                    stateService: viewModel.stateService,
                    exerciseManager: viewModel.exerciseManager
                )
            }
        }
    }
}

