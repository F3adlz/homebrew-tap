## Working on a formula

Homebrew dev commands refuse a formula outside `Library/Taps`
("Homebrew requires formulae to be in a tap"), so this repo is the source of
truth and brew works against a temporary clone. From the repo root:

    brew tap f3adlz/tap "$(pwd)"
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

## Commits

Conventional Commits, scope is the formula name: `fix(shell-gpt): ...`.
Tap-wide changes take no scope. One logical change per commit.
