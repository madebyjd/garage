//
//  TextInput.swift
//  
//
//  Created by Jonathan Danek on 5/12/23.
//

import SwiftUI

struct TextInput: View {

    @State var content: String =  """
    # h1 Heading 8-)
    ## h2 Heading
    ### h3 Heading
    #### h4 Heading
    ##### h5 Heading
    ###### h6 Heading
    """

    var markdown: AttributedString {
        (try? AttributedString(markdown: content)) ?? AttributedString()
    }


    var body: some View {
        VStack {
            TextField("", text: $content)
                .font(.title2)
            TextEditor(text: $content)
                .scrollContentBackground(.hidden)
                .multilineTextAlignment(.leading)
                .font(.system(.title2, design: .rounded, weight: .regular))

            toolbar
                .ignoresSafeArea(.all)
        }
    }

    var toolbar: some View {
        HStack(spacing: 30.0) {
            Spacer()
        }
        .padding()
        .background(Color.appLightGray)
    }
}

struct TextInput_Previews: PreviewProvider {
    static var content = ""
    static var previews: some View {
        Group {
            TextInput()
        }
    }
}
