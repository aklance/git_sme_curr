view: orders {
  sql_table_name: demo_db.orders ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    html: {{ status._value }} ;;

  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

filter: the_day {
  type:  date
  sql: (${created_raw} >= ${the_day_start} AND ${created_raw} < ${the_day_end}) ;;
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



  dimension: the_day_start {
    type: date_raw
    sql: {% date_start the_day %};;
    hidden: yes
  }



  dimension: the_day_end {
    type: date_raw
    sql: {% date_end the_day %};;
    hidden: yes
  }
  dimension: test2 {

  }

  dimension: stuff {
    view_label: "battalion"
  }

dimension: hello{}



  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.first_name, users.last_name, users.id, order_items.count, created_date]
    filters: {
      field:  created_date
      value: "-NULL"
    }

  }
  parameter: filter_date {
    type: date

    allowed_value: {
      label: "Before this week"
      value: "before 1 weeks ago"
    }
    allowed_value: {
      label: "Up until today"
      value: "before 0 days ago"
      }

    }

measure: sum_two_dimesnions {
  type: sum
  sql: ${id} + ${user_id} ;;
  }

filter: date_filter {
  type: date
  suggest_dimension: created_date
}
# Next, we will create a hidden dimension with templated filters designed to capture whatever input the user selects in this filter only field:

dimension: status_satisfies_filter {
type: yesno
hidden: yes
sql: {% condition date_filter %} ${created_date} {% endcondition %} ;;
}
#This dimension will return yes whenever a value is selected in filter field. Lastly, we will create a measure that filters on this yesno dimension:

measure: sum_dynamic_date {
  type: sum
  filters: {
  field: status_satisfies_filter
  value: "yes"
}
}}
