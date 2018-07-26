view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: created_formatted {
    type:  date
    sql: DATE_FORMAT(${created_raw}, "%M %d %Y")  ;;
  }

  dimension: test_15 {
    type: date_minute15
    sql: ${created_raw} ;;
  }


  dimension: email {
    label: "desc > 15"
    type: string
    sql: case when length(${TABLE}.email) >=40 THEN ${TABLE}.email
    else null
    end;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    map_layer_name: us_states
}

measure: test {
  type: average
  sql:${age} ;;
  html:
  {% if value = 0 %}
  <a style="background-color=white">{{ rendered_value }}</a>
  {% elsif value > 0 %}
  <a style="background-color=green">{{ rendered_value }}</a>
  {% else %}
  <a style="background-color=red">{{ rendered_value }}</a>
  {% endif %} ;;
}

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }


  dimension: link_date {
    type: date
    sql: now(${created_raw}) ;;
  }
#   dimension: dummy_link {
#     html: {{ linked_value }}
#     <a href="/looks/5?={{ value | url_encode }}&Created%20Date= {{ value }}" target="_new">
#     <img src="/images/qr-graph-line@2x.png" height=20 width=20> </a> ;;

measure: age_vs_avg_age {
  case: {
    when: {
      sql:  ${age} > ${avg_age} ;;
      label: "Age Above Average"
      }
    when: {
      sql: ${age} < ${avg_age} ;;
      label: "Age Below Average"
      }
    when: {
      sql: ${age} = ${avg_age} ;;
      label: "Age Equals Average"
    }
    else: "null"
    }
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_age {
    type:  count_distinct
    sql: ${age} ;;
  }

  measure: avg_age {
    type:  average
    sql:  ${age} ;;

  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}
