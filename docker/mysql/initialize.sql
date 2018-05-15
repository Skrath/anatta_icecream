-- Create tables
CREATE TABLE IF NOT EXISTS `icecream`.`types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `icecream`.`flavors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `flavorscol_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `icecream`.`types_to_flavors` (
  `type_id` INT NOT NULL,
  `flavor_id` INT NOT NULL,
  PRIMARY KEY (`type_id`, `flavor_id`),
  INDEX `fk_types_to_flavors_flavor_idx` (`flavor_id` ASC),
  CONSTRAINT `fk_types_to_flavors_type`
    FOREIGN KEY (`type_id`)
    REFERENCES `icecream`.`types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_types_to_flavors_flavor`
    FOREIGN KEY (`flavor_id`)
    REFERENCES `icecream`.`flavors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `icecream`.`containers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `cost` FLOAT NOT NULL DEFAULT 0.0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `icecream`.`order_items` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `container_id` INT NOT NULL,
  `type_id` INT NOT NULL,
  `flavor_id` INT NOT NULL,
  `type2_id` INT NULL,
  `flavor2_id` INT NULL,
  `type3_id` INT NULL,
  `flavor3_id` INT NULL,
  `weight` FLOAT NULL,
  `cost` FLOAT NOT NULL DEFAULT 0.0,
  PRIMARY KEY (`id`),
  INDEX `fk_order_items_container_idx` (`container_id` ASC),
  INDEX `fk_order_items_type_idx` (`type_id` ASC),
  INDEX `fk_order_items_flavor_idx` (`flavor_id` ASC),
  INDEX `fk_order_items_type2_idx` (`type2_id` ASC),
  INDEX `fk_order_items_flavor2_idx` (`flavor2_id` ASC),
  INDEX `fk_order_items_type3_idx` (`type3_id` ASC),
  INDEX `fk_order_items_flavor3_idx` (`flavor3_id` ASC),
  CONSTRAINT `fk_order_items_container`
    FOREIGN KEY (`container_id`)
    REFERENCES `icecream`.`containers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_type`
    FOREIGN KEY (`type_id`)
    REFERENCES `icecream`.`types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_flavor`
    FOREIGN KEY (`flavor_id`)
    REFERENCES `icecream`.`flavors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_type2`
    FOREIGN KEY (`type2_id`)
    REFERENCES `icecream`.`types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_flavor2`
    FOREIGN KEY (`flavor2_id`)
    REFERENCES `icecream`.`flavors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_type3`
    FOREIGN KEY (`type3_id`)
    REFERENCES `icecream`.`types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_items_flavor3`
    FOREIGN KEY (`flavor3_id`)
    REFERENCES `icecream`.`flavors` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Populate basic types
insert into types (name) values ('Moo-phoria Light Ice Cream');
insert into types (name) values ('Sorbet');
insert into types (name) values ('Non-Dairy');
insert into types (name) values ('Frozen Yogurt');
insert into types (name) values ('Original Ice Cream');
insert into types (name) values ('Sundaes');

-- Populate standard flavors
insert into flavors (name) values ('Vanilla');
insert into flavors (name) values ('Chocolate');
insert into flavors (name) values ('Strawberry');
insert into flavors (name) values ('Cheese Cake');
insert into flavors (name) values ('Butter Pecan');
insert into flavors (name) values ('Coconut');
insert into flavors (name) values ('Pistachio');
insert into flavors (name) values ('Cookies and Cream');
insert into flavors (name) values ('Salted Caramel');

-- Populate standard type->flavor mappings
insert into types_to_flavors (type_id, flavor_id)
select types.id, flavors.id from types, flavors
where types.name not in('Non-Dairy', 'Sorbet', 'Moo-phoria Light Ice Cream', 'Frozen Yogurt');

-- Populate Non-Dairy flavors and maps
insert into flavors (name) values ('Coconut Almond Fudge Chip');
insert into flavors (name) values ('Caramel Almond Brittle');

insert into types_to_flavors (type_id, flavor_id)
select types.id, flavors.id from types, flavors
where types.name = 'Non-Dairy'
and flavors.name in('Coconut Almond Fudge Chip', 'Caramel Almond Brittle');

-- Populate Sorbet flavors and maps
insert into flavors (name) values ('Berry Berry Extraordinary Sorbet');
insert into flavors (name) values ('Lemonade Sorbet');

insert into types_to_flavors (type_id, flavor_id)
select types.id, flavors.id from types, flavors
where types.name = 'Sorbet'
and flavors.name in('Berry Berry Extraordinary Sorbet', 'Lemonade Sorbet');

-- Populate Moo-phoria Light Ice Cream flavors and maps
insert into flavors (name) values ('Caramel Cookie Fix');
insert into flavors (name) values ('Caramel Almond Fix');

insert into types_to_flavors (type_id, flavor_id)
select types.id, flavors.id from types, flavors
where types.name = 'Moo-phoria Light Ice Cream'
and flavors.name in('Caramel Cookie Fix', 'Caramel Almond Fix');

-- Populate Frozen Yogurt flavors and maps
insert into flavors (name) values ('Strawberry Banana');
insert into flavors (name) values ('Raspberry');

insert into types_to_flavors (type_id, flavor_id)
select types.id, flavors.id from types, flavors
where types.name = 'Frozen Yogurt'
and flavors.name in('Strawberry Banana', 'Raspberry');

-- Populate cones/bowls (containers)
insert into containers (name, cost) values ('Small Cone', 0.25);
insert into containers (name, cost) values ('Medium Cone', 0.50);
insert into containers (name, cost) values ('Large Cone', 0.75);
insert into containers (name, cost) values ('Extra Large Cone', 1.00);

insert into containers (name, cost) values ('Small Bowl', 0.50);
insert into containers (name, cost) values ('Medium Bowl', 0.75);
insert into containers (name, cost) values ('Large Bowl', 1.00);
insert into containers (name, cost) values ('Extra Large Bowl', 1.50);