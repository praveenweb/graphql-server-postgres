import 'dotenv/config';
import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import { PostgresDataSource } from "./postgresDataSource.js";
import { typeDefs, scalarTypeDefs, scalarResolvers } from './typeDefs.js';
import { resolvers } from './resolvers.js';

const knexConfig = {
    client: "pg",
    connection: process.env.PG_CONNECTION_STRING,
    pool: { min: 0, max: 60 },
    debug: process.env.NODE_ENV === 'production' ? false : true,
  };

const server = new ApolloServer({
    typeDefs: [
        ...scalarTypeDefs,
        typeDefs
    ],
    resolvers: {
        ...scalarResolvers,
        ...resolvers
    }
})
  
startStandaloneServer(server, {
    context: async () => {
      const { cache } = server;
      return {
        dataSources: {
          db: new PostgresDataSource({ knexConfig, cache }),
        },
      };
    },
}).then(({ url }) => console.log(`🚀 Server ready at ${url}`));