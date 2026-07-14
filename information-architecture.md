# Maven Documentation — Proposed Information Architecture

A Diataxis (Divio) restructure of the current `maven.apache.org/index.html`.
Organized on two orthogonal axes:

- **Horizontal menu = persona** (App developer · Build/DevOps engineer · Plugin developer · Maven developer)
- **Within each persona = four Diataxis quadrants** (Tutorials · How-to guides · Reference · Explanation)

The landing page routes by persona only.
Each persona homepage is a mini-signpost exposing its four quadrants (Diataxis framework implementation).

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

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| Your first Maven build in 5 minutes | Getting Started in 5 Minutes | <https://maven.apache.org/guides/getting-started/maven-in-five-minutes.html> | MOVE | Primary "Get Started" CTA target. |
| Build a real project in 30 minutes | Getting Started in 30 Minutes | <https://maven.apache.org/guides/getting-started/index.html> | MOVE | Rename to signal deeper tutorial. |
| Running and configuring tests | *(from Surefire component docs)* | <https://maven.apache.org/surefire/index.html> | NEW | Learning-oriented; complements the how-to. |

### How-to guides

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| Add and exclude dependencies | The Dependency Mechanism + Optional/Excludes | <https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html> · <https://maven.apache.org/guides/introduction/introduction-to-optional-and-excludes-dependencies.html> | MERGE→SPLIT | *How* here; *why* moves to Explanation category. |
| Configure a plugin | Configuring Plug-ins | <https://maven.apache.org/guides/mini/guide-configuring-plugins.html> | MOVE | |
| Migrate an existing build to Maven 4 | Migration to Maven 4 | <https://maven.apache.org/guides/mini/guide-migration-to-mvn4.html> | MOVE | Task-oriented guide for upgrading builds and resolving compatibility issues. |
| Use Maven Mixins | Maven Mixins | <https://maven.apache.org/guides/mini/guide-mixins.html> | MOVE | Best placed here as a concrete build-customization task. |
| Build for different environments | Building For Different Environments + Profiles | <https://maven.apache.org/guides/mini/guide-building-for-different-environments.html> · <https://maven.apache.org/guides/introduction/introduction-to-profiles.html> | MERGE→SPLIT | Steps here; concepts → Explanation. |
| Create an assembly | Creating Assemblies | <https://maven.apache.org/guides/mini/guide-assemblies.html> | MOVE | |
| Configure archive plugins | Configuring Archive Plugins | <https://maven.apache.org/guides/mini/guide-archive-configuration.html> | MOVE | |
| Work with manifests | Working with Manifests | <https://maven.apache.org/guides/mini/guide-manifest.html> | MOVE | |
| Generate sources | Generating Sources | <https://maven.apache.org/guides/mini/guide-generating-sources.html> | MOVE | |
| Install a 3rd-party JAR locally | Installing 3rd party JARs to Local Repository | <https://maven.apache.org/guides/mini/guide-3rd-party-jars-local.html> | MOVE | Remote variant → DevOps. |
| Create an archetype | Creating Archetypes | <https://maven.apache.org/guides/mini/guide-creating-archetypes.html> | MOVE | |
| Create a site | Creating a Site | <https://maven.apache.org/guides/mini/guide-site.html> | MOVE | Candidate for Maven developer — see Open questions. |

### Reference

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| POM reference | POM Overview + Technical Project Descriptor + The POM | <https://maven.apache.org/pom.html> · <https://maven.apache.org/ref/current/maven-model/maven.html> · <https://maven.apache.org/guides/introduction/introduction-to-the-pom.html> | MERGE | Consolidate prose + descriptor. |
| settings.xml reference | Settings Overview + Technical Settings Descriptor | <https://maven.apache.org/settings.html> · <https://maven.apache.org/ref/current/maven-settings/settings.html> | MERGE | |
| Build lifecycle reference | *(table from The Build Lifecycle)* | <https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html> | SPLIT | Phase/goal table here; narrative → Explanation. |
| Standard directory layout | Standard Directory Layout | <https://maven.apache.org/guides/introduction/introduction-to-the-standard-directory-layout.html> | MOVE | |
| Glossary | Glossary | <https://maven.apache.org/glossary.html> | MOVE | |
| Snippet macro | Snippet Macro | <https://maven.apache.org/guides/mini/guide-snippet-macro.html> | MOVE | Niche. |
| The APT format | The APT Format (Doxia) | <https://maven.apache.org/doxia/references/apt-format.html> | MOVE | Candidate for Maven developer — see Open questions. |

### Explanation

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| What Maven is (and common misconceptions) | What is Maven? | <https://maven.apache.org/what-is-maven.html> | RECLASSIFY | Expand with misconceptions. |
| What’s new in Maven 4 | What's new in Maven 4? | <https://maven.apache.org/whatsnewinmaven4.html> | MOVE | Best as an explanation page: a concise overview of the main changes, new capabilities, and migration implications for users. |
| How the build lifecycle works | The Build Lifecycle | <https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html> | SPLIT | Split: keep the phase/goal reference table in Reference; move the explanatory narrative to Explanation. |
| The dependency mechanism | The Dependency Mechanism + Optional/Excludes | <https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html> | SPLIT | Split: keep the step-by-step instructions in How-to; move the conceptual explanation to Explanation. |
| Introduction to repositories | Repositories | <https://maven.apache.org/guides/introduction/introduction-to-repositories.html> | MOVE | Deep version → to DevOps persona. |
| What is an archetype | What is an Archetype | <https://maven.apache.org/guides/introduction/introduction-to-archetypes.html> | MOVE | |
| Understanding profiles | Profiles | <https://maven.apache.org/guides/introduction/introduction-to-profiles.html> | RECLASSIFY | Conceptual half of split. |

---

## Persona 2 — Build / DevOps engineer *(deploy & maintain)*

### Tutorials

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| Set up a reproducible build | *(from Reproducible Builds guide)* | <https://maven.apache.org/guides/mini/guide-reproducible-builds.html> | NEW | End-to-end learning path. |
| Deploy your first artifact to a remote repo | *(new)* | — | NEW | Fills a tutorial gap. |

### How-to guides

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| Deploy 3rd-party JARs to a remote repo | Deploying 3rd party JARs to Remote Repository | <https://maven.apache.org/guides/mini/guide-3rd-party-jars-remote.html> | MOVE | |
| Use multiple repositories | Using Multiple Repositories | <https://maven.apache.org/guides/mini/guide-multiple-repositories.html> | MOVE | |
| Configure mirror settings | Mirror Settings | <https://maven.apache.org/guides/mini/guide-mirror-settings.html> | MOVE | |
| Use proxies | Using Proxies | <https://maven.apache.org/guides/mini/guide-proxies.html> | MOVE | |
| Configure authenticated HTTPS | Authenticated HTTPS (listed twice) | <https://maven.apache.org/guides/mini/guide-repository-ssl.html> | MERGE | Two identical links today → one. |
| Deployment & security settings | Deployment and Security Settings | <https://maven.apache.org/guides/mini/guide-deployment-security-settings.html> | MOVE | |
| Large-scale centralized deployments | Large Scale Centralized Deployments | <https://maven.apache.org/guides/mini/guide-large-scale-centralized-deployments.html> | MOVE | |
| Relocate artifacts | Relocation of Artifacts | <https://maven.apache.org/guides/mini/guide-relocation.html> | MOVE | |
| Use toolchains | Using Toolchains | <https://maven.apache.org/guides/mini/guide-using-toolchains.html> | MOVE | |
| Use the Release Plugin | Using the Release Plugin | <https://maven.apache.org/guides/mini/guide-releasing.html> | MOVE | |
| Multi-module builds | Using Multiple Modules in a Build | <https://maven.apache.org/guides/mini/guide-multiple-modules.html> | MOVE | |
| Configure reproducible builds | Configuring for Reproducible Builds | <https://maven.apache.org/guides/mini/guide-reproducible-builds.html> | MOVE | |
| Inject POM properties via settings.xml | Injecting POM Properties via settings.xml | <https://maven.apache.org/examples/injecting-properties-via-settings.html> | MOVE | |
| Configure Maven | Configuring Maven | <https://maven.apache.org/guides/mini/guide-configuring-maven.html> | MERGE | Fold this into the settings.xml and Maven configuration how-to set; keep only the parts that are still actionable and remove the overlap with the settings reference. |
| Upload artifacts to Central | Uploading Artifacts to the Central Repository | <https://maven.apache.org/repository/guide-central-repository-upload.html> | MOVE | |
| Repository management | Repository Management | <https://maven.apache.org/repository-management.html> | RECLASSIFY | Vendor list; keep as overview or → Explanation. |
| Bash auto-completion | Maven Auto-Completion Using BASH | <https://maven.apache.org/guides/mini/guide-bash-m2-completion.html> | MOVE | Minor; low in list. |

### Reference

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| settings.xml server/security reference | *(shared with App-dev reference)* | <https://maven.apache.org/settings.html> | MOVE | Link, don't duplicate. |
| Central Repository reference | Introduction to the Central Repository + Improving the Repository | <https://maven.apache.org/repository/> · <https://maven.apache.org/repository/central-metadata.html> | MERGE | Facts here; upload steps stay in how-to. |

### Explanation

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| Repository architecture & resolution | Introduction to the Central Repository + Repositories | <https://maven.apache.org/repository/> · <https://maven.apache.org/guides/introduction/introduction-to-repositories.html> | MERGE | Deep version combining both pages |
| How reproducible builds work | *(new)* | — | NEW | Concept companion to the how-to. |
| Maven classloading | Maven Classloading | <https://maven.apache.org/guides/mini/guide-maven-classloading.html> | MOVE | Was buried under "Guides." |
| The multi-module reactor | *(new)* | — | NEW | Build order & dependency graph. |

---

## Persona 3 — Plugin developer *(build custom tooling)*

### Tutorials

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| Write your first Java plugin | Developing Java Plugins | <https://maven.apache.org/guides/plugin/guide-java-plugin-development.html> | RECLASSIFY | Frame as hand-held tutorial. |
| Test a development version of a plugin | Testing Development Versions of Plugins | <https://maven.apache.org/guides/development/guide-testing-development-plugins.html> | MOVE | |

### How-to guides

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| Handle plugin prefix resolution | Plugin Prefix Resolution | <https://maven.apache.org/guides/introduction/introduction-to-plugin-prefix-mapping.html> | MOVE | |
| Document a plugin to the standard | The Plugin Documentation Standard | <https://maven.apache.org/guides/development/guide-plugin-documentation.html> | MOVE | |
| Use extensions | Using Extensions | <https://maven.apache.org/guides/mini/guide-using-extensions.html> | MOVE | |
| Use Modello | Using Modello | <https://maven.apache.org/guides/mini/guide-using-modello.html> | MOVE | Niche. |
| Use Ant with Maven | Using Ant with Maven | <https://maven.apache.org/guides/mini/guide-using-ant.html> | MOVE | Interop/migration — see Open questions. |

### Reference

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| **Maven plugins catalog** | Maven Plugins (index) | <https://maven.apache.org/plugins/index.html> | RECLASSIFY | Turn link farm into searchable catalog. |
| Maven Extensions catalog | Maven Extensions (index) | <https://maven.apache.org/extensions/index.html> | MOVE | |
| Maven Tools | Maven Tools + Daemon + Upgrade Tool + Wrapper | <https://maven.apache.org/tools/index.html> · <https://maven.apache.org/tools/mvnd.html> · <https://maven.apache.org/tools/mvnup.html> · <https://maven.apache.org/tools/mavenwrapper.html> | MERGE | One reference node to list all these pages. |
| Mojo API reference | Mojo API | <https://maven.apache.org/developers/mojo-api-specification.html> | MOVE | |
| Plugin API Javadoc | Maven Plugin API (Javadoc) | <https://maven.apache.org/ref/current/maven-plugin-api/apidocs/> | MOVE | |
| Reporting API Javadoc | Maven Reporting (Javadoc) | <https://maven.apache.org/shared/maven-reporting-api/apidocs/> | MOVE | |
| Archetypes reference | Archetypes | <https://maven.apache.org/archetypes/index.html> | MOVE | Cross-link to App dev — see Open questions. |
| Parent POMs reference | Parent POMs | <https://maven.apache.org/pom/index.html> | MOVE | |
| Skins reference | Skins | <https://maven.apache.org/skins/index.html> | MOVE | |
| Components reference index | Components (11 items) | <https://maven.apache.org/archetype/index.html> · <https://maven.apache.org/resolver/index.html> · <https://maven.apache.org/doxia/index.html> · <https://maven.apache.org/maven-indexer/index.html> · <https://maven.apache.org/jxr/index.html> · <https://maven.apache.org/plugin-testing/index.html> · <https://maven.apache.org/plugin-tools/index.html> · <https://maven.apache.org/apache-resource-bundles/index.html> · <https://maven.apache.org/scm/index.html> · <https://maven.apache.org/surefire/index.html> · <https://maven.apache.org/wagon/index.html> | MERGE | Collapse into one index called "Components". |

### Explanation

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| Plugin architecture & the Mojo model | Plugin Development (Introduction to Plugins) | <https://maven.apache.org/guides/introduction/introduction-to-plugins.html> | RECLASSIFY | Conceptual "how plugins work." |
| Best practices for plugin design | *(new)* | — | NEW | |

---

## Persona 4 — Maven developer *(contribute to Maven)*

### Tutorials

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| Build Maven from source | Building Maven from Scratch | <https://maven.apache.org/guides/development/guide-building-maven.html> | RECLASSIFY | Frame as tutorial. |
| Make your first contribution | Guide for New Committers | <https://maven.apache.org/guides/mini/guide-new-committers.html> | RECLASSIFY | |

### How-to guides

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| Set up the development environment | Developing Maven | <https://maven.apache.org/guides/development/guide-maven-development.html> | MOVE | |
| Help with Maven | Helping with Maven | <https://maven.apache.org/guides/development/guide-helping.html> | MOVE | |
| Follow naming conventions | Naming Conventions | <https://maven.apache.org/guides/mini/guide-naming-conventions.html> | MOVE | |
| Work around the conventions | When You Can't Use the Conventions | <https://maven.apache.org/guides/mini/guide-using-one-source-directory.html> | MOVE | |

### Reference

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| Maven Core component reference | Maven (ref/current) + Maven Core Javadoc | <https://maven.apache.org/ref/current> · <https://maven.apache.org/ref/current/maven-core/apidocs/> | MERGE | Merge the general Maven core reference and the core Javadoc into one reference page so contributors can find both the overview and the API details in the same place. |
| Model / Artifact / Settings Javadoc | Maven Model + Artifact + Settings (Javadoc) | <https://maven.apache.org/ref/current/maven-model/apidocs/> · <https://maven.apache.org/ref/current/maven-artifact/apidocs/> · <https://maven.apache.org/ref/current/maven-settings/apidocs/> | MERGE | Merge these into a single reference entry for contributors because they are all API documentation for related Maven core model components and are easier to discover together. |
| Full technical references | full technical documentation references | <https://maven.apache.org/ref/current/> | MOVE | Catch-all reference index. |
| Documentation style reference | Maven Documentation Style | <https://maven.apache.org/guides/development/guide-documentation-style.html> | MOVE | |
| Maven conventions | Maven Conventions | <https://maven.apache.org/maven-conventions.html> | MOVE | |

### Explanation *(heaviest new investment —> the internals docs)*

| New page | Source (current) | Old URL | Action | Notes |
| --- | --- | --- | --- | --- |
| Maven 4 Core architecture overview | *(new)* | — | NEW | How components fit together. |
| Each component in isolation | *(new)* | — | NEW | What each does on its own. |
| Component workflow during a build | *(new)* | — | NEW | How components interact. |
| Best practices for writing Maven internals | *(new)* | — | NEW | |
| Misconceptions about Maven, corrected | *(new)* | — | NEW | Cross-link from "What Maven is." |

---

## Non-persona pages (keep, but off the persona menus)

These aren't part of a learning flow.
Keep them in a global footer or "About / Community" area on the main landing page so they don't clutter other flows or menus. 

| Page | Old URL | Action | New home |
| --- | --- | --- | --- |
| Installation | <https://maven.apache.org/install.html> | MOVE | Prerequisite; link from every first tutorial. |
| Release Notes / History | <https://maven.apache.org/docs/history.html> | MOVE | About area. |
| Security Reports | <https://maven.apache.org/security.html> | MOVE | About area. |
| Community Overview | <https://maven.apache.org/community.html> | MOVE | Community area. |
| Project Roles | <https://maven.apache.org/project-roles.html> | MOVE | Community area. |
| Getting Help | <https://maven.apache.org/users/getting-help.html> | MOVE | Community area; link from every persona. |
| Issue Management | <https://maven.apache.org/issue-management.html> | MOVE | Community area. |
| The Maven Team | <https://maven.apache.org/team.html> | MOVE | Community area. |
| Books and Resources + 3rd Party Resources | <https://maven.apache.org/articles.html> | MERGE | One "Resources" page (both links point here today). |
| How Apache Works | <https://www.apache.org/foundation/how-it-works.html> | MOVE | ASF footer (unchanged). |
| Foundation | <https://www.apache.org/foundation/> | MOVE | ASF footer. |
| Data Privacy | <https://privacy.apache.org/policies/privacy-policy-public.html> | MOVE | ASF footer. |
| Sponsoring Apache | <https://www.apache.org/foundation/sponsorship.html> | MOVE | ASF footer. |
| Thanks | <https://www.apache.org/foundation/thanks.html> | MOVE | ASF footer. |

---

## Pages not repurposed —> remove or redirect

The below pages are auto-generated or navigational stubs that can be removed/absorbed by other pages in the new information architecture. 

### A. Site boilerplate / auto-generated (not user documentation)

| Page | Old URL | Action | Reason |
| --- | --- | --- | --- |
| Project Information | <https://maven.apache.org/project-info.html> | REMOVE | Auto-generated Maven project-info report, not docs. |
| Maven (Maven Projects block) | <https://maven.apache.org/ref/current> | KEEP as reference | Not removed — mapped to Maven-dev reference (same `ref/current` target used above). |

### B. Navigational stubs absorbed elsewhere (thin pages whose content redistributes)

| Page | Old URL | Action | Absorbed into |
| --- | --- | --- | --- |
| Welcome | <https://maven.apache.org/index.html> | REMOVE from docs IA | Site home, not documentation. |
| Use | <https://maven.apache.org/run.html> | REMOVE (SPLIT) | Content → App-dev tutorials/how-tos. |
| Configure | <https://maven.apache.org/configure.html> | REMOVE (SPLIT) | Content → App-dev how-tos + settings reference. |
| User Manual | <https://maven.apache.org/users/index.html> | REMOVE | Superseded by the persona homepages. |
| Maven Repositories (index) | <https://maven.apache.org/repositories/index.html> | REMOVE | Superseded by DevOps persona homepage. |
| Plugin Development (index) | <https://maven.apache.org/plugin-developers/index.html> | REMOVE | Superseded by Plugin-dev persona homepage. |
| Contribute to Maven (index) | <https://maven.apache.org/developers/index.html> | REMOVE | Superseded by Maven-dev persona homepage. |
| License | <https://www.apache.org/licenses/> | REMOVE from docs IA | Standard ASF footer link, not documentation. |

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
 