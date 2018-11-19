view: test {
  derived_table: {
  sql: SELECT
  products.id  AS id ,
  products.department  AS department
FROM demo_db.products  AS products

LIMIT 500 ;;
}

dimension: id {
  type:  string
  sql:  ${TABLE}.id ;;
}

  dimension: test_liquid_zap {
    type: string
    sql: 'Test Liquid Zap' ;;
    action: {
      label: "test_zap"
      url: "https://hooks.zapier.com/hooks/catch/2944677/epwnrc/"
      param: {
        name: "liquid"
        value: "{{ test.id._value }}"
      }
      }
      }

  dimension: test_3 {
    type:  string
  }

dimension: test_2 {
  type: string
}

}

# view: test_2 {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
# }
