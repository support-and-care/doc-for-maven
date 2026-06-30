# Maven Documentation Style Guide

This guide defines how we structure and write Maven documentation.
It is built on the Divio / Diátaxis model, which separates docs into four content types: tutorials, how-to guides, reference, and explanation.
Each content type serves a different purpose in the learning journey of a developer.
We extend that model with rules for our landing page and our getting started guide, the two surfaces that decide whether a new user reaches value or bounces. 

The core principle: each page has exactly one purpose.
Readers should never hit a conceptual essay inside a tutorial, or step-by-step instructions buried in reference.
When in doubt about where content belongs, ask what the reader is trying to do at that moment: learn (tutorial), accomplish a task (how-to guide), look something up (reference docs), or understand something (explanation/core concepts). 

## Table of Contents

1. [The four content types](#the-four-content-types)
2. [Landing page design](#1-landing-page-design)
3. [Getting started guide](#2-getting-started-guide)
4. [Tutorials](#3-tutorials)
5. [How-to guides](#4-how-to-guides)
6. [Concepts / explanations](#5-concepts--explanations)
7. [Reference](#6-reference)
8. [General technical writing standards](#7-general-technical-writing-standards)

---

## The four content types

| Type | Orientation | Reader's question | Analogy |
| ------ | ------------- | ------------------- | --------- |
| **Tutorial** | Learning | "Teach me the basics by doing." | Teaching a child to cook |
| **How-to guide** | Goal | "How do I solve *this specific* problem?" | Following a recipe |
| **Reference** | Information | "What are the exact facts/parameters?" | An ingredient encyclopedia |
| **Explanation** | Understanding | "Why does it work this way?" | An article on culinary history |

Keep these separate.
The clarity comes from the separation, not from any single page being exhaustive.

---

## 1. Landing page design

The landing page is a **signpost, not a destination**.
Think of it as a train station: its only job is to route each reader to the right learning flow.
It should not contain detailed content.

### Goal: shorten time to meaningful value

Every design choice on the landing page serves one metric: how quickly a reader finds the path that gets them to a useful outcome.
A disorganized entry point undermines developer experience as they might start a learning flow that doesn't answer their needs, wasting valuable time.

### Choose a persona / learning flow first

The landing page should be designed around different persona's and their learning flows.
You can organize the landing page according to those categories:

- **By role / persona**:
  - Maven User: User who has no prior knowledge about Maven
  - Build engineer/DevOps engineer: Needs to understand how to correctly deploy and maintain Maven software
  - Developers: Consume the Maven software product
  - Plugins developer: Advanced users who want to build custom tooling using Maven
  - Maven Developer: Contribute to the Maven software

Each persona links to a tailored flow.

- **By product** — when the docs portal spans multiple products, list products at level 1, each leading to its own product homepage at level 2.
We exclude any module (plugin documentation) from this home page.
- **By task or intent** — e.g. "Get started", "Configure a build", "Migrate from X".

The goal is that a reader can identify in under 10 seconds "that's me" and start the learning journey they need.
For instance, a DevOps engineer finding the docs about how to deploy a project. 

### Convey hierarchy and scope

The reader should always know *where* they are.
Use a consistent sidebar and breadcrumbs so that each level acts as a mini-homepage for its subset of content.
Multi-product portals nest: portal home → product home → section home.
This kind of structure is extremely important for devs to understand the information architecture of our docs and not get lost.

### Landing page checklist

- [ ] Can a first-time visitor identify their path in under 5 seconds?
- [ ] Are the four content types discoverable from here?
- [ ] Does "Get Started" stand out as the primary Call-To-Action (CTA)?
- [ ] Is the page kept to navigation only, with no tutorials, explanations, or other deep content that belongs on its own page?

---

## 2. Getting started guide

This is **the most important guide in the docs.** It is a special, high-stakes tutorial: the reader's first real interaction. 

### Go beyond "Hello World"

A guide that only prints a message or makes one trivial call leaves the reader thinking "…now what?" It does not show real value.
Instead, design the getting started around a **minimal but meaningful first goal**.

Ask: *what is the first useful outcome a developer wants from Maven?* 

### Structure

1. **Prerequisites** — what must be installed/available before starting (state versions explicitly).
2. **Installation** — use minimal configuration (or defaults) to keep it as error-prone as possible.
3. **Step-based instructions towards a goal** — use step-by-step based instructions to guide the user.
For a getting started guide, you can work in very small increments even though they sound to simple.
4. **Verify it worked** — a command or expected output that confirms success.
If possible, also provide steps to resolve common errors the user might see.
This helps them turn a frustrating experience into a less painful one. 
5. **Next steps** — link explicitly to what the reader should do or learn next.
Offer multiple options, since different personas often share the same getting started guide.
Each one should have a clear, obvious path forward with no guessing required.

### Keep it concise: hold the reader's hand just enough

Provide clear steps with short code snippets and a one or two-line explanation of what each does. **Avoid detours into concepts.** If a conceptual hurdle is unavoidable, link out to a [Concepts](#5-concepts--explanations) page for optional reading rather than slowing the flow down.

### Use progressive disclosure

Start with the simplest thing that works: default settings, no customization.
Once it runs, *then* optionally show how to customize one aspect or add the next call.
This way, beginners aren't overwhelmed upfront and devs who complee the tutorial get a clear path forward.

### End with a summary

Close your guide with a brief summary of what the reader learned or accomplished.
This reinforces the key takeaways and gives the guide a satisfying and purposeful ending.
It's much better than a vague "You're done!"

## 3. Tutorials

Tutorials are **learning-oriented, step-by-step lessons.** They are structurally very similar to the getting started guide but narrower in scope: each teaches the most basic *useful* thing about a single feature.
They teach by doing.

### Tutorials rules

- **One feature, one basic but useful outcome.** Don't try to accomplish too much in one tutorial.
It's more about teaching the foundational skills for a single feature.
- **Hand-holding tone.** Assume a newcomer is reading this tutorial.
Tone: friendly, encouraging, no unexplained leaps.
- **Provide sufficient context at every step:** Start with a short explanation of what's happening.
Avoid the "why" as that lives in the Core Concepts section. 
- **Progressive disclosure**, same as getting started: simplest path first, optional complexity after.
- **Link out, don't embed**, for concepts and reference detail.
Keep the learning flow straight.
We don't want to branch into other pages and then have to come back.
This is very confusing for the reader as they are unsure whether they should finish the current guide or the one they got linked to.
- **End with next steps** —> a related tutorial, a relevant how-to, or a concept page that deepens understanding.

### Tutorial vs. getting started

The getting started guide is the single front door to the whole product.
A tutorial is one of many doors into individual features.
Similar writing style but they have a different scope.

## 4. How-to guides

A how-to guide is a **goal-oriented content type.** They assume the reader already knows the basics and now needs to accomplish one specific thing or solve a problem, e.g. "Configure a multi-module build", "Deploy artifacts to a private repository", "Set up the failsafe plugin for integration tests." They don't need extensive handholding or prerequisites as this has been covered by the getting started and feature-specific tutorial.

### How-to guide rules

- **Solve one specific, real problem.** The title should name the goal: "How to *[achieve outcome]*."
- **Assume competence.** Don't re-teach fundamentals, link to a tutorial or concept page if a prerequisite is needed.
- **Straight to the steps.** Minimal preamble.
The reader wants a quick solution for their problem.
- **State assumptions and prerequisites up front**.
Open with a "What you'll learn" section so readers immediately know what the guide covers.
Follow it with a prerequisites section that clearly lists any required knowledge or setup.
This saves readers from starting a guide that isn't meant for them, especially those browsing casually without a clear sense of where they've landed.

### How-to vs. tutorial

A tutorial teaches a skill to a learner (learning phase); a how-to helps a capable user reach a goal (while in their working phase).
In other words, a tutorial is trying to teach you something in a pedagogical way while a how-to is direct and assumes the reader knows where they're going.

## 5. Concepts / explanations

Concept pages are **understanding-oriented.** They clarify the *why* and *how* behind the product like context, reasoning, architecture, design rationale.
They don't tell the reader which buttons to press.
It's sole purpose is to improve the reader's mental model.

### Two scopes

Concept pages live at two levels:

- **Feature-level** — part of a learning flow within a feature section in the docs.
After a reader finishes a tutorial they may wonder "OK, but how does this component actually work?" — this page answers that.
- **Product-level (global)** — high-level explanations of overall architecture, how the project is structured, or how the build lifecycle works.
Listed globally, not tied to one feature.

### Concepts / explanations rules

- **Explain fundamental terms and the "why."** Identify the jargon and assumptions a newcomer must grasp, e.g. what a "goal", "phase", "scope", or "coordinate" means in Maven, and define them clearly.
- **Plain language first, then formalism.** Introduce a concept narratively or with an analogy before formal definitions or code.
Relate it to something the reader already knows.
- **Use diagrams.** A visual of architecture or data flow often clarifies relationships better than paragraphs.
Include them wherever a system has moving parts that relate to each other.
- **Support non-linear readers.** Many readers land mid-docs from a search engine.
Include brief inline explanations (or links) of key terms on tutorial and how-to pages so a reader who skipped the Core Concepts section isn't lost.

## 6. Reference

Reference is **information-oriented**: a comprehensive, factual description of the "machinery": goals, plugins, parameters, lifecycle phases, CLI options, POM elements.
It's a place where a dev can look up the specifics of anything.
Most-often, this is auto-generated.

## 7. General technical writing standards

Consult this section after drafting a getting started guide, tutorial, or how-to.
These rules apply across all step-based content.

- **Use a consistent "Step 1, Step 2…" convention.** Number steps explicitly and uniformly across the docs.
Each step should only focus on one thing, don't try to fit multiple actions into a single step unless they are closely related.

- **Always provide a way to verify progress.** After a meaningful action, give a verification command or the exact expected output so the reader can confirm they're on track before moving on.

- **Keep success states visible.** Show what "it worked" looks like — output snippets, screenshots, or status lines — not just the command to run. (This tip is similar to the one above about being able to verify progress.)

- **Include common debugging tips inline, at the point of failure.** Where a step commonly fails, show the *actual error message* the reader is likely to see and how to fix it.
This lets them match-and-fix fast instead of getting frustrated and leaving.
This also changes the perspective of how we write technical content.
Instead of only trying out the happy path, we as a technical writer, should also explore the unhappy path and document it.
We can't expect everyone to be on the happy path.

- **Show the full file after multiple edits.** If the reader has to modify the same file (e.g. `pom.xml`) across several steps, include the complete final version at the end so they can diff against their own.

- **Link, don't embed, for depth.** Concepts and full reference detail belong on their own pages; link to them so the step-by-step flow stays unbroken.
It's a golden rule of writing technical content.
Never break the flow as this leave the reader in a messy, unclear place on where to go next.

- **Always end with next steps.** Never cut off with "you're done." Point to a logical next tutorial, how-to, or concept page so the reader can continue learning.

- **Use different content elements from the [Zensical framework](https://zensical.org/docs/authoring/markdown/).** By using many different elements like a callout, tabgroup, cards, etc. we can create visually interesting tutorials.
Just listing 10 steps with a few code windows doesn't look very appealing to devs. Make it a bit interesting! 
