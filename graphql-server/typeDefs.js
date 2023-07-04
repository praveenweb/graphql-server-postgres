import {
    typeDefs as scalarTypeDefs,
    resolvers as scalarResolvers,
  } from 'graphql-scalars'

const typeDefs = `#graphql

  scalar UUID
  scalar timestamptz

  type Product {
    id: UUID
    name: String
    description: String
    manufacturer: Manufacturer
  }

  type Manufacturer {
    id: UUID
    name: String
  }

  type Cart {
    id: UUID
    user_id: UUID
    is_complete: Boolean
    created_at: timestamptz
    cart_items: [CartItem]
    cart_items_not_batched: [CartItem]
  }

  type CartItem {
    id: UUID
    product_id: UUID
    cart_id: UUID
    quantity: Int
    product: Product
  }

  type Query {
    products: [Product]
    manufacturers: [Manufacturer]
    carts: [Cart]
    cart_items: [CartItem]
  }

`;

export { typeDefs, scalarTypeDefs, scalarResolvers };