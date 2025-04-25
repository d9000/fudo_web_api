require_relative '/entities/product.rb'

class ProductsEndpoint
  def initialize
    @products = []
  end

  def create(req, res)
    Thread.new do
      sleep 5
      random_id = SecureRandom.hex(6)
      random_product_name = (0...8).map { ('a'..'z').to_a.sample }.join
      @products << Product.new(random_id, random_product_name)
    end
    res.write({ message: 'Product creation in progress' }.to_json)
  end

  def list(req, res)
    res.status = 200
    res.write(@products.map(&:to_h).to_json)
  end
end
