## hotkeys
```shell
Ctrl + Shift + L        #duplicate cursor on same occurrences
Ctrl + Shift + Up/Down  #duplicate cursor up or down
Alt + LeftClick         #add cursor
Alt + Up/Down           #move selection or line the cursor is on
Ctrl + Shift + K        #remove line even with selection
Ctrl + /                #comment line
F2                      #factor in all files in project
Ctrl + B                #hide left menu
```
## vscode json settings
```js
//add this to setting.json
{
    "git.enableSmartCommit": true,
    "window.menuBarVisibility": "toggle",   //toggled by Alt
    "workbench.iconTheme": "vscode-icons",  //requires vscode-icons extension
    "editor.fontFamily": "Fira Code",   //requires Fira Code font installed
    "editor.fontLigatures": false,
    "editor.fontWeight": "400",
    "vsicons.dontShowNewVersionMessage": true, // Light
    "editor.detectIndentation": true,  //for smaller tabs, clarity of code
    "editor.insertSpaces": true,
    "editor.tabSize": 2,
    "breadcrumbs.enabled": true,   //navigation in editor
    "editor.minimap.renderCharacters": false,  //minimap looks better
    "editor.minimap.maxColumn": 200,  //just cool stuff
    "editor.minimap.showSlider": "always",  //just cool stuff
    "editor.renderWhitespace": "all",   //for clarity of code
    "editor.smoothScrolling": true,   //cool scrolling
    "editor.cursorBlinking": "phase",   //cool cursor animation
    "editor.cursorSmoothCaretAnimation": true,  //cool cursor animation
    "files.insertFinalNewline": true,   //might be usefull
    "files.trimTrailingWhitespace": true,   //might be usefull
    "telemetry.enableCrashReporter": false,   //not gonna feed microsoft with info
    "telemetry.enableTelemetry": false,
    "workbench.settings.enableNaturalLanguageSearch": false,
    "workbench.colorCustomizations": {  //colour of cursor
        "editorCursor.foreground": "#ffbc2c",
        "terminalCursor.foreground": "#ffbc2c"
    },
    "workbench.tree.indent": 20,
    "rust-analyzer.inlayHints.chainingHints": false,
    "rust-analyzer.inlayHints.parameterHints": false,
    "rust-analyzer.inlayHints.typeHints": false,
    "vetur.experimental.templateInterpolationService": true,
    "[yaml]": {
        "editor.defaultFormatter": "redhat.vscode-yaml"
    },
    "workbench.colorTheme": "Ayu Mirage Bordered",
    "extensions.ignoreRecommendations": true,
    "tabnine.experimentalAutoImports": true,
    "omnisharp.useEditorFormattingSettings": false,
}
```
## omnisharp json settings
```json
{
  "FormattingOptions": {
    "organizeImports": false,
    "NewLine": "\n",
    "UseTabs": false,
    "TabSize": 2,
    "IndentationSize": 2,
    "SpacingAfterMethodDeclarationName": false,
    "SpaceWithinMethodDeclarationParenthesis": false,
    "SpaceBetweenEmptyMethodDeclarationParentheses": false,
    "SpaceAfterMethodCallName": false,
    "SpaceWithinMethodCallParentheses": false,
    "SpaceBetweenEmptyMethodCallParentheses": false,
    "SpaceAfterControlFlowStatementKeyword": true,
    "SpaceWithinExpressionParentheses": false,
    "SpaceWithinCastParentheses": false,
    "SpaceWithinOtherParentheses": false,
    "SpaceAfterCast": false,
    "SpacesIgnoreAroundVariableDeclaration": false,
    "SpaceBeforeOpenSquareBracket": false,
    "SpaceBetweenEmptySquareBrackets": false,
    "SpaceWithinSquareBrackets": false,
    "SpaceAfterColonInBaseTypeDeclaration": true,
    "SpaceAfterComma": true,
    "SpaceAfterDot": false,
    "SpaceAfterSemicolonsInForStatement": true,
    "SpaceBeforeColonInBaseTypeDeclaration": true,
    "SpaceBeforeComma": false,
    "SpaceBeforeDot": false,
    "SpaceBeforeSemicolonsInForStatement": false,
    "SpacingAroundBinaryOperator": "single",
    "IndentBraces": false,
    "IndentBlock": true,
    "IndentSwitchSection": true,
    "IndentSwitchCaseSection": true,
    "IndentSwitchCaseSectionWhenBlock": true,
    "LabelPositioning": "oneLess",
    "WrappingPreserveSingleLine": true,
    "WrappingKeepStatementsOnSingleLine": true,

    "NewLinesForBracesInLambdaExpressionBody": false,
    "NewLinesForBracesInAnonymousMethods": false,
    "NewLinesForBracesInAnonymousTypes": false,
    "NewLinesForBracesInControlBlocks": false,
    "NewLinesForBracesInTypes": false,
    "NewLinesForBracesInMethods": false,
    "NewLinesForBracesInProperties": false,
    "NewLinesForBracesInObjectCollectionArrayInitializers": false,
    "NewLinesForBracesInAccessors": false,
    "NewLineForElse": false,
    "NewLineForCatch": false,
    "NewLineForFinally": false,

    "NewLineForMembersInObjectInit": true,
    "NewLineForMembersInAnonymousTypes": true,
    "NewLineForClausesInQuery": true
  }
}

```
