require_relative '../../entities/product.rb'
require 'thread'

class ProductsEndpoint
  @@products = []
  @@mutex = Mutex.new

  def create(req, res)
    Thread.new do
      puts "Creating product..."
      sleep 5
      random_id = (0...6).map { ('0'..'9').to_a.sample }.join
      random_product_name = (0...8).map { ('a'..'z').to_a.sample }.join
      new_product = Product.new(random_id, random_product_name)

      @@mutex.synchronize do
        @@products << new_product
      end
      puts "Product created: #{random_product_name} with ID: #{random_id}"
    end
    res.write({ message: 'Product creation in progress' }.to_json)
  end

  def list(req, res)
    @@mutex.synchronize do
      res.status = 200
      res.write(@@products.map(&:to_h).to_json)
    end
  end
end
