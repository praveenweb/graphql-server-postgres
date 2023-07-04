import { getFields } from "./utils.js";

const resolvers = {
  Query: {
    products: async (_, args, { dataSources }, info) => {
      return dataSources.db.getProducts();
    },
    manufacturers: async (_, args, { dataSources }, info) => {
      return dataSources.db.getManufacturers();
    },
    carts: async (_, args, { dataSources }, info) => {
      return dataSources.db.getCarts();
    },
    cart_items: async (_, args, { dataSources }, info) => {
      return dataSources.db.getCartItems();
    },
  },
  Product: {
    manufacturer: async (parent, args, { dataSources }, info) => {
      return dataSources.db.getManufacturersByProducts(parent);
    },
  },
  Cart: {
    cart_items: async (parent, args, { dataSources }, info) => {
      return dataSources.db.getCartItemsBatched.load(parent.id);
    },
    cart_items_not_batched: async (parent, args, { dataSources }, info) => {
      return dataSources.db.getCartItemsNotBatched(parent);
    },
  },
  CartItem: {
    product: async (parent, args, { dataSources }, info) => {
      return dataSources.db.getProductByCartItem(parent);
    },
  },
};

export { resolvers };