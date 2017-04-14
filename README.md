# jargon

## Overview

This program fetch a published Google Spreadsheet formatted like [this](https://docs.google.com/spreadsheets/d/15WlWL5Dz40j0ckCPQI0an52IybJn3uSBQehYEo9IQWw/pubhtml).
Currently it only support iOS.

## Requirements

The Google Spreadsheet must be published. You can do that from `File > Publish on the web`.
You can find the spreadsheet id from the url.

## Installation

```
brew install https://raw.githubusercontent.com/dmiotti/jargon/master/jargon.rb
```

## Usage

You can use the binary from this repository, you must execute the binary from your project directory.

```
./jargon <project_name> <spreadsheet_id>
```

For example: 
```
jargon ios Koala 1_ybVFNwVsYcsnHlXeL1J0Ls47jsMkx3aAzyP4usVOhE --baseLang fr
```

## Compile from sources

```
swift build -c release
```

You'll find the binary under `.build/debug` directory.

## Develop

```
swift package generate-xcodeproj
open -a Xcode .
```
