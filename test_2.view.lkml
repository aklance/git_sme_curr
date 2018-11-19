view: test_2 {
  derived_table: {
    sql: SELECT
  CASE WHEN CAST(FLOOR(COUNT(order_items.sale_price ) * 0.5 - 0.00000001) AS SIGNED) + 1 = CAST(FLOOR(COUNT(order_items.sale_price ) * 0.5) AS SIGNED) + 1
OR CAST(FLOOR(COUNT(order_items.sale_price ) * 0.5) AS SIGNED) + 1 = COUNT(order_items.sale_price )
THEN CAST(REPLACE(SUBSTRING(CAST(GROUP_CONCAT( LPAD(SUBSTRING(CAST(order_items.sale_price  AS CHAR), 1, 20), 20, '*')
ORDER BY order_items.sale_price   SEPARATOR '' ) AS CHAR), (CAST(FLOOR(COUNT(order_items.sale_price ) * 0.5 - 0.00000001) AS SIGNED) + 1 - 1) * 20 + 1, 20), '*', ' ') AS DECIMAL(20, 5))
ELSE (CAST(REPLACE(SUBSTRING(CAST(GROUP_CONCAT( LPAD(SUBSTRING(CAST(order_items.sale_price  AS CHAR), 1, 20), 20, '*') ORDER BY order_items.sale_price   SEPARATOR '' ) AS CHAR), (CAST(FLOOR(COUNT(order_items.sale_price ) * 0.5 - 0.00000001) AS SIGNED) + 1 - 1) * 20 + 1, 20), '*', ' ') AS DECIMAL(20, 5)) + CAST(REPLACE(SUBSTRING(CAST(GROUP_CONCAT( LPAD(SUBSTRING(CAST(order_items.sale_price  AS CHAR), 1, 20), 20, '*')
ORDER BY order_items.sale_price   SEPARATOR '' ) AS CHAR), (CAST(FLOOR(COUNT(order_items.sale_price ) * 0.5) AS SIGNED) + 1 - 1) * 20 + 1, 20), '*', ' ') AS DECIMAL(20, 5))) / 2 END AS `order_items.median_price`
  FROM demo_db.order_items  AS order_items;;
 }

dimension: bloop  {}
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
}
