import { useState } from 'react';
import { StyleSheet, View, Text, Button } from 'react-native';
import * as MKA from 'react-native-music-kit-auth';

export default function App() {
  const [tokens] = useState<string | undefined>();
  const [error] = useState<string | undefined>();

  return (
    <View style={styles.container}>
      {error && <Text>{error}</Text>}
      <Button
        onPress={async () => {
          try {
            const token = await MKA.getUserToken();

            console.log(token);
          } catch (e) {
            console.error(e);
          }
        }}
        title="Get Tokens"
      />
      <Text>Result: "{tokens}"</Text>
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
  error: {},
});
