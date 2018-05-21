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
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
    html:   <a></a> ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
}
