# react-native-music-kit-auth

Simple module to retrieve the users' Music Kit API tokens

## Installation

```sh
npm install react-native-music-kit-auth
```

## Usage


```js
import { type AuthStatus, requestAuthorization, getUserTokens } from 'react-native-music-kit-auth';

// ...

const authorizationStatus = await requestAuthorization();
console.log(authorizationStatus);

if (authorizationStatus === AuthStatus.Authorized) {
  const userTokens = await getUserTokens();

  console.log(userTokens.developerToken);
  console.log(userTokens.musicUserToken);
}

```


## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
