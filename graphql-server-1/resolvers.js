import { getFields } from "./utils.js";

const resolvers = {
  Query: {
    carts: async (_, args, { dataSources }, info) => {
      return dataSources.db.getCarts();
    },
  },
};

export { resolvers };