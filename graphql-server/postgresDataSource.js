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

  /*
  getCartItemProductsBatched = this.db.query
    .select("*")
    .from({p: "products"})
    .batch(async (query, keys) => {
      const result = await query.whereIn("p.id", keys);
      return keys.map((x) => {
        return result.filter((y) => {
          return y.id === x
        });
      })
    });
  */

  getProducts() {
    return this.db.query
      .select("*")
      .from("products");
  }

  getManufacturers(fields) {
    return this.db.query
      .select("*")
      .from("manufacturers");
  }

  getManufacturersByProducts(parent) {
    return this.db.query
      .select("*")
      .from("manufacturers")
      .where('id', parent.manufacturer)
      .first().then((row) => row)
  }

  getProductByCartItem(parent) {
    return this.db.query
      .select("*")
      .from("products")
      .where('id', parent.product_id)
      .first().then((row) => row)
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

  getCartItemsNotBatched(parent) {
    return this.db.query
      .select("*")
      .from("cart_items")
      .where('cart_id', parent.id);
  }

  // caching example
  getProductsCached() {
    return this.db.query
      .select("*")
      .from("products")
      .cache(10);
  }
}