# NASAClientApp

[![CI](https://github.com/ski-u/nasa-client-app/actions/workflows/tests.yml/badge.svg)](https://github.com/ski-u/nasa-client-app/actions/workflows/tests.yml)

> [!note]
> This is an experimental project to learn iOS app development :apple:

## API: [NASA APIs](https://api.nasa.gov)

### [Astronomy Picture of the Day](https://apod.nasa.gov/apod/astropix.html)

> [!important]
> NASA isn't updating this API now (as of 2025/10/14)
> > Due to the lapse in federal government funding, NASA is not updating this website. We sincerely regret this inconvenience.

- https://github.com/nasa/apod-api

## Features

### See Astronomy Pictures

| Today's picture | History |
| -- | -- |
| ![](./Screenshot/astronomy-picture-today.gif) | ![](./Screenshot/astronomy-picture-history.gif) |

### Accesibility
- Light / Dark mode
- Dynamic Type
- Localization (EN, JA)
- Translate contents using [Translation framework](https://developer.apple.com/documentation/translation/)

## Tech stack
- [cybozu/LicenseList](https://github.com/cybozu/LicenseList)
- [kishikawakatsumi/KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)
- [konomae/swift-local-date](https://github.com/konomae/swift-local-date)
- [pointfreeco/swift-composable-architecture](https://github.com/pointfreeco/swift-composable-architecture)
- [swiftlang/swift-format](https://github.com/swiftlang/swift-format)
