# F3adlz Tap

A personal [Homebrew](https://brew.sh) tap.

## Formulae

| Formula | Description | Upstream |
| --- | --- | --- |
| `shell-gpt` | Command-line productivity tool powered by large language models (`sgpt`) | [TheR1D/shell_gpt](https://github.com/TheR1D/shell_gpt) |

## How do I install these formulae?

`brew install f3adlz/tap/<formula>`

Or `brew tap f3adlz/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "f3adlz/tap"
brew "<formula>"
```

With Ansible:

```yaml
- community.general.homebrew_tap:
    name: f3adlz/tap
- community.general.homebrew:
    name: f3adlz/tap/shell-gpt
```

## Notes on `shell-gpt`

The binary is `sgpt`, not `shell-gpt`. On first run it prompts for an API key and
writes its configuration to `~/.config/shell_gpt/`.

`typer` is pinned to 0.25.1 in the formula. `shell-gpt` imports `click` directly
and passes `click.types.Choice` into `typer`, but only constrains
`typer>=0.7.0,<1.0.0`. `typer` 0.26.0 vendored `click` into `typer._click` and
dropped the top-level `click` dependency, so resolving the newest `typer`
produces a virtualenv without `click` and `sgpt` fails at import. Revisit the pin
when upstream declares `click` explicitly or adapts to the vendored layout.

## Development

Formulae here are written from scratch against Homebrew's DSL; resource blocks are
generated with `brew update-python-resources`. Bottles are built by the
`brew test-bot` workflow in `.github/workflows/tests.yml`.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
