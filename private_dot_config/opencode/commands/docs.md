---
description: Add Dart documentation to code following Effective Dart guidelines
model: github-copilot/claude-haiku-4.5
subtask: true
---

Add documentation to: $ARGUMENTS

## Rules

Follow Effective Dart documentation guidelines strictly:

- Use `///` for all doc comments — never `/** */` or `//`
- Start every doc comment with a single-sentence summary ending in a period
- If more detail is needed, add a blank line after the first sentence and continue in a new paragraph
- Place doc comments before any metadata annotations (e.g. `@override`, `@Component`)
- Do not repeat information already obvious from the declaration itself

## What to write

- **Functions/methods whose purpose is a side effect**: start with a third-person verb. E.g. `/// Connects to the server and fetches results.`
- **Functions/methods whose purpose is a return value**: start with a noun phrase. E.g. `/// The [index]th element of this iterable.`
- **Boolean variables/properties**: start with "Whether". E.g. `/// Whether the modal is currently visible.`
- **Non-boolean variables/properties**: start with a noun phrase. E.g. `/// The number of checked buttons on the page.`
- **Classes and types**: start with a noun phrase describing an instance. E.g. `/// A chunk of non-breaking output text terminated by a newline.`
- **Getters with a setter**: document the getter only — dart doc treats them as a single field.

## Parameters, returns, and exceptions

Integrate these into prose using square brackets — do not use `@param`, `@returns`, or `@throws` tags.

```dart
/// Defines a flag with the given [name] and [abbreviation].
///
/// The [name] and [abbreviation] strings must not be empty.
///
/// Returns a new flag.
///
/// Throws a [DuplicateFlagException] if there is already an option named
/// [name] or there is already an option using the [abbreviation].
Flag addFlag(String name, String abbreviation) => ...
```

## Code samples

Include a `dart` fenced code block for non-obvious APIs:

```dart
/// The lesser of two numbers.
///
/// ```dart
/// min(5, 3) == 3
/// ```
num min(num a, num b) => ...
```

## What not to document

- Skip doc comments where the declaration is entirely self-explanatory
- Do not use HTML for formatting
- Do not use markdown excessively — words matter more than formatting
- Do not use abbreviations like "i.e." or "e.g." unless they are universally known
- Use "this" rather than "the" when referring to the current instance
