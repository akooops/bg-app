/* P.S :
 here you can find the sql scripts to implement the new products and the new raw materials 
 if you'll face a problem with the stock,commands or production operations , make sure to delete 
 the old rows in iec_bg database that are not assosiated with your entreprise_id (especially the commands table , stock table or the raw_material_stock table )

*/ 

-- raw materials 
INSERT INTO `raw_materials` (`id`, `created_at`, `updated_at`, `price`, `unit`, `name`, `volume`, `icon`) VALUES
 (10, '2023-04-15 13:50:54', '2023-04-15 13:50:54', '70.00', NULL, 'Laine', '1', '/assets/icons/nv/laine.svg'), 
 (11, '2023-04-15 13:52:11', '2023-04-16 17:40:55', '30.00', NULL, 'Coton', '1', '/assets/icons/nv/cotton.svg'), 
 (12, '2023-04-15 13:57:35', '2023-04-15 13:57:35', '900.00', NULL, 'Polyester', '1', '/assets/icons/nv/polyester.svg'),
 (13, '2023-04-15 13:59:46', '2023-04-15 13:59:46', '400.00', NULL, 'Garniture', '3', '/assets/icons/nv/garniture.svg'), 
 (14, '2023-04-15 13:59:16', '2023-04-15 13:59:16', '1300.00', NULL, 'Lin', '1', '/assets/icons/nv/lin.svg'),
 (15, '2023-04-15 14:00:12', '2023-04-15 14:00:12', '900.00', NULL, 'La soie', '1', '/assets/icons/nv/soie.svg'),
 (16, '2023-04-15 14:00:48', '2023-04-15 14:00:48', '1200.00', NULL, 'Cuir', '1', '/assets/icons/nv/cuire.svg'),
 (17, '2023-04-15 13:54:20', '2023-04-15 13:54:20', '50.00', NULL, 'Fixation', '2', '/assets/icons/nv/fixation.svg'), 
 (18, '2023-04-15 13:53:45', '2023-04-15 13:53:45', '500.00', NULL, 'Matières chimiques', '1', '/assets/icons/nv/chemicals.svg'), 
 (19, '2023-04-15 13:58:30', '2023-04-15 14:01:23', '750.00', NULL, 'Packaging', '3', '/assets/icons/nv/packaging.svg')
   
  -- products 
  INSERT INTO `products` (`id`, `created_at`, `updated_at`, `name`, `price_min`, `price_max`, `avg_demand`, `left_demand`, `ad_coef`, `description`, `prod_speed_factor`, `unit_prod_price`, `icon`, `dist_cost`, `percent_population`) VALUES
(1, '2023-04-15 20:50:12', '2023-04-15 20:50:12', 'Pantalon éphémère tendance', 1, 1, 1, 5850000, 1.00, 'Ce pantalon est fabriqué en coton et polyester pour un ajustement confortable et facile à porter. Les matières chimiques et les fixations sont utilisées pour garantir que le tissu est solide et durable, tandis que l\'emballage est conçu pour une présentation soignée. Ce pantalon est idéal pour ceux qui cherchent un look moderne et tendance à un prix abordable.', 1.00, 1.00, '1', 0, 0.90),
(2, '2023-04-15 20:50:49', '2023-04-15 20:50:49', 'Pantalon de collection', 1, 1, 1, 3250000, 1.00, 'Ce pantalon est conçu avec de la laine et du lin pour une sensation de douceur et de luxe. La combinaison de ces matières de haute qualité offre un ajustement confortable, tandis que la coupe élégante en fait un choix parfait pour des occasions formelles ou professionnelles.', 1.00, 1.00, '1', 0, 0.50),
(3, '2023-04-15 20:51:17', '2023-04-15 20:52:38', 'Robes de mariage', 1, 1, 1, 2275000, 1.00, 'Nos robes de mariage sont fabriquées à partir des meilleures matières chimiques et des fixations pour obtenir le meilleur tissu possible. Nous ajoutons également de la garniture pour un look élégant et raffiné. La coupe flatteuse et la conception de la robe garantissent une allure inoubliable pour votre jour spécial.', 1.00, 1.00, '1', 0, 0.35),
(4, '2023-04-15 20:52:04', '2023-04-15 20:52:04', 'T-shirt tendance', 1, 1, 1, 1950000, 1.00, 'Ce T-shirt est fabriqué en coton et polyester pour un ajustement confortable et facile à porter. Les matières chimiques et les fixations sont utilisées pour garantir que le tissu est solide et durable, malgré qu’il a un effet négatif sur l\'environnement. Ce T-shirt est idéal pour ceux qui cherchent un look décontracté et tendance à un prix abordable.', 1.00, 1.00, '1', 0, 0.30),
(5, '2023-04-15 20:53:23', '2023-04-15 20:53:23', 'T-shirt en édition limitée', 1, 1, 1, 325000, 1.00, 'Ce T-shirt de luxe est conçu avec du coton et de la soie pour une sensation de confort et de qualité supérieure. La combinaison de ces matières de haute qualité offre un ajustement confortable, tandis que la coupe flatteuse et la conception élégante en font un choix parfait pour des occasions spéciales ou des tenues décontractées haut de gamme.', 1.00, 1.00, '1', 0, 0.05),
(6, '2023-04-15 20:53:38', '2023-04-15 20:53:38', 'Pull à col rond', 1, 1, 1, 6500000, 1.00, 'Ce pull en coton et polyester est doux et confortable, parfait pour une journée de détente à la maison ou une soirée avec des amis. La coupe flatteuse et la conception simple mais élégante en font un choix polyvalent pour toutes les occasions.', 1.00, 1.00, '1', 0, 1.00),
(7, '2023-04-15 20:53:54', '2023-04-15 20:53:54', 'Veste parka urbaine', 1, 1, 1, 3640000, 1.00, 'Cette veste en polyester et coton est parfaite pour un style décontracté et pratique. Les matières chimiques et les fixations sont utilisées pour garantir que le tissu est solide et durable, tandis que l\'emballage est conçu pour une présentation soignée. La veste est idéale pour ceux qui cherchent un look décontracté et pratique à un prix abordable.', 1.00, 1.00, '1', 0, 0.56),
(8, '2023-04-15 20:54:12', '2023-04-15 20:54:12', 'Chaussures', 1, 1, 1, 6500000, 1.00, 'Ces chaussures en cuir sont conçues pour la durabilité et le confort. Le cuir de haute qualité offre un ajustement confortable, tandis que la conception classique et intemporelle convient à toutes les occasions.', 1.00, 1.00, '1', 0, 1.00),
(9, '2023-04-15 20:54:57', '2023-04-15 20:54:57', 'Costume raffiné', 1, 1, 1, 6500000, 1.00, 'Ce costume de luxe en coton et polyester est parfait pour un look élégant et professionnel. La combinaison de ces matières de haute qualité offre un ajustement confortable et une coupe flatteuse, tandis que la conception élégante convient à toutes les occasions professionnelles.', 1.00, 1.00, '1', 0, 1.00),
(10, '2023-04-15 20:55:34', '2023-04-15 20:55:34', 'Jupe ajustée à taille ceinturée', 1, 1, 1, 6500000, 1.00, 'Cette jupe est conçue pour mettre en valeur votre silhouette grâce à sa coupe ajustée à la taille et sa ceinture qui souligne votre taille. Elle est fabriquée à partir de coton de haute qualité, ce qui lui confère un toucher doux et confortable. Le tissu est également durable et facile à entretenir. Cette jupe est parfaite pour une variété d\'occasions, qu\'il s\'agisse d\'une journée de travail ou d\'une soirée en ville. Elle se marie parfaitement avec des hauts, des chaussures et des accessoires de toutes sortes, ce qui en fait un choix polyvalent pour votre garde-robe.', 1.00, 1.00, '1', 0, 1.00),
(11, '2023-04-15 20:55:47', '2023-04-15 20:55:47', 'jupe de prêt-à-porter', 1, 1, 1, 6500000, 1.00, 'Cette jupe est un choix abordable pour ceux qui recherchent un style à la mode sans se ruiner. Elle est fabriquée à partir de polyester, un matériau synthétique qui est durable et facile à entretenir, mais qui a également un impact environnemental négatif. La jupe est conçue pour être jetable après quelques utilisations, ce qui la rend moins durable que d\'autres options. Le design est à la mode et suit les dernières tendances de la mode, ce qui en fait un choix populaire pour les acheteurs qui recherchent un style à la pointe de la mode.', 1.00, 1.00, '1', 0, 1.00);

'
-- raw_material_suppliers
  INSERT INTO `raw_material_supplier` (`raw_material_id`, `supplier_id`, `price_factor`, `time_to_deliver`, `created_at`, `updated_at`, `is_available`) VALUES
(10, 1, 1.00, 3, NULL, NULL, 1),
(11, 1, 1.00, 3, NULL, NULL, 1),
(12, 1, 1.00, 3, NULL, NULL, 1),
(13, 1, 1.00, 3, NULL, NULL, 1),
(14, 1, 1.00, 3, NULL, NULL, 1),
(15, 1, 1.00, 3, NULL, NULL, 1),
(16, 1, 1.00, 3, NULL, NULL, 1),
(17, 1, 1.00, 3, NULL, NULL, 1),
(18, 1, 1.00, 3, NULL, NULL, 1),
(19, 2, 0.80, 6, NULL, NULL, 1)

-- raw_materials_stock
INSERT INTO `raw_materials_stock` (`entreprise_id`, `raw_material_id`, `quantity`, `unit`, `phase`) VALUES 
('29', '15', '2000.00', NULL, '0'), 
('29', '11', '4000.00', NULL, '0'), 
('29', '12', '1000.00', NULL, '0'), 
('29', '16', '1000.00', NULL, '0'), 
('29', '18', '3000.00', NULL, '0'),
 ('29', '17', '3000.00', NULL, '0'), 
 ('29', '14', '1000.00', NULL, '0'), 
 ('29', '10', '8000.00', NULL, '0'), 
 ('29', '13', '3000.00', NULL, '0'), 
 ('29', '19', '2000.00', NULL, '0')


-- row_materials_products 
INSERT INTO `raw_materials_products` (`product_id`, `raw_material_id`, `quantity`) VALUES 
('8', '18', '1'), ('8', '17', '1'), ('8', '16', '1'), ('8', '12', '1'), ('8', '11', '1'), ('7', '19', '1'), ('7', '18', '1'), ('7', '17', '1'), ('7', '13', '1'), ('7', '12', '1'), ('7', '11', '1'), ('7', '10', '1'), ('6', '19', '1'), ('6', '17', '1'), ('6', '18', '1'), ('6', '11', '1'), ('6', '10', '1'), ('5', '14', '1'), ('5', '19', '1'), ('5', '18', '1'), ('5', '17', '1'), ('5', '11', '1'), ('4', '19', '1'), ('4', '18', '1'), ('4', '17', '1'), ('4', '12', '1'), ('4', '11', '1'), ('3', '15', '1'), ('3', '13', '1'), ('3', '19', '1'), ('3', '17', '1'), ('3', '18', '1'), ('3', '11', '1'), ('2', '19', '1'), ('2', '18', '1'), ('2', '17', '1'), ('2', '12', '1'), ('2', '14', '1'), ('2', '10', '1'), ('1', '19', '1'), ('1', '18', '1'), ('1', '17', '1'), ('1', '12', '1'), ('1', '11', '1'), ('8', '19', '1'), ('9', '11', '1'), ('9', '12', '1'), ('9', '13', '1'), ('9', '14', '1'), ('9', '17', '1'), ('9', '18', '1'), ('9', '19', '1'), ('10', '10', '1'), ('10', '18', '1'), ('10', '17', '1'), ('10', '19', '1'), ('10', '13', '1'), ('10', '15', '1'), ('11', '11', '1'), ('11', '12', '1'), ('11', '17', '1'), ('11', '18', '1'), ('11', '19', '1'), ('11', '13', '1') 