connection: "thelook"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

datagroup: project_2_default_datagroup {
 sql_trigger: SELECT FLOOR(UNIX_TIMESTAMP() / (0.0833333333*60*60));;
  max_cache_age: "5 minutes"
}
persist_with: project_2_default_datagroup

explore: testingdt {}
