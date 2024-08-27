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
            const token = await MKA.getUserToken(
              'eyJhbGciOiJFUzI1NiIsImtpZCI6IjVVNjZQNzZZN04ifQ.eyJpc3MiOiIyRk5ZNjgyV0JaIiwiZXhwIjoxNzI0NzU0NTk4LjcxNSwiaWF0IjoxNzI0NzUwOTk4LjcxNX0.m0-BXXZdU8MWmrAPEVqsC0kdVg_akTMuTkxCbYxhSc-Tin2raSCaBLeOnh3urd4xtZZqs19GIVi9nwruXv0Ldw'
            );

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
