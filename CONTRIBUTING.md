# PsAPI Developer Documentation

#### Setup the development environment
* install Node.JS
* `npm install`


#### Run tests
* run all automated tests: `npm test`
* run only linters: `npm run lint`
* run only unit tests: `npm run unit-tests`
* run a single unit test: `mycha [path to spec file]`
* run only feature specs: `npm run feature-tests`
* run only a single feature spec: `cucumber-js <path to feature file>`


#### Release a new version

```
npm version <patch|minor|major>
npm publish
```
