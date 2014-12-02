-- Nutrition information from the Centers for Disease Control and Prevention
-- The U.S. Food and Drug Administration, the National Institutes of Health,
-- and http://www.nutritiondata.self.com.
-- Nutrition information is the average for healthy adult men and women.

-- drop relationship tables
drop table Consists_Of CASCADE CONSTRAINTS;
drop table Provides CASCADE CONSTRAINTS;
drop table Uses CASCADE CONSTRAINTS;
drop table Plans_Meal CASCADE CONSTRAINTS;

-- drop entity tables
drop table Customer CASCADE CONSTRAINTS;
drop table Recipe CASCADE CONSTRAINTS;
drop table Nutrient CASCADE CONSTRAINTS;
drop table Ingredient CASCADE CONSTRAINTS;
drop table Courses CASCADE CONSTRAINTS;
drop table Food_Group CASCADE CONSTRAINTS;
drop table Origins CASCADE CONSTRAINTS;

-- create entity tables
create table Customer(
  Login varchar2(30) primary key,
  Name varchar2(30) not null,
  Password varchar2(30) not null
);

create table Nutrient(
  Name varchar2(30) primary key,
  Unit varchar2(10) not null,
  RDV number not null
);

create table Food_Group(
	Name varchar2(30) primary key
);

create table Courses(
	Name varchar2(30) primary key
);

create table Origins(
	Name varchar2(30) primary key
);

create table Ingredient(
  Name varchar2(30) primary key,
  Unit varchar2(10) not null,
	FoodGroup varchar2(30) not null,
	foreign key (FoodGroup) references Food_Group(Name)
);

create table Recipe(
  ID number primary key,
  Name varchar2(30) not null,
  Instructions varchar2(4000) not null,
	Origin varchar2(30) not null,
	Course varchar2(30) not null,
  Author varchar2(30) not null,
  Servings number,
	foreign key (Origin) references Origins(name),
	foreign key (Course) references Courses(name),
  foreign key (Author) references Customer(login) on delete cascade
);

-- create relationship tables
create table Plans_Meal(
  Meal_ID number,
  Login varchar2(30) not null,
  Meal_Day date,
  Which varchar2(20),
  primary key(Meal_ID),
  foreign key(Login) references Customer(Login) on delete cascade
);

create table Consists_Of(
  Recipe_ID number,
  Ingredient_Name varchar2(30),
  Amount number,
  primary key (Recipe_ID, Ingredient_Name),
  foreign key(Recipe_ID) references Recipe(ID),
  foreign key(Ingredient_Name) references Ingredient(Name)
);

create table Provides(
  Ingredient_Name varchar2(30),
  Nutrient_Name varchar2(30),
  Amount number,
  primary key (Ingredient_Name, Nutrient_Name),
  foreign key(Ingredient_Name) references Ingredient(Name),
  foreign key(Nutrient_Name) references Nutrient(Name)
);

create table Uses(
  Recipe_ID number,
  Meal_ID number,
  primary key (Recipe_ID, Meal_ID),
  foreign key(Recipe_ID) references Recipe(ID),
  foreign key(Meal_ID) references Plans_Meal(Meal_ID)
);

commit;

--------------------------------------------------------
-- Insert default data

insert into Courses values('Appetizer');
insert into Courses values('Entree');
insert into Courses values( 'Side');
insert into Courses values('Dessert');

insert into Origins values('Mexican');
insert into Origins values('Italian');
insert into Origins values('Chinese');
insert into Origins values('Japanese');
insert into Origins values('Cajun');
insert into Origins values('Amercian');
insert into Origins values('German');
insert into Origins values('French');
insert into Origins values('Spanish');
insert into Origins values('Greek');
insert into Origins values('Korean');
insert into Origins values('Hungarian');
insert into Origins values('Yugoslavian');
insert into Origins values('English');
insert into Origins values('Russian');
  
insert into Food_Group values('Water');
insert into Food_Group values('Herb');
insert into Food_Group values('Spice');
insert into Food_Group values('Meat');
insert into Food_Group values('Poultry');
insert into Food_Group values('Fish');
insert into Food_Group values('Bread');
insert into Food_Group values('Cereal');
insert into Food_Group values('Nut');
insert into Food_Group values('Legume');
insert into Food_Group values('Fruit');
insert into Food_Group values('Vegetable');
insert into Food_Group values('Pasta');
insert into Food_Group values('Dairy');
insert into Food_Group values('Oil');
insert into Food_Group values('Grain');
insert into Food_Group values('Seed');

insert into Ingredient values('Water', 'oz', 'Water');
insert into Ingredient values('Salt', 'tsp', 'Spice');
insert into Ingredient values('Pepper', 'tsp', 'Spice'); 
insert into Ingredient values('Sugar', 'tsp', 'Spice');
insert into Ingredient values('Garlic', 'clove', 'Spice');
insert into Ingredient values('Oregano', 'tsp', 'Spice');
insert into Ingredient values('Cumin', 'tsp', 'Spice');
insert into Ingredient values('Parsley', 'tsp', 'Spice');
insert into Ingredient values('Cinnamon', 'tsp', 'Spice');
insert into Ingredient values('Nutmeg', 'tsp', 'Spice');
insert into Ingredient values('Raisins', 'gram', 'Fruit');
insert into Ingredient values('Pecans', 'gram', 'Nut');
insert into Ingredient values('Olive Oil', 'gram', 'Oil');
insert into Ingredient values('Flour', 'gram', 'Grain');
insert into Ingredient values('Paprika', 'tsp', 'Spice');
insert into Ingredient values('Beef', 'gram', 'Meat');
insert into Ingredient values('Chicken', 'gram', 'Poultry');
insert into Ingredient values('Salmon', 'gram', 'Fish');
insert into Ingredient values('Whole Milk', 'gram', 'Dairy');
insert into Ingredient values('Eggs', 'gram', 'Dairy');
insert into Ingredient values('Butter', 'gram', 'Dairy');
insert into Ingredient values('Tomato', 'gram', 'Fruit');
insert into Ingredient values('Potato', 'gram', 'Vegetable');

insert into Nutrient values('Protein', 'gram', 50);
insert into Nutrient values('Carbohydrates', 'gram', 300);
insert into Nutrient values('Cholesterol', 'mg', 300);
insert into Nutrient values('Vitamin A', 'IU', 5000);
insert into Nutrient values('Vitamin B6', 'mg', 2);
insert into Nutrient values('Vitamin B12', 'microgram', 6);
insert into Nutrient values('Vitamin C', 'mg', 60);
insert into Nutrient values('Vitamin D', 'IU', 400);
insert into Nutrient values('Vitamin E', 'IU', 30);
insert into Nutrient values('Vitamin K', 'microgram', 80);
insert into Nutrient values('Calories', 'each', 2000);
insert into Nutrient values('Unsaturated Fat', 'gram', 750);
insert into Nutrient values('Saturated Fat', 'gram', 200);
insert into Nutrient values('Sodium', 'mg', 2400);
insert into Nutrient values('Potassium', 'mg', 3500);
insert into Nutrient values('Dietary Fiber', 'gram', 25);
insert into Nutrient values('Calcium', 'mg', 1000);
insert into Nutrient values('Zinc', 'mg', 15);
insert into Nutrient values('Iron', 'mg', 18);
insert into Nutrient values('Magnesium', 'mg', 400);
insert into Nutrient values('Thiamin', 'mg', 1.5);
insert into Nutrient values('Niacin', 'mg', 20);
insert into Nutrient values('Riboflavin', 'mg', 1.7);
insert into Nutrient values('Folate', 'microgram', 400);
insert into Nutrient values('Biotin', 'microgram', 300);
insert into Nutrient values('Pantothenic Acid', 'mg', 10);
insert into Nutrient values('Phosporus', 'mg', 1000);
insert into Nutrient values('Iodine', 'microgram', 150);
insert into Nutrient values('Selenium', 'microgram', 70);
insert into Nutrient values('Copper', 'mg', 2);
insert into Nutrient values('Manganese', 'mg', 2);
insert into Nutrient values('Chromium', 'microgram', 120);
insert into Nutrient values('Molybdenum', 'microgram', 75);
insert into Nutrient values('Chloride', 'mg', 3500);

insert into Provides values('Sugar', 'Calories', 16);

insert into Provides values('Raisins', 'Calories', 3);
insert into Provides values('Raisins', 'Sodium', .11);
insert into Provides values('Raisins', 'Carbohydrates', .8);
insert into Provides values('Raisins', 'Dietary Fiber', .036);
insert into Provides values('Raisins', 'Protein', .030);

insert into Provides values('Pecans', 'Saturated Fat', .064);
insert into Provides values('Pecans', 'Carbohydrates', .046);
insert into Provides values('Pecans', 'Dietary Fiber', .092);
insert into Provides values('Pecans', 'Protein', .092);
insert into Provides values('Pecans', 'Vitamin A', .46);
insert into Provides values('Pecans', 'Vitamin C', .011);
insert into Provides values('Pecans', 'Calcium', .73);
insert into Provides values('Pecans', 'Iron', .025);
insert into Provides values('Pecans', 'Calories', 7);

insert into Provides values('Olive Oil', 'Iron', .08);
insert into Provides values('Olive Oil', 'Calories', 8.8);
insert into Provides values('Olive Oil', 'Saturated Fat', .14);

insert into Provides values('Flour', 'Calories', 3.6);
insert into Provides values('Flour', 'Carbohydrates', .88);
insert into Provides values('Flour', 'Dietary Fiber', .03);
insert into Provides values('Flour', 'Calcium', .78);
insert into Provides values('Flour', 'Iron', .003);

insert into Provides values('Beef', 'Calories', 1.4);
insert into Provides values('Beef', 'Saturated Fat', .02);
insert into Provides values('Beef', 'Cholesterol', .43);
insert into Provides values('Beef', 'Sodium', .54);
insert into Provides values('Beef', 'Calcium', 23);
insert into Provides values('Beef', 'Iron', 1.5);

insert into Provides values('Chicken', 'Calories', 1.1);
insert into Provides values('Chicken', 'Cholesterol', .57);
insert into Provides values('Chicken', 'Sodium', .65);
insert into Provides values('Chicken', 'Protein', .23);
insert into Provides values('Chicken', 'Vitamin C', .85);
insert into Provides values('Chicken', 'Calcium', 14.1);
insert into Provides values('Chicken', 'Iron', .76);

insert into Provides values('Salmon', 'Calories', 2);
insert into Provides values('Salmon', 'Saturated Fat', .030);
insert into Provides values('Salmon', 'Cholesterol', .55);
insert into Provides values('Salmon', 'Sodium', .59);
insert into Provides values('Salmon', 'Protein', .2);
insert into Provides values('Salmon', 'Vitamin A', 50.5);
insert into Provides values('Salmon', 'Vitamin C', 3.9);
insert into Provides values('Salmon', 'Calcium', 10.1);
insert into Provides values('Salmon', 'Iron', .36);

insert into Provides values('Whole Milk', 'Calories', .6);
insert into Provides values('Whole Milk', 'Saturated Fat', .032);
insert into Provides values('Whole Milk', 'Cholesterol', .098);
insert into Provides values('Whole Milk', 'Sodium', .4);
insert into Provides values('Whole Milk', 'Carbohydrates', .05);
insert into Provides values('Whole Milk', 'Protein', .033);
insert into Provides values('Whole Milk', 'Vitamin A', 102.5);
insert into Provides values('Whole Milk', 'Calcium', 114.8);

insert into Provides values('Eggs', 'Calories', 1.86);
insert into Provides values('Eggs', 'Saturated Fat', .043);
insert into Provides values('Eggs', 'Cholesterol', 8.84);
insert into Provides values('Eggs', 'Sodium', 1.46);
insert into Provides values('Eggs', 'Protein', .13);
insert into Provides values('Eggs', 'Vitamin A', 71.4);
insert into Provides values('Eggs', 'Calcium', 57.1);
insert into Provides values('Eggs', 'Iron', 3.86);

insert into Provides values('Butter', 'Calories', 7.17);
insert into Provides values('Butter', 'Saturated Fat', .515);
insert into Provides values('Butter', 'Cholesterol', 2.15);
insert into Provides values('Butter', 'Sodium', .11);
insert into Provides values('Butter', 'Protein', .009);
insert into Provides values('Butter', 'Vitamin A', 2489);
insert into Provides values('Butter', 'Calcium', 22);

insert into Provides values('Tomato', 'Calories', .18);
insert into Provides values('Tomato', 'Carbohydrates', .04);
insert into Provides values('Tomato', 'Dietary Fiber', .01);
insert into Provides values('Tomato', 'Sodium', .05);
insert into Provides values('Tomato', 'Vitamin A', 839);
insert into Provides values('Tomato', 'Vitamin C', 12.9);
insert into Provides values('Tomato', 'Calcium', 6.7);
insert into Provides values('Tomato', 'Iron', .24);

insert into Provides values('Potato', 'Calories', .77);
insert into Provides values('Potato', 'Sodium', .06);
insert into Provides values('Potato', 'Carbohydrates', .18);
insert into Provides values('Potato', 'Dietary Fiber', .05);
insert into Provides values('Potato', 'Protein', .019);
insert into Provides values('Potato', 'Vitamin C', 19.7);
insert into Provides values('Potato', 'Calcium', 10.8);
insert into Provides values('Potato', 'Iron', .78);

commit;