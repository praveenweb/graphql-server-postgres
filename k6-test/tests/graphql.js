import http from "k6/http";
import { check, fail, sleep } from "k6";

export default function() {
  let query = `query {
      carts {
        id
        is_complete
        cart_items_filter(limit: 4, orderBy: "desc") {
          id
          cart_id
          quantity
        }
      }
    }
    `;

  let headers = {
    "Content-Type": "application/json"
  };

  let res = http.post('http://host.docker.internal:4000/',
    JSON.stringify({ query: query }),
    {headers: headers}
  );

  if (
    check(res, {
      'graphql errors': (res) => res.json().data.errors !== undefined,
    })
  ) {
    fail('graphql response error');
  }

}