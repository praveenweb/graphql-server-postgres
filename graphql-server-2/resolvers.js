import { getFields } from "./utils.js";

const resolvers = {
  Query: {
    carts: async (_, args, { dataSources }, info) => {
      return dataSources.db.getCarts();
    },
    cart_items: async (_, args, { dataSources }, info) => {
      return dataSources.db.getCartItems();
    },
  },
  Cart: {
    cart_items_batched: async (parent, args, { dataSources }, info) => {
      return dataSources.db.getCartItemsBatched.load(parent.id);
    },
    cart_items_filter: async (parent, args, { dataSources }, info) => {
      return dataSources.db.getCartItemsNotBatched(parent, args);
    },
  },
};

export { resolvers };