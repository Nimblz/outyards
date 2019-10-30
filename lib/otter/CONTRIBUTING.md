# Contributing to Otter

* [Bug Reports](#bug-reports)
* [Feature Requests](#feature-requests)
* [Documentation](#documentation)
* [Edit-Test Workflow](#edit-test-workflow)
* [Pull Requests](#pull-requests)

## Bug Reports
Any bugs (or things that look like bugs) can be reported on the [GitHub issue tracker](https://github.com/Roblox/otter/issues).

Make sure you check to see if someone has already reported your bug first! Don't fret about it; if we notice a duplicate we'll send you a link to the right issue!

## Feature Requests
If there are any features you think are missing from Otter, you can post a request in the [GitHub issue tracker](https://github.com/Roblox/otter/issues).

Just like bug reports, take a peak at the issue tracker for duplicates before opening a new feature request.

## Documentation
[The official Otter documentation](https://roblox.github.io/otter) is built using MkDocs.

To work on the documentation, you need:

* Python 3.x and Pip
* Mkdocs and Dependencies (`pip install -r docs/requirements.txt`)

To view the documentation locally with live-reloading, use:

```sh
mkdocs serve
```

Once your documentation changes are ready, commit the changes to `docs` and push them!

Right now, documentation has to be manually deployed by someone with commit access to the `gh-pages` branch. Just run:

```sh
mkdocs gh-deploy
```

## Edit-Test Workflow
To work on Otter, you need:

* Git
* Lua 5.1
* Lemur's dependencies:
	* [LuaFileSystem](https://keplerproject.github.io/luafilesystem/) (`luarocks install luafilesystem`)
* [Luacheck](https://github.com/mpeterv/luacheck) (`luarocks install luacheck`)
* [LuaCov](https://keplerproject.github.io/luacov) (`luarocks install luacov`)

Make sure you have all of the Git submodules for Otter downloaded. If you haven't cloned Otter yet, you can do that with:

```sh
git clone --recurse-submodules https://github.com/Roblox/otter.git
```

If you've already cloned the repository, don't fret, just use:

```sh
git submodule update --init
```

### Running Tests
Once you have all of the dependencies set up, you can run the tests for Otter with:

```sh
lua spec.lua
```

Or, to also generate a LuaCov coverage report:

```sh
lua -lluacov spec.lua
luacov
```

### Luacheck
We use Luacheck to help statically analyze code and prevent common mistakes.

You should have your editor configured to use Luacheck. There are plugins available for many popular editors, like Sublime Text and Visual Studio Code.

You can also run Luacheck from the command line:

```sh
luacheck lib
```

No warnings are allowed!

### Code Style
Roblox has an [official Lua style guide](https://roblox.github.io/lua-style-guide) which should be the general guidelines for all new code. When modifying code, follow the existing style!

In short:

* Tabs for indentation
* Double quotes
* One statement per line

Eventually we'll have a tool to check these things automatically.

## Pull Requests
Before starting a pull request, open an issue about the feature or bug. This helps us prevent duplicated and wasted effort. These issues are a great place to ask for help if you run into problems!

Before you submit a new pull request, check:

* Code Style: Match the [official Roblox Lua style guide](https://roblox.github.io/lua-style-guide) and the local code style
* Changelog: Add an entry to [CHANGELOG.md](CHANGELOG.md)
* Luacheck: Run [Luacheck](https://github.com/mpeterv/luacheck) on your code, no warnings allowed!
* Tests: All tests should pass, and we should have test coverage for any new code.

### Changelog
Adding an entry to [CHANGELOG.md](CHANGELOG.md) alongside your commit makes it easier for everyone to keep track of what's been changed.

Add a line under the "Current master" heading. When we make a new release, all of those bullet points will be attached to a new version and the "Current master" section will become empty again.

Add a link to your pull request in the entry. We don't need to link to the related GitHub issue, since pull requests will also link to them.