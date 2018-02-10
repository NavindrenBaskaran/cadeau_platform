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
  name: "Sapiens: A Brief History of Humankind",
  price_cents: 127002,
  description: "A Summer Reading Pick for President Barack Obama, Bill Gates, and Mark Zuckerberg",
  imported: true,
  image_link: "https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/lrg/9780/0623/9780062316097.jpg",
  category_id: 1
}

Repo.insert! %Product{
  name: "Wonder",
  price_cents: 3624,
  description: "Auggie wants to be an ordinary ten-year-old. He does ordinary things - eating ice cream, playing on his Xbox. He feels ordinary - inside. But ordinary kids don't make other ordinary kids run away screaming in playgrounds.",
  imported: false,
  image_link: "https://d1w7fb2mkkr3kw.cloudfront.net/assets/images/book/lrg/9780/5525/9780552565974.jpg",
  category_id: 1
}

Repo.insert! %Product{
  name: "Blackmores Bio C 1000 30 Tablets",
  price_cents: 2610,
  description: "High potency vitamin C supplement, buffered with mineral ascorbates to make it gentle on the stomach.",
  imported: true,
  image_link: "https://citycareonline.com.my/1762-large_default/blackmores-bio-c-1000-30-tablets.jpg",
  category_id: 2
}

Repo.insert! %Product{
  name: "Bio-life Anti-FR + Selenium 100 + 30 Tablets",
  price_cents: 9302,
  description: "BiO-LiFE Anti FR + Selenium contains antioxidant, anti-Free Radical (FR) source of nutrient that combines beta-carotene, vitamin C, E, zinc, selenium and garlic.",
  imported: false,
  image_link: "https://citycareonline.com.my/3078-large_default/bio-life-anti-fr-selenium-100-30-tablets.jpg",
  category_id: 2
}


Repo.insert! %Product{
  name: "Chocolate Truffle Delight Gift Box, 16 pc.",
  price_cents: 12000,
  description: "Delight friends and family with our new Truffles Delight collection featuring unique and intriguing flavors.",
  imported: true,
  image_link: "http://images.godiva.com/is/image/godiva/chocolate-truffles-delight-gift-box~~12380-2?$plp$",
  category_id: 3
}

Repo.insert! %Product{
  name: "Mint Dark Chocolate Bar, Pack of 24, 1.5 oz each",
  price_cents: 7199,
  description: "For baking and self-treating, our luscious Mint Dark Chocolate Small Bars hit the spot.",
  imported: false,
  image_link: "http://images.godiva.com/is/image/godiva/dark-chocolate-bar~~27990-1",
  category_id: 3
}

Repo.insert! %Product{
  name: "JOIN LIFE",
  price_cents: 10000,
  description: "Basic Striped Polo Shirt",
  imported: true,
  image_link: "https://static.zara.net/photos///2018/V/0/2/p/9240/403/401/2/w/1920/9240403401_2_1_1.jpg",
  category_id: 4
}

Repo.insert! %Product{
  name: "Oversized Sweater With Hood",
  price_cents: 15000,
  description: "Basic Hoody",
  imported: false,
  image_link: "https://static.zara.net/photos///2018/V/0/2/p/8689/407/600/2/w/1920/8689407600_2_5_1.jpg",
  category_id: 4
}
