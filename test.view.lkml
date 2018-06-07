view: test {
  derived_table: {
  sql: SELECT
  products.id  AS `products.id`,
  products.cost  AS `products.cost`,
  products.department  AS `products.department`
FROM demo_db.products  AS products

LIMIT 500 ;;
}

dimension: test {
  type:  string
}
  dimension: test_3 {
    type:  string
  }

dimension: test_2 {
  type: string
}

}

view: test_2 {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    sql: SELECT
        user_id as user_id
        , COUNT(*) as lifetime_orders
        , MAX(orders.created_at) as most_recent_purchase_at
      FROM orders
      GROUP BY user_id
      ;;
  }
}
