describe "Retro Notes grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-retro")

    runs ->
      grammar = atom.syntax.grammarForScopeName("source.retro")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.retro"

  it "tokenizes positive list items", ->
    {tokens} = grammar.tokenizeLine("+Item 1")
    expect(tokens[0]).toEqual value: "+Item 1", scopes: ["source.retro"]

    {tokens} = grammar.tokenizeLine("  + Item 2")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.retro"]
    expect(tokens[1]).toEqual value: "+", scopes: ["source.retro", "variable.list.positive.retro"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.retro"]
    expect(tokens[3]).toEqual value: "Item 2", scopes: ["source.retro"]

  it "tokenizes negative list items", ->
    {tokens} = grammar.tokenizeLine("-Item 1")
    expect(tokens[0]).toEqual value: "-Item 1", scopes: ["source.retro"]

    {tokens} = grammar.tokenizeLine("  - Item 2")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.retro"]
    expect(tokens[1]).toEqual value: "-", scopes: ["source.retro", "variable.list.negative.retro"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.retro"]
    expect(tokens[3]).toEqual value: "Item 2", scopes: ["source.retro"]

  it "tokenizes question list items", ->
    {tokens} = grammar.tokenizeLine("?Item 1")
    expect(tokens[0]).toEqual value: "?Item 1", scopes: ["source.retro"]

    {tokens} = grammar.tokenizeLine("  ? Item 2")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.retro"]
    expect(tokens[1]).toEqual value: "?", scopes: ["source.retro", "variable.list.question.retro"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.retro"]
    expect(tokens[3]).toEqual value: "Item 2", scopes: ["source.retro"]

  it "tokenizes do differently list items", ->
    {tokens} = grammar.tokenizeLine("∆Item 1")
    expect(tokens[0]).toEqual value: "∆Item 1", scopes: ["source.retro"]

    {tokens} = grammar.tokenizeLine("  ∆ Item 2")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.retro"]
    expect(tokens[1]).toEqual value: "∆", scopes: ["source.retro", "variable.list.different.retro"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.retro"]
    expect(tokens[3]).toEqual value: "Item 2", scopes: ["source.retro"]
