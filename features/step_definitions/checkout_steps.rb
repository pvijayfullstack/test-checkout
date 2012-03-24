When /^I go to the home page$/ do
  visit('/')
end

Given /^the following tasks:$/ do |table|
  @tasks = []
  @tasks = table.hashes
end

Then /^I can add my tasks$/ do
  @tasks.each_with_index do |n, i|
    click_link "New Task"
    fill_in "task_name", :with => @tasks[i][:name]
    click_button "Save"
  end
end

Then /^I can see my tasks$/ do
  @tasks.each_with_index do |n, i|
    assert page.has_content?(@tasks[i][:name])
  end
end

Then /^I can add my tasks with deadline dates$/ do
  @tasks.each_with_index do |n, i|
    click_link "New Task"
    fill_in "task_name", :with => @tasks[i][:name]
    page.select(@tasks[i][:year], :from => "task_deadline_1i")
    page.select(@tasks[i][:month], :from => "task_deadline_2i")
    page.select(@tasks[i][:day], :from => "task_deadline_3i")
    #fill_in "task_deadline_1i", :with => @tasks[i][:year]
    click_button "Save"

  end
end

Then /^I can see my tasks with deadlines$/ do
  @tasks.each_with_index do |n, i|
    assert page.has_content?(@tasks[i][:name])
    assert page.has_content?(@tasks[i][:year])
    assert page.has_content?(@tasks[i][:month])
    assert page.has_content?(@tasks[i][:day])
  end
end
Given /^the seeded task$/ do
  @test_task = FactoryGirl.create(:task, :name => "Dummy Task", :deadline => Time.now)
end

Then /^I can edit my task$/ do
  click_link "Edit"
  assert page.has_field?('Name', :with => @test_task.name)
  page.has_select?('task_deadline_1i', :selected => @test_task.deadline.strftime("%Y"))
  page.has_select?('task_deadline_2i', :selected => @test_task.deadline.strftime("%B"))
  page.has_select?('task_deadline_3i', :selected => @test_task.deadline.strftime("%e"))
  fill_in "task_name", :with => @task_updates[:name]
  page.select(@task_updates[:year], :from => "task_deadline_1i")
  page.select(@task_updates[:month], :from => "task_deadline_2i")
  page.select(@task_updates[:day], :from => "task_deadline_3i")
  click_button "Save"
end

Then /^I can see the updated task$/ do
  assert page.has_content?(@task_updates[:name])
  assert page.has_content?(@task_updates[:year])
  assert page.has_content?(@task_updates[:month])
  assert page.has_content?(@task_updates[:day])
end

When /^the following updates for the task$/ do |table|
  @task_updates = table.rows_hash
end

Then /^I can destroy my task$/ do
  page.evaluate_script('window.confirm = function() { return true; }')
  click_link "Destroy"
  assert page.has_no_content?(@test_task.name)
  assert page.has_no_content?(@test_task.deadline.strftime("%Y"))
  assert page.has_no_content?(@test_task.deadline.strftime("%B"))
  assert page.has_no_content?(@test_task.deadline.strftime("%e"))
end

When /^I mark my task as completed$/ do
  click_link "Edit"
  page.has_unchecked_field?('task_complete')
  page.check('task_complete')
  click_button "Save"
end

Then /^I can see it as completed$/ do
  assert page.has_content?('true')
end

Given /^the seeded tasks$/ do
  @overdue_task = FactoryGirl.create(:task, :name => "My Overdue Task", :deadline => Date.today-1, :complete => false)
  @future_task = FactoryGirl.create(:task, :name => "My Future Task", :deadline => Date.today)
end

When /^I go to the overdue page$/ do
  visit('/tasks/overdue')
end

Then /^I can see the overdue tasks$/ do
  assert page.has_content?(@overdue_task.name)
  assert page.has_no_content?(@future_task.name)
end
Given /^I seeded the following products:$/ do |table|
  @products = []
  @products = table.hashes
  for product in @products do
    FactoryGirl.create(:product, :product_code => product[:product_code], :name => product[:name], :price => product[:price])
    #Product.create(product)
  end
end

When /^I seeded the following pricing rules:$/ do |table|
  @pricing_rules_data = []
  @pricing_rules_data = table.hashes
  @pricing_rules = []
  for pricing_rule in @pricing_rules_data do
    @pricing_rules << FactoryGirl.create(:pricing_rule, :discount_type => pricing_rule[:discount_type], :bulk_threshold => pricing_rule[:bulk_threshold], :bulk_price => pricing_rule[:bulk_price], :product => Product.find_by_product_code(pricing_rule[:product_code]))
  end
end

When /^I create a new checkout without offers$/ do
  click_link "New Checkout"
  click_button "Save"
end

When /^I create a new checkout with all pricing rules$/ do
  click_link "New Checkout"
  within("#checkout_pricing_rule_ids") do
    for pricing_rule in @pricing_rules do
      select(pricing_rule.description)
    end
  end
  click_button "Save"
end


Then /^I can see a blank checkout$/ do
  for product in @products
    assert page.has_content?(product[:name])
  end
  assert page.find("#transactions li").has_content?("None")
  assert page.find("#pricing_rules li").has_content?("None")
end

Then /^I can see a checkout with the pricing rules listed$/ do
  for product in @products
    assert page.has_content?(product[:name])
  end
  assert page.find("#transactions li").has_content?("None")
  assert page.find("#pricing_rules li").has_no_content?("None")
  for pricing_rule in @pricing_rules do
    page.find("#pricing_rules li").has_content?(pricing_rule.description)
  end
end


When /^I can see the list of available pricing rules applied$/ do
  for pricing_rule in @pricing_rules
    assert page.has_no_content?(pricing_rule.description)
  end
end

When /^I add an any item$/ do
  within("##{@products[1][:product_code]}") do
    click_button "Add"
  end
end

Then /^the items gets listed as transaction$/ do
  assert page.find("#transactions").has_content?("1")
  assert page.find("#transactions").has_content?(@products[1][:name])
end

When /^I choose add up the bill$/ do
  click_link "Total"
end

Then /^I can see a total checkout value$/ do
  assert page.has_content?(@products[1][:price])
end

Then /^I can see the total checkout value (\d.+)$/ do |value|
  assert page.has_content?(value)
end

Given /I add the following items (".+")/ do |item |
  item.scan(/"([^"]+?)"/).flatten.each do |product_code|
    within("##{product_code}") do
        click_button "Add"
    end
  end
end