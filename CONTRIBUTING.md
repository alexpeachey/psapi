# PsAPI Developer Documentation

#### Setup the development environment
* install Node.JS
* `npm install`


#### Run tests
* run all automated tests: `npm test`
* run only linters: `npm run lint`
* run only unit tests: `npm run unit-tests`
* run only a single unit test: `mycha [path to spec file]`
* run only feature specs: `npm run feature-tests`
* run only a single feature spec: `cucumber-js <path to feature file>`


#### Update dependencies
* check whether updates are available: `npm run update-check`
* automatically update all dependencies to the latest version: `npm run update`


#### Release a new version

* [update the dependencies](#update-dependencies) to the latest version

```
npm version <patch|minor|major>
npm publish
```
