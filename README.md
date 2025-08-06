# Scorch

This is a fork of the main implementation of [Scorch](https://github.com/clementbera/Scorch). Its main purpose is to make Scorch work in Squeak and to use it with [OOPSIE](https://github.com/hpi-swa-teaching/osvm-oopsie).
For more information, see their respective READMEs.

## Installation

```Smalltalk
Metacello new
        githubUser: 'MariusDoe' project: 'Scorch' commitish: 'squeak' path: 'repository';
        baseline: 'Scorch';
        onWarningLog;
        load
```
