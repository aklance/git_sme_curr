connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: project_2_default_datagroup {
  sql_trigger:SELECT FLOOR(UNIX_TIMESTAMP() / (0.08333333*60*60));;
  max_cache_age: "5 minutes"
}

persist_with: project_2_default_datagroup

explore: events {
  access_filter: {
    field: users.id
    user_attribute: id
  }
  join: users {
    type: left_outer
    sql_on: ${events.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: events_2 {
  from: events
  access_filter: {
    field: users.id
    user_attribute: id
  }
  join: users {
    type: left_outer
    sql_on: ${events_2.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {


  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  always_filter: {
    filters: {
      field: products.test_dash_filter
      value: "test"

    }
    }
}

explore: ndt_orders_test {
  from:  ndt_orders

}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
#   hidden: yes

  join: users {
#     fields: []
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {}


explore: schema_migrations {}

explore: user_data {
  join: users {
    type: left_outer
    sql_on: ${user_data.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: users {
  join: testingdt {
    type: left_outer
    sql_on:  ${testingdt.user_id} = ${users.id} ;;
    relationship: one_to_one
  }
}

explore: testingdt {}

explore: test {}

explore: users_nn {}
