view: ndt_orders {
    derived_table: {
      explore_source: orders {
        column: hello {}
        column: count {}
        column: created_date {}
        filters: {
          field: orders.the_day
          value: "7 days"
        }
        bind_filters: {
          from_field: ndt_orders_test.the_day
          to_field: created_date
        }
      }

    }

    filter: the_day {
      type:  date
    }
    dimension: hello {}
    dimension: count {
      description: "hello"
      type: number
    }
  }
