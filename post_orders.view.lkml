view: post_orders {
  sql_table_name: public.orders ;;

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: status {
  type:  string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id  {
    type: number
    sql: ${TABLE}.user_id ;;

  }
}
