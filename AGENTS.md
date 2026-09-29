## Working on a formula

Write formulae from scratch and generate resources; do not copy from another tap
without checking its licence — many have none, which means no permission to copy.

Homebrew dev commands refuse a formula outside `Library/Taps`
("Homebrew requires formulae to be in a tap"), so brew always works against a
clone there. Two taps are possible and mixing them up is the main hazard:

    brew tap f3adlz/tap              # published tap, clones from GitHub
    brew tap f3adlz/tap "$(pwd)"     # development tap, clones from this repo

Use the second for unpushed work: it makes the clone's `origin` this repo, so
`brew update` will not reach GitHub until the tap is replaced with the first form.

    TAP="$(brew --repository)/Library/Taps/f3adlz/homebrew-tap"

Edit here, commit, then push the commit into the clone:

    git -C "$TAP" fetch -q origin main
    git -C "$TAP" reset --hard -q FETCH_HEAD

`brew update-python-resources` writes into the clone, so fetch that back:

    git fetch "$TAP" main && git merge --ff-only FETCH_HEAD

Never symlink the repo into `Library/Taps`, and never treat the clone as the
source of truth.

## Validation

    brew style f3adlz/tap/<formula>
    brew audit --strict --online f3adlz/tap/<formula>
    brew audit --new --formula f3adlz/tap/<formula>
    brew install --build-from-source f3adlz/tap/<formula>
    brew test f3adlz/tap/<formula>
    brew linkage --test --strict f3adlz/tap/<formula>

`--online` and `--new` are not part of a plain audit. `linkage --strict` requires
`--test`. When adding a test assertion, break it once to confirm it can fail.
The Formula Cookbook counts `--version` and `--help` as bad tests, so exercise
real functionality instead.

## Removing the tap

`brew untap f3adlz/tap` refuses while a formula from it is installed — it prints
"Would untap … after uninstalling" and does nothing. Uninstall first:

    brew uninstall shell-gpt && brew untap f3adlz/tap

## CI

`tests.yml` runs brew test-bot on push and pull requests and builds bottles;
`brew pr-pull` writes the resulting `bottle do` block. `autobump.yml` opens a
version-bump PR daily when upstream releases.

## Commits

Conventional Commits, scope is the formula name: `fix(shell-gpt): ...`.
Tap-wide changes take no scope. One logical change per commit.

## Reference

- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook) — formula anatomy,
  metadata conventions, what makes a good test block, naming and aliases, caveats.
- [Language-Specific Formulae](https://docs.brew.sh/Language-Specific-Formulae) —
  the Python virtualenv pattern, resource generation, `pypi_packages` and which
  packages to exclude in favour of a formula.

Prefer these over restating Homebrew doctrine here; this file covers only what is
specific to this tap.
