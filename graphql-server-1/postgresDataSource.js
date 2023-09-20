import { BatchedSQLDataSource } from "@nic-jennings/sql-datasource"

export class PostgresDataSource extends BatchedSQLDataSource {

  constructor(config) {
    super(config);

    // batching
    this.getCartItemsBatched = this.db.query
      .select("*")
      .from({c: "cart_items"})
      .batch(async (query, keys) => {
        const result = await query.whereIn("c.cart_id", keys);
        return keys.map((x) => {
          return result.filter((y) => y.cart_id === x);
        })
      });
  }

  getCarts() {
    return this.db.query
      .select("*")
      .from("carts");
  }

  getCartItems() {
    return this.db.query
      .select("*")
      .from("cart_items");
  }

}