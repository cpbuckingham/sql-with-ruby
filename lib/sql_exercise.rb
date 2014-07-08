require "database_connection"

class SqlExercise

  attr_reader :database_connection

  def initialize
    @database_connection = DatabaseConnection.new
  end

  def all_customers
    database_connection.sql("select * from customers")
  end

  def limit_customers(limit)
    database_connection.sql("select * from customers limit #{limit};")
  end

  def order_customers(input)
    database_connection.sql("select * from customers order by name #{input};")
  end

  def id_and_name_for_customers
    database_connection.sql("select id, name from customers;")
  end

  def all_items
    database_connection.sql("select * from items;")
  end

  def find_item_by_name(search_term)
    database_connection.sql("select * from items where name = '#{search_term}';").first
  end

  def count_customers
    variable = database_connection.sql("select * from customers;")
    variable.count
  end

  def sum_order_amounts
    variable = database_connection.sql("select sum(amount) from orders;").first
    variable["sum"].to_f
  end

  def minimum_order_amount
    database_connection.sql("select customer_id, min (amount) from orders group by customer_id order by customer_id;")
  end

  def customer_order_totals
    database_connection.sql("select customers.name,customers.id customer_id, sum(amount)from orders join customers on orders.customer_id = customers.id group by customers.id;")
  end

  def items_ordered_by_user(user)
  puts database_connection.sql("select customers.customer_id, name from items join customers on items.id = customers.id where customers.customer.id = #{user};")
  end
end
