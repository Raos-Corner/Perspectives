import Granite
import SandKit

extension Compile {
    struct Generate: GraniteReducer {
        typealias Center = Compile.Center
        
        @Relay var service: AnnotationService
        
        @Event var reset: Reset.Reducer
        @Event var result: Result.Reducer
        
        func reduce(state: inout Center.State) async {
            
            service.center.reset.send()
            reset.send()
            
            var annotations: [String] = []
            
            for item in service.state.annotations {
                let value: String = """
                {
                    'topic':'\(item.value.topic)',
                    'annotation':'\(item.value.annotation)'
                }
                """
                
                annotations.append(value)
            }
            
            let prompt: String = """
            You are a professor providing insight on a PhD student's process while diving into a diverse set of research topics, the subject has annoted certain points of discovery that require an analysis.
            
            The Annotations delimited by `###`:
            ###
            \(annotations.joined(separator: "\n"))
            ###
            
            Complete this task:
            
            Compile a summarized understanding of today's journey with key takeaways and potential next steps to continue the learning experience.
            """
            
            
            var systemPrompt: String = """
            You are a PhD professor overseeing a student's research journey.
            """
            
            do {
                try await Compile.kit
                    .generate(
                        prompt: prompt,
                        config: .init(
                            .init(),
                            systemPrompt: systemPrompt
                        )
                    ) {
                        value,
                        isComplete in
                        print("{TEST} output: \(value)")
                        
                        
                        service.center.result.send(AnnotationService.Result.Meta(output: value))
                        result.send(Result.Meta(output: value))
                    }
            } catch let error {
                print(error)
            }
        }
        
        var behavior: GraniteReducerBehavior {
            .task(.utility)
        }
    }
    
    struct Reset: GraniteReducer {
        typealias Center = Compile.Center
        
        func reduce(state: inout Center.State) {
            state.result = ""
        }
    }
    
    struct Result: GraniteReducer {
        typealias Center = Compile.Center
        
        struct Meta: GranitePayload {
            var output: String
        }
        
        @Payload var meta: Meta?
        
        func reduce(state: inout Center.State) {
            guard let meta else { return }
            state.result = meta.output
        }
    }
}
