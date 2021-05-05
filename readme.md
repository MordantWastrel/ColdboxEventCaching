# Coldbox Event Caching Test Suite

This repository attempts to test Coldbox event caching along with the REST Handler. It makes multiple requests to the same endpoint to determine when the template cache is used, and then it repeats the process with eventArguments instead of the rc scope.

## Usage

Run `box install` after cloning the repo, start the server, and navigate to `/tests/specs/integration/EventCacheTests.cfc?method=runRemote`.