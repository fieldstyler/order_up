require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it { should belong_to :chef}
    it { should have_many :dish_ingredients}
    it { should have_many(:ingredients).through(:dish_ingredients) }
  end

  it 'should count calories' do
    ty = Chef.create(name: "Tyler Fields")
    pizza = ty.dishes.create(name: "Pizza", description: "Yum!")
    bng = ty.dishes.create(name: "Biscuits and Gravy", description: "Yum!")
    cbb = ty.dishes.create(name: "Chicken Burrito Bowl", description: "Yum!")
    pep = pizza.ingredients.create(name: "Pepperoni", calories: 200)
    dough = pizza.ingredients.create(name: "Pizza Dough", calories: 300)
    flour = bng.ingredients.create(name: "Flour", calories: 100)
    saus = bng.ingredients.create(name: "Sausage", calories: 500)
    chik = cbb.ingredients.create(name: "Chicken", calories: 150)
    @dishes = Dish.all

    expect(pizza.calorie_count).to eq(500)
  end
end
