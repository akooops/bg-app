/* P.S :
 here you can find the sql scripts to implement the new products and the new raw materials 
 if you'll face a problem with the stock,commands or production operations , make sure to delete 
 the old rows in iec_bg database that are not assosiated with your entreprise_id (especially the commands table , stock table or the raw_material_stock table )

*/ 
-- departments
INSERT INTO `departments` (`id`, `name`, `starting_worker_nb`, `created_at`, `updated_at`, `icon`) VALUES
(1, 'Production', 5, '2021-03-20 20:44:18', '2021-03-20 21:23:16', 'fa-industry'),
(2, 'Approvisionnement', 2, '2021-03-20 21:23:44', '2021-03-20 21:23:44', 'fa-box-open'),
(3, 'Marketing', 5, '2021-03-20 21:23:58', '2021-03-20 21:23:58', 'fa-ad'),
(4, 'Finance', 3, '2021-03-20 21:25:16', '2021-03-20 21:25:16', 'fa-file-invoice-dollar'),
(5, 'Ressources Humaines', 2, '2021-03-20 21:32:30', '2021-04-08 10:53:02', 'fa-users');

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
 (19, '2023-04-15 13:58:30', '2023-04-15 14:01:23', '750.00', NULL, 'Packaging', '3', '/assets/icons/nv/packaging.svg');
   
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

-- suppliers
INSERT INTO `suppliers` (`id`, `name`, `foreign`, `created_at`, `updated_at`) VALUES
(1, 'Supplier 1', 0, '2022-03-30 23:31:28', '2022-04-30 15:07:43'),
(2, 'Supplier 2', 0, '2022-04-30 15:14:23', '2022-04-30 15:14:23');

-- raw_material_suppliers
  INSERT INTO `raw_material_supplier` (`raw_material_id`, `supplier_id`, `price_factor`, `time_to_deliver`, `created_at`, `updated_at`, `is_available`) VALUES
(10, 1, 1.00, 3, NULL, NULL, 1),(10, 2, 0.80, 6, NULL, NULL, 1),
(11, 1, 1.00, 3, NULL, NULL, 1),(11, 2, 0.80, 6, NULL, NULL, 1),
(12, 1, 1.00, 3, NULL, NULL, 1),(12, 2, 0.80, 6, NULL, NULL, 1),
(13, 1, 1.00, 3, NULL, NULL, 1),(13, 2, 0.80, 6, NULL, NULL, 1),
(14, 1, 1.00, 3, NULL, NULL, 1),(14, 2, 0.80, 6, NULL, NULL, 1),
(15, 1, 1.00, 3, NULL, NULL, 1),(15, 2, 0.80, 6, NULL, NULL, 1),
(16, 1, 1.00, 3, NULL, NULL, 1),(16, 2, 0.80, 6, NULL, NULL, 1),
(17, 1, 1.00, 3, NULL, NULL, 1),(17, 2, 0.80, 6, NULL, NULL, 1),
(18, 1, 1.00, 3, NULL, NULL, 1),(18, 2, 0.80, 6, NULL, NULL, 1),
(19, 1, 1.00, 3, NULL, NULL, 1),(19, 2, 0.80, 6, NULL, NULL, 1);


-- row_materials_products 
INSERT INTO `raw_materials_products` (`product_id`, `raw_material_id`, `quantity`) VALUES 
  ('12', '19', '50'), ('12', '18', '250'), ('12', '17', '80'), ('12', '12', '250'),('12', '11', '350'), 
  ('11', '19', '50'), ('11', '18', '300'), ('11', '17', '45'), ('11', '13', '40'), ('11', '12', '350'), ('11', '11', '350'), 
  ('10', '19', '100'), ('10', '18', '30'), ('10', '17', '40'), ('10', '15', '150'), ('10', '13', '20'), ('10', '10', '50'),
  ('9', '19', '250'), ('9', '18', '90'), ('9', '17', '100'),('9', '15', '350'), ('9', '14', '280'), ('9', '13', '100'), ('9', '12', '60'),('9', '11', '270'), 
  ('8', '19', '250'), ('8', '18', '100'), ('8', '17', '150'),('8', '16', '1400'), ('8', '12', '50'), ('8', '11', '200'),
  ('7', '19', '80'), ('7', '18', '300'), ('7', '17', '120'), ('7', '13', '150'), ('7', '12', '350'),('7', '11', '500'), ('7', '10', '300'), 
  ('6', '19', '150'), ('6', '18', '50'),('6', '17', '80'), ('6', '14', '300'), ('6', '11', '50'), ('6', '10', '150'),
  ('5', '19', '150'), ('5', '18', '50'), ('5', '17', '80'), ('5', '14', '400'), ('5', '11', '400'),
  ('4', '19', '50'), ('4', '18', '100'), ('4', '17', '40'), ('4', '12', '200'), ('4', '11', '150'),
  ('3', '19', '350'), ('3', '18', '300'),('3', '17', '250'), ('3', '15', '1200'), ('3', '13', '300'), ('3', '11', '1500'), 
  ('2', '19', '100'), ('2', '18', '40'), ('2', '17', '50'), ('2', '14', '500'), ('2', '12', '20'), ('2', '10', '100'),
  ('1', '19', '50'), ('1', '18', '200'), ('1', '17', '60'), ('1', '12', '300'), ('1', '11', '600');

  INSERT INTO `game_settings` (`id`, `name`, `code`, `value`, `default_value`, `created_at`, `updated_at`, `type`) VALUES
(2, 'Salaire employés niveau 1', 'salary_lv1', '30000', '30000', '2022-04-23 22:50:04', '2022-04-27 21:21:51', 'int'),
(3, 'Salaire employés niveau 2', 'salary_lv2', '60000', '60000', '2022-04-23 22:54:15', '2022-04-27 21:22:08', 'int'),
(4, 'Prix formation', 'workshop_price', '30000', '30000', '2022-04-23 23:27:32', '2022-04-24 06:50:15', 'int'),
(5, 'Coefficient prime', 'bonus_coeff', '2', '2', '2022-04-23 23:27:53', '2022-04-25 03:34:29', 'float'),
(6, 'Seuil humeur pour quitter', 'mood_quitting_threshold', '0.25', '0.25', '2022-04-23 23:28:20', '2022-04-27 21:23:27', 'float'),
(7, 'Probabilité de démission', 'quitting_prob', '0.1', '0.1', '2022-04-23 23:29:40', '2022-04-24 06:50:13', 'float'),
(8, 'Probabilité d\'embaucher', 'hiring_prob', '0.8', '0.8', '2022-04-23 23:30:56', '2022-04-24 06:50:07', 'float'),
(9, 'Vitesse réduction humeur employés', 'workers_mood_decay_rate', '0.05', '0.05', '2022-04-23 23:32:02', '2022-05-11 17:08:16', 'float'),
(10, 'Prix machines niveau 1', 'machines_lv1_price', '9000000', '9000000', '2022-04-23 23:32:30', '2023-04-18 21:34:21', 'int'),
(11, 'Prix machines niveau 2', 'machines_lv2_price', '18000000', '18000000', '2022-04-23 23:32:51', '2023-04-18 21:34:21', 'int'),
(12, 'Prix machines niveau 3', 'machines_lv3_price', '45000000', '45000000', '2022-04-23 23:33:38', '2023-04-18 21:34:21', 'int'),
(13, 'Vitesse machines niveau 1', 'machines_lv1_speed', '1', '1', '2022-04-23 23:34:03', '2022-04-24 06:50:09', 'float'),
(14, 'Vitesse machines niveau 2', 'machines_lv2_speed', '2.5', '2.5', '2022-04-23 23:34:17', '2022-05-05 13:37:28', 'float'),
(15, 'Vitesse machines niveau 3', 'machines_lv3_speed', '7', '7', '2022-04-23 23:34:30', '2022-05-05 13:38:00', 'float'),
(16, 'Pollution machines niveau 1', 'machines_lv1_pollution', '3', '3', '2022-04-23 23:35:08', '2022-04-24 06:50:08', 'float'),
(17, 'Pollution machines niveau 2', 'machines_lv2_pollution', '2', '2', '2022-04-23 23:35:31', '2022-04-24 06:50:09', 'float'),
(18, 'Pollution machines niveau 3', 'machines_lv3_pollution', '1', '1', '2022-04-23 23:35:53', '2022-04-24 06:50:11', 'float'),
(19, 'Durabilité machines niveau 1', 'machines_lv1_durability', '0.2', '0.2', '2022-04-23 23:36:40', '2022-05-07 10:18:31', 'float'),
(20, 'Durabilité machines niveau 2', 'machines_lv2_durability', '0.125', '0.125', '2022-04-23 23:37:00', '2022-04-24 06:50:09', 'float'),
(21, 'Durabilité machines niveau 3', 'machines_lv3_durability', '0.0416', '0.0416', '2022-04-23 23:38:46', '2022-04-24 06:50:10', 'float'),
(22, 'Cout unitaire de distribution', 'dist_unit_cost', '5', '5', '2022-04-23 23:39:56', '2022-04-24 06:50:07', 'float'),
(23, 'Cout unitaire pollution', 'pollution_unit_cost', '1000', '1000', '2022-04-23 23:40:20', '2022-04-24 06:50:12', 'float'),
(24, 'Prix de la manutention des MP', 'mp_stock_price', '2.5', '2.5', '2022-04-23 23:41:09', '2022-04-24 06:50:12', 'float'),
(25, 'Simulation en cours ?', 'game_started', '1', '0', '2022-04-23 23:41:29', '2023-04-18 21:35:12', 'bool'),
(26, 'Semaine début de simulation', 'start_date', '1', '1', '2022-04-23 23:42:50', '2022-04-24 06:50:14', 'int'),
(27, 'Semaine courante de la simulation', 'current_date', '1', '1', '2022-04-23 23:43:28', '2023-04-29 00:19:01', 'int'),
(28, 'Afficher le score finale', 'show_final_score', '0', '0', '2022-04-23 23:43:53', '2022-04-24 06:50:14', 'bool'),
(29, 'Population', 'population', '1000000', '1000000', '2022-04-27 20:11:28', '2022-04-27 20:11:28', 'float'),
(30, 'Pourcentage taxe CA', 'ca_tax_percent', '0.1', '0.1', '2022-05-04 12:07:27', '2022-05-11 17:08:02', 'float'),
(31, 'Durabilité machines niveau 0', 'machines_lv0_durability', '0.25', '0.25', '2023-04-24 13:53:29', '2023-04-24 13:53:29', 'float'),
(32, 'Pollution machines niveau 0', 'machines_lv0_pollution', '10', '10', '2023-04-24 13:54:04', '2023-04-24 13:54:04', 'float'),
(33, 'Vitesse machines niveau 0', 'machines_lv0_speed', '2', '2', '2023-04-24 13:54:54', '2023-04-24 13:54:54', 'float'),
(34, 'Prix machines niveau 0', 'machines_lv0_price', '6200000', '6200000', '2023-04-24 13:55:31', '2023-04-24 13:55:31', 'int');

INSERT INTO `indicators` (`id`, `name`, `code`, `created_at`, `updated_at`, `starting_value`, `is_financial`) VALUES
(1, 'Chiffre d\'Affaire', 'ca', NULL, '2022-05-07 10:09:43', 0, 1),
(2, 'Nombre d\'Employés', 'nb_workers', NULL, '2021-04-10 20:05:34', 8, 0),
(3, 'Part du Marché', 'market_share', NULL, NULL, 0, 1),
(4, 'Employés - Niveau 1', 'nb_workers_lv1', NULL, '2022-05-07 10:15:26', 3, 0),
(5, 'Employés - Approvisionnement', 'nb_workers_approv', NULL, NULL, 3, 0),
(6, 'Employés - RH', 'nb_workers_rh', NULL, NULL, 3, 0),
(7, 'Employés - Marketing', 'nb_workers_marketing', NULL, NULL, 3, 0),
(8, 'Employés - Finance', 'nb_workers_finance', NULL, NULL, 3, 0),
(9, 'Machines - Niveau 1', 'nb_machines_lv1', NULL, '2022-05-07 10:13:07', 3, 0),
(11, 'Taux de Rebut', 'reject_rate', '2021-04-01 15:15:42', '2021-04-08 15:26:17', 0.01, 0),
(12, 'Disponibilité', 'caisse', '2021-04-02 21:13:50', '2022-05-07 01:26:06', 50000000, 1),
(13, 'Coefficients de Production', 'prod_cost', '2021-04-02 21:14:13', '2021-04-02 21:14:27', 0, 1),
(14, 'Coefficient de Productivité', 'productivity_coeff', '2021-04-02 22:26:45', '2021-04-11 13:01:30', 0.7, 0),
(15, 'Machines Occupées - Niveau 1', 'nb_machines_lv1_busy', '2021-04-04 07:06:58', '2021-04-04 07:06:58', 0, 0),
(16, 'Machines en Pannes', 'failed_machines', '2021-04-04 07:10:02', '2021-04-04 07:10:02', 0, 0),
(17, 'Nombre d\'Abonnés', 'nb_subscribers', '2021-04-04 19:07:15', '2021-04-04 19:12:27', 10, 0),
(18, 'Présence RSS', 'social_presence', '2021-04-04 19:07:43', '2021-04-04 19:07:43', 0, 0),
(19, 'Présence sur les Médias', 'media_presence', '2021-04-04 19:07:59', '2021-04-04 19:07:59', 0, 0),
(20, 'Présence aux évènements', 'events_presence', '2021-04-04 19:08:37', '2021-04-11 13:01:01', 0, 0),
(21, 'Coefficient Unitaire de Distribution', 'dist_unit_cost', '2021-04-04 21:20:08', '2021-04-04 21:20:08', 1, 0),
(22, 'Coefficients de Distribution', 'dist_cost', '2021-04-04 21:44:24', '2021-04-04 21:44:24', 0, 1),
(23, 'Fiabilité des Machines', 'machines_health', '2021-04-06 18:09:23', '2021-04-06 18:38:06', 0.7, 0),
(24, 'Coefficients de Matière Première', 'raw_materials_cost', '2021-04-07 11:23:36', '2021-04-07 11:23:36', 0, 1),
(25, 'Pantalon cargo ', 'ca_1', '2021-04-07 17:43:42', '2021-04-10 11:23:24', 1000, 0),
(26, 'Pantalon portfino', 'ca_2', '2021-04-07 17:43:51', '2021-04-10 11:23:15', 1000, 0),
(27, 'Robe marriage', 'ca_3', '2021-04-07 17:44:03', '2021-04-10 11:23:08', 1000, 0),
(28, 'T-shirt', 'ca_4', '2021-04-07 17:44:17', '2021-04-10 11:22:52', 1000, 0),
(29, 'Dettes', 'dettes', '2021-04-07 23:09:45', '2021-04-07 23:09:45', 0, 1),
(30, 'Taux d\'endettement', 'debt_ratio', '2021-04-08 10:35:35', '2021-04-08 10:35:35', 1, 0),
(31, 'Humeur des employés', 'workers_mood', '2021-04-08 10:35:53', '2022-05-07 16:58:55', 1, 0),
(32, 'Score Finale', 'score_final', '2021-04-10 22:18:01', '2021-04-10 22:18:01', 0, 0),
(33, 'Employés Occupés - Niveau 1', 'nb_workers_lv1_busy', '2022-03-11 01:27:02', '2022-03-11 01:27:02', 0, 0),
(34, 'Machines - Niveau 2', 'nb_machines_lv2', '2022-03-12 01:56:50', '2022-03-12 01:56:50', 0, 0),
(35, 'Machines Occupées - Niveau 2', 'nb_machines_lv2_busy', '2022-03-12 01:57:16', '2022-03-12 01:57:16', 0, 0),
(36, 'Machines - Niveau 3', 'nb_machines_lv3', '2022-03-12 01:57:46', '2022-03-12 01:57:46', 0, 0),
(37, 'Machines Occupées - Niveau 3', 'nb_machines_lv3_busy', '2022-03-12 01:58:01', '2022-03-12 01:58:11', 0, 0),
(38, 'Employés - Niveau 2', 'nb_workers_lv2', '2022-03-12 02:02:04', '2022-03-12 02:02:04', 0, 0),
(39, 'Employés Occupés - Niveau 2', 'nb_workers_lv2_busy', '2022-03-12 02:02:25', '2022-03-12 02:02:25', 0, 0),
(40, 'Santé machines - Niveau 1', 'machines_lv1_health', '2022-03-13 23:48:15', '2022-03-13 23:48:15', 1, 0),
(41, 'Santé machines - Niveau 2', 'machines_lv2_health', '2022-03-13 23:48:44', '2022-03-13 23:48:44', 1, 0),
(42, 'Santé machines - Niveau 3', 'machines_lv3_health', '2022-03-13 23:49:01', '2022-03-13 23:49:01', 1, 0),
(43, '5S - Semaine', '5s_day', '2022-03-15 00:08:07', '2022-03-15 00:08:07', 4, 0),
(44, 'Nombre employés à embaucher', 'nb_workers_to_hire', '2022-03-16 18:02:51', '2022-03-16 18:02:51', 0, 0),
(45, 'Polo rugby', 'ca_5', '2022-04-25 01:36:50', '2022-05-07 10:11:53', 0, 0),
(46, 'Pull à col rond\n', 'ca_6', '2022-04-25 01:37:22', '2022-05-07 10:11:39', 0, 0),
(47, 'Parka', 'ca_7', '2022-04-25 01:37:33', '2022-05-07 10:11:16', 0, 0),
(48, 'Richelieu', 'ca_8', '2022-04-25 01:37:44', '2022-05-07 10:10:21', 0, 0),
(49, 'Tuxedo', 'ca_9', '2022-04-25 01:37:54', '2022-05-07 10:10:10', 0, 0),
(50, 'Santé machines - Niveau 0', 'machines_lv0_health', '2023-04-24 13:45:55', '2023-04-24 13:45:55', 1, 0),
(51, 'Machines Occupées - Niveau 0', 'nb_machines_lv0_busy', '2023-04-24 13:46:19', '2023-04-24 13:46:19', 0, 0),
(52, 'Machines - Niveau 0', 'nb_machines_lv0', '2023-04-24 13:46:43', '2023-04-24 13:46:43', 0, 0),
(53, 'Jupe ajustée', 'ca_10', '2023-04-25 19:24:53', '2023-04-25 19:24:53', 0, 0),
(54, 'Jupe longue', 'ca_11', '2023-04-25 19:25:15', '2023-04-25 19:25:15', 0, 0),
(55, 'Pull à col bâteau', 'ca_12', '2023-04-25 19:31:53', '2023-04-25 19:31:53', 0, 0);
