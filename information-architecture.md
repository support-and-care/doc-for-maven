# Maven Documentation — Proposed Information Architecture

A Diataxis (Divio) restructure of the current `maven.apache.org/index.html`.
Organized on two orthogonal axes:

- **Horizontal menu = persona** (App developer · Build/DevOps engineer · Plugin developer · Maven developer)
- **Within each persona = four Diataxis quadrants** (Tutorials · How-to guides · Reference · Explanation)

The landing page routes by persona only.
Each persona homepage is a mini-signpost exposing its four quadrants (Diataxis framework implementation).

Every page carries a short **ID** (e.g. `AD-T1`) so it can be cross-referenced from the [example folder structure](#example-folder-structure-per-persona) at the bottom of this document back to its source row here.
Prefix = persona (`AD` App developer, `DO` DevOps, `PD` Plugin developer, `MD` Maven developer, `NP` Non-persona, `RM` Removed), letter = quadrant (`T` Tutorials, `H` How-to, `R` Reference, `E` Explanation), number = position in that list.

Legend for the "Action" column:

- **MOVE** — page keeps its content, relocates to a new home
- **MERGE** — page folds into another page (remove source pages after merging)
- **REMOVE** — page dropped from primary navigation (redirect/archive)
- **SPLIT** — page's content is divided across quadrants
- **NEW** — page does not exist currently; recommended addition
- **RECLASSIFY** — page stays but is relabeled to the correct content type

Every row that maps an existing page carries its current URL so this table doubles as a **redirect map**.
See the final section for pages that are **not repurposed**.

---

## Persona 1 — Application developer *(consume Maven)*

### Tutorials

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `AD-T1` | Your first Maven build in 5 minutes | Getting Started in 5 Minutes | <https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html> | MOVE | Primary "Get Started" CTA target. |
| `AD-T2` | Build a real project in 30 minutes | Getting Started in 30 Minutes | <https://maven.apache.org/guides/getting-started/index.html> | MOVE | Rename to signal deeper tutorial. |
| `AD-T3` | Running and configuring tests | *(from Surefire component docs)* | <https://maven.apache.org/surefire/index.html> | NEW | Learning-oriented; complements the how-to. |

### How-to guides

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `AD-H1` | Add and exclude dependencies | The Dependency Mechanism + Optional/Excludes | <https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html> · <https://maven.apache.org/guides/introduction/introduction-to-optional-and-excludes-dependencies.html> | MERGE→SPLIT | *How* here; *why* moves to Explanation category. |
| `AD-H2` | Configure a plugin | Configuring Plug-ins | <https://maven.apache.org/guides/mini/guide-configuring-plugins.html> | MOVE | |
| `AD-H3` | Migrate an existing build to Maven 4 | Migration to Maven 4 | <https://maven.apache.org/guides/mini/guide-migration-to-mvn4.html> | MOVE | Task-oriented guide for upgrading builds and resolving compatibility issues. |
| `AD-H4` | Use Maven Mixins | Maven Mixins | <https://maven.apache.org/guides/mini/guide-mixins.html> | MOVE | Best placed here as a concrete build-customization task. |
| `AD-H5` | Build for different environments | Building For Different Environments + Profiles | <https://maven.apache.org/guides/mini/guide-building-for-different-environments.html> · <https://maven.apache.org/guides/introduction/introduction-to-profiles.html> | MERGE→SPLIT | Steps here; concepts → Explanation. |
| `AD-H6` | Create an assembly | Creating Assemblies | <https://maven.apache.org/guides/mini/guide-assemblies.html> | MOVE | |
| `AD-H7` | Configure archive plugins | Configuring Archive Plugins | <https://maven.apache.org/guides/mini/guide-archive-configuration.html> | MOVE | |
| `AD-H8` | Work with manifests | Working with Manifests | <https://maven.apache.org/guides/mini/guide-manifest.html> | MOVE | |
| `AD-H9` | Generate sources | Generating Sources | <https://maven.apache.org/guides/mini/guide-generating-sources.html> | MOVE | |
| `AD-H10` | Install a 3rd-party JAR locally | Installing 3rd party JARs to Local Repository | <https://maven.apache.org/guides/mini/guide-3rd-party-jars-local.html> | MOVE | Remote variant → DevOps. |
| `AD-H11` | Create an archetype | Creating Archetypes | <https://maven.apache.org/guides/mini/guide-creating-archetypes.html> | MOVE | |
| `AD-H12` | Create a site | Creating a Site | <https://maven.apache.org/guides/mini/guide-site.html> | MOVE | Candidate for Maven developer — see Open questions. |

### Reference

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `AD-R1` | POM reference | POM Overview + Technical Project Descriptor + The POM | <https://maven.apache.org/pom.html> · <https://maven.apache.org/ref/current/maven-model/maven.html> · <https://maven.apache.org/guides/introduction/introduction-to-the-pom.html> | MERGE | Consolidate prose + descriptor. |
| `AD-R2` | settings.xml reference | Settings Overview + Technical Settings Descriptor | <https://maven.apache.org/settings.html> · <https://maven.apache.org/ref/current/maven-settings/settings.html> | MERGE | |
| `AD-R3` | Build lifecycle reference | *(table from The Build Lifecycle)* | <https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html> | SPLIT | Phase/goal table here; narrative → Explanation. |
| `AD-R4` | Standard directory layout | Standard Directory Layout | <https://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html> | MOVE | |
| `AD-R5` | Glossary | Glossary | <https://maven.apache.org/glossary.html> | MOVE | |
| `AD-R6` | Snippet macro | Snippet Macro | <https://maven.apache.org/guides/mini/guide-snippet-macro.html> | MOVE | Niche. |
| `AD-R7` | The APT format | The APT Format (Doxia) | <https://maven.apache.org/doxia/references/apt-format.html> | MOVE | Candidate for Maven developer — see Open questions. |

### Explanation

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `AD-E1` | What Maven is (and common misconceptions) | What is Maven? | <https://maven.apache.org/what-is-maven.html> | RECLASSIFY | Expand with misconceptions. |
| `AD-E2` | What’s new in Maven 4 | What's new in Maven 4? | <https://maven.apache.org/whatsnewinmaven4.html> | MOVE | Best as an explanation page: a concise overview of the main changes, new capabilities, and migration implications for users. |
| `AD-E3` | How the build lifecycle works | The Build Lifecycle | <https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html> | SPLIT | Split: keep the phase/goal reference table in Reference; move the explanatory narrative to Explanation. |
| `AD-E4` | The dependency mechanism | The Dependency Mechanism + Optional/Excludes | <https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html> | SPLIT | Split: keep the step-by-step instructions in How-to; move the conceptual explanation to Explanation. |
| `AD-E5` | Introduction to repositories | Repositories | <https://maven.apache.org/guides/introduction/introduction-to-repositories.html> | MOVE | Deep version → to DevOps persona. |
| `AD-E6` | What is an archetype | What is an Archetype | <https://maven.apache.org/guides/introduction/introduction-to-archetypes.html> | MOVE | |
| `AD-E7` | Understanding profiles | Profiles | <https://maven.apache.org/guides/introduction/introduction-to-profiles.html> | RECLASSIFY | Conceptual half of split. |

---

## Persona 2 — Build / DevOps engineer *(deploy & maintain)*

### Tutorials

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `DO-T1` | Set up a reproducible build | *(from Reproducible Builds guide)* | <https://maven.apache.org/guides/mini/guide-reproducible-builds.html> | NEW | End-to-end learning path. |
| `DO-T2` | Deploy your first artifact to a remote repo | *(new)* | — | NEW | Fills a tutorial gap. |

### How-to guides

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `DO-H1` | Deploy 3rd-party JARs to a remote repo | Deploying 3rd party JARs to Remote Repository | <https://maven.apache.org/guides/mini/guide-3rd-party-jars-remote.html> | MOVE | |
| `DO-H2` | Use multiple repositories | Using Multiple Repositories | <https://maven.apache.org/guides/mini/guide-multiple-repositories.html> | MOVE | |
| `DO-H3` | Configure mirror settings | Mirror Settings | <https://maven.apache.org/guides/mini/guide-mirror-settings.html> | MOVE | |
| `DO-H4` | Use proxies | Using Proxies | <https://maven.apache.org/guides/mini/guide-proxies.html> | MOVE | |
| `DO-H5` | Configure authenticated HTTPS | Authenticated HTTPS (listed twice) | <https://maven.apache.org/guides/mini/guide-repository-ssl.html> | MERGE | Two identical links today → one. |
| `DO-H6` | Deployment & security settings | Deployment and Security Settings | <https://maven.apache.org/guides/mini/guide-deployment-security-settings.html> | MOVE | |
| `DO-H7` | Large-scale centralized deployments | Large Scale Centralized Deployments | <https://maven.apache.org/guides/mini/guide-large-scale-centralized-deployments.html> | MOVE | |
| `DO-H8` | Relocate artifacts | Relocation of Artifacts | <https://maven.apache.org/guides/mini/guide-relocation.html> | MOVE | |
| `DO-H9` | Use toolchains | Using Toolchains | <https://maven.apache.org/guides/mini/guide-using-toolchains.html> | MOVE | |
| `DO-H10` | Use the Release Plugin | Using the Release Plugin | <https://maven.apache.org/guides/mini/guide-releasing.html> | MOVE | |
| `DO-H11` | Multi-module builds | Using Multiple Modules in a Build | <https://maven.apache.org/guides/mini/guide-multiple-modules.html> | MOVE | |
| `DO-H12` | Configure reproducible builds | Configuring for Reproducible Builds | <https://maven.apache.org/guides/mini/guide-reproducible-builds.html> | MOVE | |
| `DO-H13` | Inject POM properties via settings.xml | Injecting POM Properties via settings.xml | <https://maven.apache.org/examples/injecting-properties-via-settings.html> | MOVE | |
| `DO-H14` | Configure Maven | Configuring Maven | <https://maven.apache.org/guides/mini/guide-configuring-maven.html> | MERGE | Fold this into the settings.xml and Maven configuration how-to set; keep only the parts that are still actionable and remove the overlap with the settings reference. |
| `DO-H15` | Upload artifacts to Central | Uploading Artifacts to the Central Repository | <https://maven.apache.org/repository/guide-central-repository-upload.html> | MOVE | |
| `DO-H16` | Repository management | Repository Management | <https://maven.apache.org/repository-management.html> | RECLASSIFY | Vendor list; keep as overview or → Explanation. |
| `DO-H17` | Bash auto-completion | Maven Auto-Completion Using BASH | <https://maven.apache.org/guides/mini/guide-bash-m2-completion.html> | MOVE | Minor; low in list. |

### Reference

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `DO-R1` | settings.xml server/security reference | *(shared with App-dev reference)* | <https://maven.apache.org/settings.html> | MOVE | Link, don't duplicate. |
| `DO-R2` | Central Repository reference | Introduction to the Central Repository + Improving the Repository | <https://maven.apache.org/repository/> · <https://maven.apache.org/repository/central-metadata.html> | MERGE | Facts here; upload steps stay in how-to. |

### Explanation

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `DO-E1` | Repository architecture & resolution | Introduction to the Central Repository + Repositories | <https://maven.apache.org/repository/> · <https://maven.apache.org/guides/introduction/introduction-to-repositories.html> | MERGE | Deep version combining both pages |
| `DO-E2` | How reproducible builds work | *(new)* | — | NEW | Concept companion to the how-to. |
| `DO-E3` | Maven classloading | Maven Classloading | <https://maven.apache.org/guides/mini/guide-maven-classloading.html> | MOVE | Was buried under "Guides." |
| `DO-E4` | The multi-module reactor | *(new)* | — | NEW | Build order & dependency graph. |

---

## Persona 3 — Plugin developer *(build custom tooling)*

### Tutorials

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `PD-T1` | Write your first Java plugin | Developing Java Plugins | <https://maven.apache.org/guides/plugin/guide-java-plugin-development.html> | RECLASSIFY | Frame as hand-held tutorial. |
| `PD-T2` | Test a development version of a plugin | Testing Development Versions of Plugins | <https://maven.apache.org/guides/development/guide-testing-development-plugins.html> | MOVE | |

### How-to guides

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `PD-H1` | Handle plugin prefix resolution | Plugin Prefix Resolution | <https://maven.apache.org/guides/introduction/introduction-to-plugin-prefix-mapping.html> | MOVE | |
| `PD-H2` | Document a plugin to the standard | The Plugin Documentation Standard | <https://maven.apache.org/guides/development/guide-plugin-documentation.html> | MOVE | |
| `PD-H3` | Use extensions | Using Extensions | <https://maven.apache.org/guides/mini/guide-using-extensions.html> | MOVE | |
| `PD-H4` | Use Modello | Using Modello | <https://maven.apache.org/guides/mini/guide-using-modello.html> | MOVE | Niche. |
| `PD-H5` | Use Ant with Maven | Using Ant with Maven | <https://maven.apache.org/guides/mini/guide-using-ant.html> | MOVE | Interop/migration — see Open questions. |

### Reference

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `PD-R1` | **Maven plugins catalog** | Maven Plugins (index) | <https://maven.apache.org/plugins/index.html> | RECLASSIFY | Turn link farm into searchable catalog. |
| `PD-R2` | Maven Extensions catalog | Maven Extensions (index) | <https://maven.apache.org/extensions/index.html> | MOVE | |
| `PD-R3` | Maven Tools | Maven Tools + Daemon + Upgrade Tool + Wrapper | <https://maven.apache.org/tools/index.html> · <https://maven.apache.org/tools/mvnd.html> · <https://maven.apache.org/tools/mvnup.html> · <https://maven.apache.org/tools/mavenwrapper.html> | MERGE | One reference node to list all these pages. |
| `PD-R4` | Mojo API reference | Mojo API | <https://maven.apache.org/developers/mojo-api-specification.html> | MOVE | |
| `PD-R5` | Plugin API Javadoc | Maven Plugin API (Javadoc) | <https://maven.apache.org/ref/current/maven-plugin-api/apidocs/> | MOVE | |
| `PD-R6` | Reporting API Javadoc | Maven Reporting (Javadoc) | <https://maven.apache.org/shared/maven-reporting-api/apidocs/> | MOVE | |
| `PD-R7` | Archetypes reference | Archetypes | <https://maven.apache.org/archetypes/index.html> | MOVE | Cross-link to App dev — see Open questions. |
| `PD-R8` | Parent POMs reference | Parent POMs | <https://maven.apache.org/pom/index.html> | MOVE | |
| `PD-R9` | Skins reference | Skins | <https://maven.apache.org/skins/index.html> | MOVE | |
| `PD-R10` | Components reference index | Components (11 items) | <https://maven.apache.org/archetype/index.html> · <https://maven.apache.org/resolver/index.html> · <https://maven.apache.org/doxia/index.html> · <https://maven.apache.org/maven-indexer/index.html> · <https://maven.apache.org/jxr/index.html> · <https://maven.apache.org/plugin-testing/index.html> · <https://maven.apache.org/plugin-tools/index.html> · <https://maven.apache.org/apache-resource-bundles/index.html> · <https://maven.apache.org/scm/index.html> · <https://maven.apache.org/surefire/index.html> · <https://maven.apache.org/wagon/index.html> | MERGE | Collapse into one index called "Components". |

### Explanation

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `PD-E1` | Plugin architecture & the Mojo model | Plugin Development (Introduction to Plugins) | <https://maven.apache.org/guides/introduction/introduction-to-plugins.html> | RECLASSIFY | Conceptual "how plugins work." |
| `PD-E2` | Best practices for plugin design | *(new)* | — | NEW | |

---

## Persona 4 — Maven developer *(contribute to Maven)*

### Tutorials

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `MD-T1` | Build Maven from source | Building Maven from Scratch | <https://maven.apache.org/guides/development/guide-building-maven.html> | RECLASSIFY | Frame as tutorial. |
| `MD-T2` | Make your first contribution | Guide for New Committers | <https://maven.apache.org/guides/mini/guide-new-committers.html> | RECLASSIFY | |

### How-to guides

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `MD-H1` | Set up the development environment | Developing Maven | <https://maven.apache.org/guides/development/guide-maven-development.html> | MOVE | |
| `MD-H2` | Help with Maven | Helping with Maven | <https://maven.apache.org/guides/development/guide-helping.html> | MOVE | |
| `MD-H3` | Follow naming conventions | Naming Conventions | <https://maven.apache.org/guides/mini/guide-naming-conventions.html> | MOVE | |
| `MD-H4` | Work around the conventions | When You Can't Use the Conventions | <https://maven.apache.org/guides/mini/guide-using-one-source-directory.html> | MOVE | |

### Reference

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `MD-R1` | Maven Core component reference | Maven (ref/current) + Maven Core Javadoc | <https://maven.apache.org/ref/current> · <https://maven.apache.org/ref/current/maven-core/apidocs/> | MERGE | Merge the general Maven core reference and the core Javadoc into one reference page so contributors can find both the overview and the API details in the same place. |
| `MD-R2` | Model / Artifact / Settings Javadoc | Maven Model + Artifact + Settings (Javadoc) | <https://maven.apache.org/ref/current/maven-model/apidocs/> · <https://maven.apache.org/ref/current/maven-artifact/apidocs/> · <https://maven.apache.org/ref/current/maven-settings/apidocs/> | MERGE | Merge these into a single reference entry for contributors because they are all API documentation for related Maven core model components and are easier to discover together. |
| `MD-R3` | Full technical references | full technical documentation references | <https://maven.apache.org/ref/current/> | MOVE | Catch-all reference index. |
| `MD-R4` | Documentation style reference | Maven Documentation Style | <https://maven.apache.org/guides/development/guide-documentation-style.html> | MOVE | |
| `MD-R5` | Maven conventions | Maven Conventions | <https://maven.apache.org/maven-conventions.html> | MOVE | |

### Explanation *(heaviest new investment —> the internals docs)*

| ID | New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- | --- |
| `MD-E1` | Maven 4 Core architecture overview | *(new)* | — | NEW | How components fit together. |
| `MD-E2` | Each component in isolation | *(new)* | — | NEW | What each does on its own. |
| `MD-E3` | Component workflow during a build | *(new)* | — | NEW | How components interact. |
| `MD-E4` | Best practices for writing Maven internals | *(new)* | — | NEW | |
| `MD-E5` | Misconceptions about Maven, corrected | *(new)* | — | NEW | Cross-link from "What Maven is." |

---

## Non-persona pages (keep, but off the persona menus)

These aren't part of a learning flow.
Keep them in a global footer or "About / Community" area on the main landing page so they don't clutter other flows or menus. 

| ID | Page | Old URL | Action | New home |
| --- | --- | --- | --- | --- |
| `NP1` | Installation | <https://maven.apache.org/install.html> | MOVE | Prerequisite; link from every first tutorial. |
| `NP2` | Release Notes / History | <https://maven.apache.org/docs/history.html> | MOVE | About area. |
| `NP3` | Security Reports | <https://maven.apache.org/security.html> | MOVE | About area. |
| `NP4` | Community Overview | <https://maven.apache.org/community.html> | MOVE | Community area. |
| `NP5` | Project Roles | <https://maven.apache.org/project-roles.html> | MOVE | Community area. |
| `NP6` | Getting Help | <https://maven.apache.org/users/getting-help.html> | MOVE | Community area; link from every persona. |
| `NP7` | Issue Management | <https://maven.apache.org/issue-management.html> | MOVE | Community area. |
| `NP8` | The Maven Team | <https://maven.apache.org/team.html> | MOVE | Community area. |
| `NP9` | Books and Resources + 3rd Party Resources | <https://maven.apache.org/articles.html> | MERGE | One "Resources" page (both links point here today). |
| `NP10` | How Apache Works | <https://www.apache.org/foundation/how-it-works.html> | MOVE | ASF footer (unchanged). |
| `NP11` | Foundation | <https://www.apache.org/foundation/> | MOVE | ASF footer. |
| `NP12` | Data Privacy | <https://privacy.apache.org/policies/privacy-policy-public.html> | MOVE | ASF footer. |
| `NP13` | Sponsoring Apache | <https://www.apache.org/foundation/sponsorship.html> | MOVE | ASF footer. |
| `NP14` | Thanks | <https://www.apache.org/foundation/thanks.html> | MOVE | ASF footer. |

---

## Pages not repurposed —> remove or redirect

The below pages are auto-generated or navigational stubs that can be removed/absorbed by other pages in the new information architecture. 

### A. Site boilerplate / auto-generated (not user documentation)

| ID | Page | Old URL | Action | Reason |
| --- | --- | --- | --- | --- |
| `RM-A1` | Project Information | <https://maven.apache.org/project-info.html> | REMOVE | Auto-generated Maven project-info report, not docs. |
| `= MD-R3` | Maven (Maven Projects block) | <https://maven.apache.org/ref/current> | KEEP as reference | Not removed — mapped to Maven-dev reference (same `ref/current` target used above). |

### B. Navigational stubs absorbed elsewhere (thin pages whose content redistributes)

| ID | Page | Old URL | Action | Absorbed into |
| --- | --- | --- | --- | --- |
| `RM-B1` | Welcome | <https://maven.apache.org/index.html> | REMOVE from docs IA | Site home, not documentation. |
| `RM-B2` | Use | <https://maven.apache.org/run.html> | REMOVE (SPLIT) | Content → App-dev tutorials/how-tos. |
| `RM-B3` | Configure | <https://maven.apache.org/configure.html> | REMOVE (SPLIT) | Content → App-dev how-tos + settings reference. |
| `RM-B4` | User Manual | <https://maven.apache.org/users/index.html> | REMOVE | Superseded by the persona homepages. |
| `RM-B5` | Maven Repositories (index) | <https://maven.apache.org/repositories/index.html> | REMOVE | Superseded by DevOps persona homepage. |
| `RM-B6` | Plugin Development (index) | <https://maven.apache.org/plugin-developers/index.html> | REMOVE | Superseded by Plugin-dev persona homepage. |
| `RM-B7` | Contribute to Maven (index) | <https://maven.apache.org/developers/index.html> | REMOVE | Superseded by Maven-dev persona homepage. |
| `RM-B8` | License | <https://www.apache.org/licenses/> | REMOVE from docs IA | Standard ASF footer link, not documentation. |

---

## Summary of structural changes

**Biggest merges:** POM overview + descriptor + intro → one POM reference; settings overview + descriptor → one settings.xml reference; the 11-item Components list → one reference index; Maven Tools + 3 sub-pages → one Tools node; scattered Javadoc → consolidated per persona.

**Biggest reclassifications:** the flat "Guides" dumping ground dissolves — each page lands in a specific persona + quadrant. "Maven Classloading" and the plugin index move to their correct content types.

**Biggest new investment:** the Explanation quadrant, especially the Maven 4 Core internals set (architecture overview → per-component → workflow), best-practices docs, and the misconceptions page.

---

## Migration plan

### Phase 1 — Restructure (highest priority)

**Why first:** discoverability is the biggest lever we have.
Most of today's content is fine, it's just unfindable or buried in a nested structure with no persona signposting.
Landing pages, persona homepages, and the Diataxis framework should solve these issues.
This phase is pure information architecture work: no new writing, no rewriting existing content.

Scope — everything tagged **MOVE**, **MERGE**, **SPLIT**, **RECLASSIFY**, and **REMOVE** in the tables above:

1. Build the top-level landing page that routes by persona (4 personas).
2. Build each persona homepage as a quadrant signpost (Tutorials · How-to guides · Reference · Explanation).
3. Relocate **MOVE** pages to their new home; content unchanged, URL/nav position changes.
4. Execute **MERGE**s (POM overview + descriptor, settings overview + descriptor, the 11-item Components list, Maven Tools + sub-pages, scattered Javadoc, etc.) — combine pages, remove the now-redundant sources.
5. Execute **SPLIT**s (Dependency Mechanism, Build Lifecycle, Building for Different Environments) — divide content between the How-to and Explanation quadrants.
6. Apply **RECLASSIFY**s — same content, correct content-type label (e.g., "What is Maven?" → Explanation, plugin index → Reference catalog).
7. Set up redirects for every relocated/merged/removed URL (the tables above double as the redirect map) and drop the pages in "Non-persona pages" and "Pages NOT repurposed" from primary nav.
8. Verify no orphaned links.

### Phase 2 — New content

This phase is about writing new material against a settled structure.
Pages tagged **NEW** across the tables above, roughly in priority order:

- **App developer:** Running and configuring tests (Tutorial)
- **DevOps engineer:** Set up a reproducible build (Tutorial); Deploy your first artifact to a remote repo (Tutorial); How reproducible builds work (Explanation); The multi-module reactor (Explanation)
- **Plugin developer:** Best practices for plugin design (Explanation)
- **Maven developer** *(heaviest investment — the internals docs)*: Maven 4 Core architecture overview; Each component in isolation; Component workflow during a build; Best practices for writing Maven internals; Misconceptions about Maven, corrected (Explanation quadrant)

### Phase 3 — Rewrite according to writing style guide

Rewrite existing content against the writing style guide.
See [writing-guide.md](writing-guide.md) for the rules for each type of content.

- Prioritize the highest-traffic pages first (the 5-minute and 30-minute tutorials, popular guides, ...)

---

## Example folder structure (per persona)

What Phase 1 produces on disk/nav once every page has moved.
Each persona gets an identical five-bucket shape; only the App developer persona gets a standalone "Getting started" slot, since it's the only one with an explicit hand-holding entry tutorial called out as the primary CTA target (`AD-T1`) — the other personas' tutorial sets are small enough that a separate "getting started" bucket would be an empty gesture, so their tutorials list starts at the deep end.
IDs in parentheses map each leaf back to its row in the tables above.

One tweak versus the requested shape: "guides" → "how-to guides" and "Key Concepts" → "key concepts (Explanation)", so the folder labels echo the Diataxis quadrant names used everywhere else in this doc — makes it obvious at a glance which quadrant a reader landed in.

```text
app-developer/
|
|- getting started [NEW landing page]
|-- Your first Maven build in 5 minutes           (AD-T1)
|
|- tutorials
|-- Build a real project in 30 minutes            (AD-T2)
|-- Running and configuring tests [NEW]           (AD-T3)
|
|- how-to guides
|-- Add and exclude dependencies                  (AD-H1)
|-- Configure a plugin                            (AD-H2)
|-- Migrate an existing build to Maven 4          (AD-H3)
|-- Use Maven Mixins                              (AD-H4)
|-- Build for different environments              (AD-H5)
|-- Create an assembly                            (AD-H6)
|-- Configure archive plugins                     (AD-H7)
|-- Work with manifests                           (AD-H8)
|-- Generate sources                              (AD-H9)
|-- Install a 3rd-party JAR locally               (AD-H10)
|-- Create an archetype                           (AD-H11)
|-- Create a site                                 (AD-H12)
|
|- key concepts (Explanation)
|-- What Maven is (and common misconceptions)     (AD-E1)
|-- What's new in Maven 4                         (AD-E2)
|-- How the build lifecycle works                 (AD-E3)
|-- The dependency mechanism                      (AD-E4)
|-- Introduction to repositories                  (AD-E5)
|-- What is an archetype                          (AD-E6)
|-- Understanding profiles                        (AD-E7)
|
|- reference guide
|-- POM reference                                 (AD-R1)
|-- settings.xml reference                        (AD-R2)
|-- Build lifecycle reference                     (AD-R3)
|-- Standard directory layout                     (AD-R4)
|-- Glossary                                      (AD-R5)
|-- Snippet macro                                 (AD-R6)
|-- The APT format                                (AD-R7)
```

```text
devops-engineer/
|
|- getting started [NEW landing page]
|
|- tutorials
|-- Set up a reproducible build [NEW]                 (DO-T1)
|-- Deploy your first artifact to a remote repo [NEW] (DO-T2)
|
|- how-to guides
|-- Deploy 3rd-party JARs to a remote repo        (DO-H1)
|-- Use multiple repositories                     (DO-H2)
|-- Configure mirror settings                     (DO-H3)
|-- Use proxies                                   (DO-H4)
|-- Configure authenticated HTTPS                 (DO-H5)
|-- Deployment & security settings                (DO-H6)
|-- Large-scale centralized deployments           (DO-H7)
|-- Relocate artifacts                            (DO-H8)
|-- Use toolchains                                (DO-H9)
|-- Use the Release Plugin                        (DO-H10)
|-- Multi-module builds                           (DO-H11)
|-- Configure reproducible builds                 (DO-H12)
|-- Inject POM properties via settings.xml        (DO-H13)
|-- Configure Maven                               (DO-H14)
|-- Upload artifacts to Central                   (DO-H15)
|-- Repository management                         (DO-H16)
|-- Bash auto-completion                          (DO-H17)
|
|- key concepts (Explanation)
|-- Repository architecture & resolution          (DO-E1)
|-- How reproducible builds work [NEW]            (DO-E2)
|-- Maven classloading                            (DO-E3)
|-- The multi-module reactor [NEW]                (DO-E4)
|
|- reference guide
|-- settings.xml server/security reference        (DO-R1)
|-- Central Repository reference                  (DO-R2)
```

```text
plugin-developer/
|
|- getting started [NEW landing page]
|
|- tutorials
|-- Write your first Java plugin                  (PD-T1)
|-- Test a development version of a plugin        (PD-T2)
|
|- how-to guides
|-- Handle plugin prefix resolution               (PD-H1)
|-- Document a plugin to the standard             (PD-H2)
|-- Use extensions                                (PD-H3)
|-- Use Modello                                   (PD-H4)
|-- Use Ant with Maven                            (PD-H5)
|
|- key concepts (Explanation)
|-- Plugin architecture & the Mojo model          (PD-E1)
|-- Best practices for plugin design [NEW]        (PD-E2)
|
|- reference guide
|-- Maven plugins catalog                         (PD-R1)
|-- Maven Extensions catalog                      (PD-R2)
|-- Maven Tools                                   (PD-R3)
|-- Mojo API reference                            (PD-R4)
|-- Plugin API Javadoc                            (PD-R5)
|-- Reporting API Javadoc                         (PD-R6)
|-- Archetypes reference                          (PD-R7)
|-- Parent POMs reference                         (PD-R8)
|-- Skins reference                               (PD-R9)
|-- Components reference index                    (PD-R10)
```

```text
maven-developer/
|
|- getting started [NEW landing page]
|
|- tutorials
|-- Build Maven from source                       (MD-T1)
|-- Make your first contribution                  (MD-T2)
|
|- how-to guides
|-- Set up the development environment            (MD-H1)
|-- Help with Maven                               (MD-H2)
|-- Follow naming conventions                     (MD-H3)
|-- Work around the conventions                   (MD-H4)
|
|- key concepts (Explanation) -- heaviest new investment
|-- Maven 4 Core architecture overview [NEW]          (MD-E1)
|-- Each component in isolation [NEW]                 (MD-E2)
|-- Component workflow during a build [NEW]           (MD-E3)
|-- Best practices for writing Maven internals [NEW]  (MD-E4)
|-- Misconceptions about Maven, corrected [NEW]       (MD-E5)
|
|- reference guide
|-- Maven Core component reference                (MD-R1)
|-- Model / Artifact / Settings Javadoc           (MD-R2)
|-- Full technical references                     (MD-R3)
|-- Documentation style reference                 (MD-R4)
|-- Maven conventions                             (MD-R5)
```

```text
site root/
|
|- index.html  -- routes by persona, links to the four trees above!
|
|- about / community footer  -- not in any persona flow
|-- Installation                                  (NP1)
|-- Release Notes / History                       (NP2)
|-- Security Reports                              (NP3)
|-- Community Overview                            (NP4)
|-- Project Roles                                 (NP5)
|-- Getting Help                                  (NP6)
|-- Issue Management                              (NP7)
|-- The Maven Team                                (NP8)
|-- Resources (merged Books + 3rd Party)          (NP9)
|
|- ASF footer  -- unchanged, foundation-wide
|-- How Apache Works                              (NP10)
|-- Foundation                                    (NP11)
|-- Data Privacy                                  (NP12)
|-- Sponsoring Apache                             (NP13)
|-- Thanks                                        (NP14)
```
 