namespace :createdb do
  desc "Generate products database"
  task create_products: :environment do
    puts "Create brands"
    toshiba =    Brand.create name: "Toshiba"
    samsung =    Brand.create name: "Samsung"
    apple   =    Brand.create name: "Apple"
    asus    =    Brand.create name: "Asus"
    puts "Create company Zimean"
    zimean  =   Company.create name: "Zimean"

    puts "Create Categories"
    laptop  = Category.create name: "Laptop"
    ipad    = Category.create name: "Ipad"
    smartphone =Category.create name: "Smartphone"

    puts "Create products"
    (1..50).each do |num|
      product = Product.new(name: "Laptop SJKHG #{num} Product #{num}'s name",image_file: "https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/surface_L_Pivot_Burgundy_pos2_V2.jpg", description: "Description for product #{num}", available_quantity: 100, brand_id: toshiba.id, category_id: laptop.id, company_id: zimean.id, price: 1.0)
      if product.name.include?(" ")
        product.name = product.name.split(" ").join("-")
        product.save
      else
        product.save
      end
      product = Product.create(name: "Ipad IPDJKE  #{num} Product #{num}'s name", image_file: "https://photo2.tinhte.vn/data/attachment-files/2017/07/4081488_Tinhte-iPad_Mini-1.jpg", description: "Description for product ipad #{num}", available_quantity: 100, brand_id: apple.id, category_id: ipad.id, company_id: zimean.id, price: 1.0)
       if product.name.include?(" ")
        product.name = product.name.split(" ").join("-")
        product.save
      else
        product.save
      end 
      product = Product.create(name: "Smartphone SJLKAK #{num} Product #{num}'s name", image_file: "http://www.bell.ca/Styles/wireless/all_languages/all_regions/catalog_images/large/iPhone7Plus_MatBlk_en.png", description: "Description for product SMOKJAPO #{num}", available_quantity: 100, brand_id: samsung.id, category_id: smartphone.id, company_id: zimean.id, price: 1.0)
			 if product.name.include?(" ")
        product.name = product.name.split(" ").join("-")
        product.save
      else
        product.save
      end


      
    end

  end

end
