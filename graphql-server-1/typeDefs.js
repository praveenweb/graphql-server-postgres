import gql from 'graphql-tag';
import {
    typeDefs as scalarTypeDefs,
    resolvers as scalarResolvers,
  } from 'graphql-scalars'

const typeDefs = gql`
  extend schema @link(url: "https://specs.apollo.dev/federation/v2.0", import: ["@key", "@shareable"])

  scalar UUID
  scalar timestamptz

  type Cart @key(fields: "id") {
    id: UUID
    user_id: UUID
    is_complete: Boolean
    created_at: timestamptz
  }

  type Query {
    carts: [Cart]
  }

`;

export { typeDefs, scalarTypeDefs, scalarResolvers };