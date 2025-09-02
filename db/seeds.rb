User.destroy_all
Store.destroy_all
Product.destroy_all
StoreProduct.destroy_all

jennifer = User.create(name: "Jennifer Beaver", email: "jen.lee.beaver@gmail.com", password: "hello101")

# Clear existing data
Store.destroy_all
Product.destroy_all
StoreProduct.destroy_all

puts "🌍 Creating Walmart stores..."

stores = [
  { name: "Walmart Salt Lake City", location: "Salt Lake City, UT" },
  { name: "Walmart Austin", location: "Austin, TX" },
  { name: "Walmart Miami", location: "Miami, FL" }
]

stores.each do |store_data|
  layout = {
    sections: [
      { name: "Produce", aisle: "1" },
      { name: "Dairy", aisle: "2" },
      { name: "Frozen", aisle: "3" },
      { name: "Bakery", aisle: "4" },
      { name: "Cleaning", aisle: "5" },
      { name: "Snacks", aisle: "6" },
      { name: "Drinks", aisle: "7" }
    ]
  }

  Store.create!(store_data.merge(layout: layout))
end

puts "✅ Created #{Store.count} stores."

puts "📦 Creating products..."

products = [
  { name: "Bananas", category: "Produce", brand: "Dole", image_url: "https://via.placeholder.com/100" },
  { name: "Whole Milk", category: "Dairy", brand: "Great Value", image_url: "https://via.placeholder.com/100" },
  { name: "Frozen Pizza", category: "Frozen", brand: "DiGiorno", image_url: "https://via.placeholder.com/100" },
  { name: "Bread", category: "Bakery", brand: "Wonder", image_url: "https://via.placeholder.com/100" },
  { name: "All-Purpose Cleaner", category: "Cleaning", brand: "Lysol", image_url: "https://via.placeholder.com/100" },
  { name: "Potato Chips", category: "Snacks", brand: "Lays", image_url: "https://via.placeholder.com/100" },
  { name: "Orange Juice", category: "Drinks", brand: "Tropicana", image_url: "https://via.placeholder.com/100" }
]

products.each do |product_data|
  Product.create!(product_data)
end

puts "✅ Created #{Product.count} products."

puts "🔗 Linking products to stores..."

Store.all.each do |store|
  Product.all.each do |product|
    aisle = store.layout["sections"].find { |s| s[:name] == product.category }&.[](:aisle) || rand(1..10).to_s

    StoreProduct.create!(
      store: store,
      product: product,
      aisle: aisle,
      location: { shelf: rand(1..5), bin: rand(1..10) },
      price: rand(1.00..10.00).round(2)
    )
  end
end

puts "✅ Seeded #{StoreProduct.count} store-product entries."
puts "🎉 Done seeding!"
