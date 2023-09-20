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

  getCartItems() {
    return this.db.query
      .select("*")
      .from("cart_items")
  }

  getCartItemsNotBatched(parent, args) {
    return this.db.query
      .select("*")
      .from("cart_items")
      .where("cart_id", parent.id)
      .limit(args.limit ? args.limit : null)
      .orderBy("quantity", args.orderBy ? args.orderBy : "desc")
  }

}