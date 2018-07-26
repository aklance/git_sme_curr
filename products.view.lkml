view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
#     link: {
#       label: "Look Link"
#       url: "/looks/5=&f[products.brand]={{ _user_attributes['test1'] }}&f[users.created_date]={{ 7 days }}"
#       icon_url: "https://looker.com/favicon.ico"
#     }
    }

dimension: look_link {
    sql: ${brand} ;;
    html: <a href="/looks/5=&f[products.brand]={{ _user_attributes['test1'] }}&f[users.created_date]={{ 7 days }}">
          <img src="https://looker.com/favicon.ico" </a> ;;
}

#   https://localhost:99 99/explore/model/order_items?fields=users.created_date,products.brand&f[products.brand]=%7B%7B+_user_attributes%5B%27test1%27%5D+%7D%7D&f[users.created_date]=7+days&sorts=users.created_date+desc&limit=500&vis=%7B%22type%22%3A%22table%22%2C%22show_view_names%22%3Atrue%2C%22show_row_numbers%22%3Atrue%2C%22truncate_column_names%22%3Afalse%2C%22hide_totals%22%3Afalse%2C%22hide_row_totals%22%3Afalse%2C%22table_theme%22%3A%22editable%22%2C%22limit_displayed_rows%22%3Afalse%2C%22enable_conditional_formatting%22%3Afalse%2C%22conditional_formatting_include_totals%22%3Afalse%2C%22conditional_formatting_include_nulls%22%3Afalse%7D&filter_config=%7B%22products.brand%22%3A%5B%7B%22type%22%3A%22user_attribute%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22test1%22%7D%2C%7B%7D%5D%2C%22id%22%3A4%2C%22error%22%3Afalse%7D%5D%2C%22users.created_date%22%3A%5B%7B%22type%22%3A%22advanced%22%2C%22values%22%3A%5B%7B%22constant%22%3A%227+days%22%2C%22unit%22%3A%22day%22%2C%22tmp%22%3A%227+days%22%7D%2C%7B%7D%5D%2C%22id%22%3A2%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded
dimension: cost {
  sql:  ${TABLE}.cost ;;
}
  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
    }

# #     {% if value == 'Active' %}
# #       <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
# #     {% elsif value == 'Jeans' %}
# #       <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
# #     {% else %}
# #       <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
# #     {% endif %}
# ;;


  dimension: department {
    type: string
    sql:  CASE when ${TABLE}.department = 'Women' THEN 'Dept-Women'
    when ${TABLE}.department = 'Men' THEN 'Dept-men'
    ELSE null
    END ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }
# string_to_array( {% parameter pick_facility_id %} ,',' ,',')::text[]

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
    html:   <a></a> ;;
  }

 filter: testing_delimited_input {
    suggestions: ["a", "b", "c"]
  }

  dimension: delimited_input_array {
    sql: {% parameter testing_delimited_input %}  ;;
  }

dimension: test1 {

}

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }


  measure: distinct_rt {
    type: count_distinct
    sql:  ${retail_price} ;;
  }
  measure: count_bucket_test {
    type: string
    sql:
    case when ${distinct_rt} between 0 and 500 THEN '1-5'
    when ${distinct_rt} > 500 THEN '5-10' ELSE null END;;
  }

  measure: cost_coalesce {

  }
}
