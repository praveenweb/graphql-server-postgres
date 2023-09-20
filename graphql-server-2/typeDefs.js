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
    cart_items_filter(limit: Int, orderBy: String): [CartItem]
    cart_items_batched: [CartItem]
  }

  type CartItem {
    id: UUID
    product_id: UUID
    cart_id: UUID
    quantity: Int
  }

  type Query {
    cart_items(limit: Int, orderBy: String): [CartItem]
  }

`;

export { typeDefs, scalarTypeDefs, scalarResolvers };