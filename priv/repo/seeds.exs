# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CadeauPlatform.Repo.insert!(%CadeauPlatform.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CadeauPlatform.Repo
alias CadeauPlatform.Inventory.Product
alias CadeauPlatform.Inventory.Category
alias CadeauPlatform.Inventory.Tax
alias CadeauPlatform.Inventory.ProductTax

Repo.insert! %Category{
  id: 1,
  name: "Book",
  type: :book
}

Repo.insert! %Category{
  id: 2,
  name: "Health",
  type: :health
}

Repo.insert! %Category{
  id: 3,
  name: "Edible",
  type: :edible
}

Repo.insert! %Category{
  id: 4,
  name: "Wear",
  type: :wear
}

Repo.insert! %Product{
  id: 1,
  name: "Sapiens: A Brief History of Humankind",
  price: Money.new(:MYR, 100),
  description: "A Summer Reading Pick for President Barack Obama, Bill Gates, and Mark Zuckerberg",
  imported: true,
  image_link: "https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/lrg/9780/0623/9780062316097.jpg",
  category_id: 1
}

Repo.insert! %Product{
  id: 2,
  name: "Wonder",
  price: Money.new(:MYR, 12.49),
  description: "Auggie wants to be an ordinary ten-year-old. He does ordinary things - eating ice cream, playing on his Xbox. He feels ordinary - inside. But ordinary kids don't make other ordinary kids run away screaming in playgrounds.",
  imported: false,
  image_link: "https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/lrg/9780/5525/9780552565974.jpg",
  category_id: 1
}

Repo.insert! %Product{
  id: 3,
  name: "Blackmores Bio C 1000 30 Tablets",
  price: Money.new(:MYR, 300),
  description: "High potency vitamin C supplement, buffered with mineral ascorbates to make it gentle on the stomach.",
  imported: true,
  image_link: "https://citycareonline.com.my/1762-large_default/blackmores-bio-c-1000-30-tablets.jpg",
  category_id: 2
}

Repo.insert! %Product{
  id: 4,
  name: "Bio-life Anti-FR + Selenium 100 + 30 Tablets",
  price: Money.new(:MYR, 400),
  description: "BiO-LiFE Anti FR + Selenium contains antioxidant, anti-Free Radical (FR) source of nutrient that combines beta-carotene, vitamin C, E, zinc, selenium and garlic.",
  imported: false,
  image_link: "https://citycareonline.com.my/3078-large_default/bio-life-anti-fr-selenium-100-30-tablets.jpg",
  category_id: 2
}


Repo.insert! %Product{
  id: 5,
  name: "Chocolate Truffle Delight Gift Box, 16 pc.",
  price: Money.new(:MYR, 150),
  description: "Delight friends and family with our new Truffles Delight collection featuring unique and intriguing flavors.",
  imported: true,
  image_link: "http://images.godiva.com/is/image/godiva/chocolate-truffles-delight-gift-box~~12380-2?$plp$",
  category_id: 3
}

Repo.insert! %Product{
  id: 6,
  name: "Mint Dark Chocolate Bar, Pack of 24, 1.5 oz each",
  price: Money.new(:MYR, 0.85),
  description: "For baking and self-treating, our luscious Mint Dark Chocolate Small Bars hit the spot.",
  imported: false,
  image_link: "http://images.godiva.com/is/image/godiva/dark-chocolate-bar~~27990-1",
  category_id: 3
}

Repo.insert! %Product{
  id: 7,
  name: "JOIN LIFE",
  price: Money.new(:MYR, 110),
  description: "Basic Striped Polo Shirt",
  imported: true,
  image_link: "https://imagena1.lacoste.com/dw/image/v2/AAUP_PRD/on/demandware.static/-/Sites-master/default/dw1cee1729/PH2029_HHW_24.jpg?sw=460&sh=460&sm=fit",
  category_id: 4
}

Repo.insert! %Product{
  id: 8,
  name: "Oversized Sweater With Hood",
  price: Money.new(:MYR, 14.99),
  description: "Basic Hoody",
  imported: false,
  image_link: "https://gloimg.zafcdn.com/zaful/pdm-product-pic/Clothing/2017/08/16/thumb-img/1505673026236652447.jpg",
  category_id: 4
}

Repo.insert! %Tax{
  id: 1,
  name: "Sales Tax",
  tax_rate: 0.1
}

Repo.insert! %Tax{
  id: 2,
  name: "Import Tax",
  tax_rate: 0.05
}

Repo.insert %ProductTax{
  product_id: 7,
  tax_id: 1
}

Repo.insert %ProductTax{
  product_id: 8,
  tax_id: 1
}

Repo.insert %ProductTax{
  product_id: 1,
  tax_id: 2
}
Repo.insert %ProductTax{
  product_id: 3,
  tax_id: 2
}
Repo.insert %ProductTax{
  product_id: 5,
  tax_id: 2
}
Repo.insert %ProductTax{
  product_id: 7,
  tax_id: 2
}
