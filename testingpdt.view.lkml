view: testingdt {
  derived_table: {
    sql: SELECT *, (SELECT ROUND(AVG(age)) FROM demo_db.users) AS average_age,
DATE(users.created_at ) AS created_date,
        CASE
      WHEN users.age > (SELECT ROUND(AVG(age)) FROM demo_db.users)  THEN 'Age Above Average'
      WHEN users.age < (SELECT ROUND(AVG(age)) FROM demo_db.users)  THEN 'Age Below Average'
      WHEN users.age = (SELECT ROUND(AVG(age)) FROM demo_db.users)  THEN 'Age Equals Average'
      ELSE 'null'
      END AS 'users.age_vs_avg_age'
      FROM demo_db.users users
      where {% condition testingdt.user_id_temp_filter %} users.id {% endcondition %}
      group by id;;

      datagroup_trigger: project_2_default_datagroup
      indexes: ["id"]
  }

dimension: average_age {
  type:  number
  sql: ${TABLE}.average_age ;;
}

filter: user_id_temp_filter {
  type:  number
}

dimension: age {
  type:  number
  sql:  ${TABLE}.age ;;
}

dimension: user_id {
  type:  number
  primary_key:  yes
  sql:  ${TABLE}.id;;
}
  measure: count {
    type: count
  }

  dimension: users_created_date {
    type: date
    sql: ${TABLE}.`users.created_date` ;;
  }

  dimension: users_age_vs_avg_age {
    type: string
    sql: ${TABLE}.`users.age_vs_avg_age` ;;
  }



  set: detail {
    fields: [users_created_date, users_age_vs_avg_age]
  }
}
