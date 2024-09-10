import SwiftUI

struct ProgramListView: View {
    @StateObject var viewModel: ProgramListViewModel
    
    init(stateService: TrainingStateService, exerciseManager: ExerciseManager) {
        _viewModel = StateObject(
            wrappedValue:
                ProgramListViewModel(
                    stateService: stateService,
                    exerciseManager: exerciseManager
                )
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                loadButtonSection
                programListSection
                addButtonSection
            }
            .fullScreenCover(isPresented: $viewModel.programCreationViewIsShown) {
                programModificationView
            }
            .sheet(item: $viewModel.selectedProgram) { program in
                programDetailView(program: program)
            }
        }
    }
    
    
    private var loadButtonSection: some View {
        Section {
            Button("Загрузить все тренировки") {
                viewModel.loadPrograms()
            }
        }
    }
    
    private var addButtonSection: some View {
        Section {
            Button("Добавить программу") {
                viewModel.programCreationViewIsShown = true
            }
        }
    }
    
    private var programModificationView: some View {
        ProgramModificationView(
            modificationMode: .creation,
            programManager: viewModel.programManager,
            exerciseManager: viewModel.exerciseManager
        )
    }
    
    private func programDetailView(program: Program) -> some View {
        return ProgramDetailView(
            program: program,
            stateService: viewModel.stateService,
            exerciseManager: viewModel.exerciseManager
        )
    }
    
    private var programListSection: some View {
        Section {
            ForEach(viewModel.programs) { program in
                programListCell(program: program)
            }
        }
    }
    
    private func programListCell(program: Program) -> some View {
        return HStack {
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

