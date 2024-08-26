import { useState } from 'react';
import { StyleSheet, View, Text, Button } from 'react-native';
import {
  requestAuthorization,
  getUserToken,
  type MusicTokens,
} from 'react-native-music-kit-auth';

export default function App() {
  const [tokens, setTokens] = useState<MusicTokens | undefined>();
  const [error, setError] = useState<string | undefined>();

  return (
    <View style={styles.container}>
      {error && <Text>{error}</Text>}
      <Button
        onPress={() =>
          requestAuthorization()
            .then(() => getUserToken().then(setTokens))
            .catch((e) => setError(e.message))
        }
        title="Get Tokens"
      />
      <Text>
        Result: {tokens?.developerToken}, {tokens?.userToken}
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
