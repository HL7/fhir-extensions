---

## Hard Blocks (will CHANGES_REQUEST every time)

### 1. Deleting non-draft extensions
Extensions must be **deprecated or retired**, never deleted. The file stays; the extension gets marked deprecated with a pointer to what replaces it.

**Rule:** If a PR removes an `.xml`/`.json` extension definition, it will be blocked unless the extension was `draft` status.

---

### 2. Breaking data type changes
Changing the type of an existing extension element (e.g., `date` → `dateTime`, `string` → `CodeableConcept`) is a breaking change and not allowed on extensions that may already be in use.

**Rule:** Add new allowed types, or deprecate and create a new extension. Never swap types in place.

---

### 3. Deprecation without a migration path
Deprecating an extension without updating its description to explain what implementers should use instead.

**Rule:** Every deprecated extension needs a `description` or `comment` saying "use X instead."

---

### 4. Deprecating for inter-version reasons incorrectly
Do **not** deprecate extensions in favor of inter-version extensions. Instead, keep using the existing extension with appropriate version ranges.

---

### 5. Context of use inconsistent with extension semantics
If the context list includes resource types that logically cannot carry the extension's meaning, the PR is blocked.

**Rule:** Every context element must be covered by the prose description, and the description must be consistent with every listed context.

---

### 6. New extension with no tracker reference
Adding a new extension without a Jira tracker item that documents WG approval will be rejected.

**Rule:** New extensions need a Jira link in the PR body showing WG approval.

---

### 7. Code systems / value sets that belong in THO
Inline code systems need to have experimental=true.  Otherwise, the code system needs to be in THO, not in the extension IG.

---

### 8. Missing descriptions on complex extension slices
Complex extensions with named slices must have a `short` and/or `definition` on each slice. Coded elements must have at minimum an example binding or a binding description with examples.


---

### 9. targetProfile defined on Reference more than once
Multiple `targetProfile` values on a `Reference` type must be expressed as multiple `targetProfile` entries on a **single** `type.Reference` element, not as duplicate `type` entries.

---

### 10. Mardown with invalid entities
Markdown is only allowed to contain XHTML entities (e.g. `&amp;`, `&lt;`), not HTML entities (e.g. `&mdash;`)

---

## Consistent Non-Blocking Flags (COMMENTED state — approved but flagged)

These appear repeatedly as advisory comments. They rarely block a merge but recur when not addressed.

| Theme | Typical wording | Examples |
|---|---|---|
| **Wrong primitive type** | "should be `canonical`, not `uri`" / "type should be `markdown`, not `string`" | PR #225, PR #102 |
| **Cardinality too restrictive** | "Is it not possible to have more than one? Should this be `0..*`?" | PR #243, PR #219 |
| **Context too narrow** | "Why is the context not `Quantity` in general?" / "Is there a reason not to have a general extension?" | PR #183, PR #237 |
| **Missing usage guidance** | "There's no guidance on how to use the expression or what context it'll operate in" / "Should be documentation explaining when to use this instead of X" | PR #243, PR #196, PR #162 |
| **Copy-paste error in description** | "definition of '...' seems like copy & paste error?" | PR #165 |
| **Overlap with existing element** | "How is X different from Y?" / "there's already a statusReason on Task" | PR #165, PR #114, PR #134 |
| **startVersion without justification** | "Why is there a startVersion on this extension? Is it wrong to use in STU3?" | PR #243 |
| **Context changed without WG approval** | "I think a change like this should be approved by the WG. Was it?" | PR #202 |
| **Value set enumerating when 'all codes' suffices** | "Why is the value set enumerating codes instead of just saying 'all codes'?" | PR #197 |
| **Design consistency with core** | "The point of this extension is to align with [Metadata resource]" | PR #98 |

---

## What Gets Fast-Approved (no comments)

- Context-of-use expansions that add resources clearly relevant to the extension's semantics
- Deprecations that include a migration path
- Description/wording clarifications
- QA / typo fixes
- Undeprecations where the rationale is clear
- Narrowly scoped tracker-driven changes with Jira links
- Extensions aligned with R5 core elements (using version ranges correctly)

---

## Reviewer Priorities (ranked by frequency of block)

1. **Structural integrity** — no deletions, no breaking changes, no duplicate IDs
2. **Deprecation hygiene** — always include "use X instead"
3. **Governance** — WG approval in Jira, THO for production codes
4. **Semantic correctness** — context list matches prose; type matches semantics
5. **Documentation completeness** — descriptions on slices, bindings on coded elements, usage guidance

---

## Checklist for PR Authors

Before opening a PR, verify:

- [ ] No extension `.xml`/`.json` files have been deleted (deprecate instead)
- [ ] No data type changes on existing elements (add types or create new extension)
- [ ] Every deprecated extension has "use X instead" in its description/comment
- [ ] All new extensions have a Jira tracker link in the PR body showing WG approval
- [ ] Context list is logically consistent with the extension's stated purpose
- [ ] Inline code systems are marked `experimental` or have a THO proposal reference
- [ ] Complex extension slices each have a `short`/`definition` and at least an example binding
- [ ] `Reference` types use multiple `targetProfile` entries on a single element (not duplicate elements)
- [ ] Coded/typed elements use `canonical` not `uri` where canonicals are intended
- [ ] Types use `markdown` not `string` where rich text is expected (e.g., `requirements`)
- [ ] Cardinality is `0..*` unless there is a clear semantic reason for `0..1`
- [ ] No HTML entities (e.g., `&mdash;`) in markdown narrative files
- [ ] Description text is original — not copied from another extension unchanged
- [ ] No overlap with existing FHIR core elements or other published extensions without explicit explanation
