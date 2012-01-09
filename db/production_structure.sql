CREATE TABLE `align_qc` (
  `id` int(11) NOT NULL auto_increment,
  `flow_lane_id` int(11) NOT NULL,
  `sequencing_key` varchar(50) default NULL,
  `lane_nr` tinyint(4) default NULL,
  `lane_yield` int(11) default NULL,
  `clusters_raw` int(11) default NULL,
  `clusters_pf` int(11) default NULL,
  `cycle1_intensity_pf` int(11) default NULL,
  `cycle20_intensity_pct_pf` int(11) default NULL,
  `pct_pf_clusters` decimal(6,2) default NULL,
  `pct_align_pf` decimal(6,2) default NULL,
  `align_score_pf` decimal(8,2) default NULL,
  `pct_error_rate_pf` decimal(6,2) default NULL,
  `nr_NM` int(11) default NULL,
  `nr_QC` int(11) default NULL,
  `nr_RX` int(11) default NULL,
  `nr_U0` int(11) default NULL,
  `nr_U1` int(11) default NULL,
  `nr_U2` int(11) default NULL,
  `nr_UM` int(11) default NULL,
  `nr_nonuniques` int(11) default NULL,
  `nr_uniques` int(11) default NULL,
  `min_insert` smallint(6) default NULL,
  `max_insert` smallint(6) default NULL,
  `median_insert` smallint(6) default NULL,
  `total_reads` int(11) default NULL,
  `pf_reads` int(11) default NULL,
  `failed_reads` int(11) default NULL,
  `consistent_unique_bp` int(11) default NULL,
  `consistent_unique_pct` decimal(4,1) default NULL,
  `rescued_bp` int(11) default NULL,
  `rescued_pct` decimal(4,1) default NULL,
  `total_consistent_bp` int(11) default NULL,
  `total_consistent_pct` decimal(4,1) default NULL,
  `pf_unique_bp` int(11) default NULL,
  `pf_unique_pct` decimal(4,1) default NULL,
  `notes` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `qc_flow_lane_fk` (`flow_lane_id`),
  CONSTRAINT `qc_flow_lane_fk` FOREIGN KEY (`flow_lane_id`) REFERENCES `flow_lanes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=323 DEFAULT CHARSET=latin1;

CREATE TABLE `alignment_refs` (
  `id` int(11) NOT NULL auto_increment,
  `alignment_key` varchar(20) NOT NULL,
  `interface_name` varchar(25) default NULL,
  `genome_build` varchar(50) default NULL,
  `created_by` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

CREATE TABLE `assigned_barcodes` (
  `id` int(11) NOT NULL auto_increment,
  `assign_date` date default NULL,
  `group_name` varchar(30) default NULL,
  `owner_name` varchar(25) default NULL,
  `sample_type` varchar(25) default NULL,
  `start_barcode` mediumint(9) NOT NULL,
  `end_barcode` mediumint(9) NOT NULL,
  `created_at` datetime default NULL,
  `updated_by` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `attached_files` (
  `id` int(11) NOT NULL auto_increment,
  `sampleproc_id` int(11) NOT NULL,
  `sampleproc_type` varchar(50) NOT NULL,
  `document` varchar(255) default NULL,
  `document_content_type` varchar(40) default NULL,
  `document_file_size` varchar(25) default NULL,
  `notes` varchar(255) default NULL,
  `updated_by` int(11) default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL auto_increment,
  `cgroup_id` int(11) default NULL,
  `category` varchar(50) NOT NULL,
  `category_description` varchar(255) default NULL,
  `archive_flag` char(1) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;

CREATE TABLE `category_values` (
  `id` int(11) NOT NULL auto_increment,
  `category_id` int(11) NOT NULL,
  `c_position` int(4) default NULL,
  `c_value` varchar(50) NOT NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=327 DEFAULT CHARSET=latin1;

CREATE TABLE `cgroups` (
  `id` int(11) NOT NULL auto_increment,
  `group_name` varchar(25) NOT NULL,
  `sort_order` smallint(6) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

CREATE TABLE `consent_protocols` (
  `id` int(11) NOT NULL auto_increment,
  `consent_nr` char(8) default NULL,
  `consent_name` varchar(100) default NULL,
  `consent_abbrev` varchar(50) default NULL,
  `email_confirm_to` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 1434624 kB';

CREATE TABLE `flow_cells` (
  `id` int(11) NOT NULL auto_increment,
  `flowcell_date` date default NULL,
  `nr_bases_read1` char(4) default NULL,
  `nr_bases_index` char(2) default NULL,
  `nr_bases_read2` char(4) default NULL,
  `cluster_kit` varchar(10) default NULL,
  `sequencing_kit` varchar(10) default NULL,
  `flowcell_status` char(2) default NULL,
  `sequencing_key` varchar(50) default NULL,
  `sequencing_date` date default NULL,
  `seq_machine_id` int(11) default NULL,
  `seq_run_nr` smallint(6) default NULL,
  `machine_type` varchar(10) default NULL,
  `hiseq_xref` varchar(50) default NULL,
  `notes` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 657408 kB; (`protocol_id`) REFER `sampleDB/prot';

CREATE TABLE `flow_lanes` (
  `id` int(11) NOT NULL auto_increment,
  `flow_cell_id` int(11) NOT NULL,
  `seq_lib_id` int(11) default NULL,
  `sequencing_key` varchar(50) default NULL,
  `machine_type` varchar(10) default NULL,
  `lib_barcode` varchar(20) default NULL,
  `lib_name` varchar(50) default NULL,
  `lane_nr` tinyint(4) NOT NULL,
  `lib_conc` float(11,6) default NULL,
  `lib_conc_uom` varchar(6) default NULL,
  `runtype_adapter` varchar(20) default NULL,
  `pool_id` mediumint(9) default NULL,
  `oligo_pool` varchar(8) default NULL,
  `alignment_ref_id` int(11) default NULL,
  `alignment_ref` varchar(50) default NULL,
  `notes` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `fl_seq_lib_fk` (`seq_lib_id`),
  KEY `fl_flow_cell_fk` (`flow_cell_id`),
  CONSTRAINT `fl_flow_cell_fk` FOREIGN KEY (`flow_cell_id`) REFERENCES `flow_cells` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fl_seq_lib_fk` FOREIGN KEY (`seq_lib_id`) REFERENCES `seq_libs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=389 DEFAULT CHARSET=latin1;

CREATE TABLE `histologies` (
  `id` int(11) NOT NULL auto_increment,
  `sample_id` int(11) default NULL,
  `he_barcode_key` varchar(20) NOT NULL,
  `he_date` date default NULL,
  `histopathology` varchar(25) default NULL,
  `he_classification` varchar(50) default NULL,
  `pathologist` varchar(50) default NULL,
  `tumor_cell_content` decimal(7,3) default NULL,
  `inflammation_type` varchar(25) default NULL,
  `inflammation_infiltration` varchar(25) default NULL,
  `comments` varchar(255) default NULL,
  `updated_by` smallint(6) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `index_tags` (
  `id` int(11) NOT NULL auto_increment,
  `runtype_adapter` varchar(25) default NULL,
  `tag_nr` smallint(6) default NULL,
  `tag_sequence` varchar(12) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

CREATE TABLE `items` (
  `id` int(11) NOT NULL auto_increment,
  `order_id` int(11) default NULL,
  `po_number` varchar(20) default NULL,
  `requester_name` varchar(30) default NULL,
  `deliver_site` char(4) default NULL,
  `item_description` varchar(255) default NULL,
  `company_name` varchar(50) default NULL,
  `catalog_nr` varchar(50) default NULL,
  `chemical_flag` char(1) default NULL,
  `item_size` varchar(50) default NULL,
  `item_quantity` varchar(25) default NULL,
  `item_quote` varchar(100) default NULL,
  `item_price` decimal(9,2) default NULL,
  `item_received` char(1) default NULL,
  `grant_nr` varchar(30) default NULL,
  `notes` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  `updated_by` smallint(6) default NULL,
  PRIMARY KEY  (`id`),
  KEY `it_order_fk` (`order_id`),
  CONSTRAINT `it_order_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=latin1;

CREATE TABLE `lib_barcodes` (
  `id` int(11) NOT NULL auto_increment,
  `barcode_min` mediumint(9) NOT NULL,
  `barcode_max` mediumint(9) NOT NULL,
  `assigned_to` smallint(6) NOT NULL,
  `assigned_date` date NOT NULL,
  `created_at` date default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE `lib_samples` (
  `id` int(11) NOT NULL auto_increment,
  `seq_lib_id` int(11) default NULL,
  `splex_lib_id` int(11) default NULL,
  `splex_lib_barcode` varchar(20) default NULL,
  `processed_sample_id` int(11) default NULL,
  `sample_name` varchar(50) default NULL,
  `source_DNA` varchar(50) default NULL,
  `runtype_adapter` varchar(50) default NULL,
  `index_tag` smallint(6) default NULL,
  `enzyme_code` varchar(50) default NULL,
  `notes` varchar(255) default NULL,
  `updated_by` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `ls_seq_lib_id` (`seq_lib_id`),
  CONSTRAINT `ls_seq_lib_id` FOREIGN KEY (`seq_lib_id`) REFERENCES `seq_libs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=latin1;

CREATE TABLE `machine_incidents` (
  `id` int(11) NOT NULL auto_increment,
  `seq_machine_id` int(11) default NULL,
  `incident_date` date NOT NULL,
  `incident_description` varchar(255) NOT NULL,
  `updated_by` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

CREATE TABLE `molecular_assays` (
  `id` int(11) NOT NULL auto_increment,
  `barcode_key` varchar(20) NOT NULL,
  `processed_sample_id` int(11) default NULL,
  `protocol_id` int(11) default NULL,
  `owner` varchar(25) default NULL,
  `preparation_date` date default NULL,
  `volume` smallint(6) default NULL,
  `concentration` decimal(8,3) default NULL,
  `plate_number` varchar(25) default NULL,
  `plate_coord` varchar(4) default NULL,
  `notes` varchar(255) default NULL,
  `updated_by` smallint(6) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

CREATE TABLE `orders` (
  `id` int(11) NOT NULL auto_increment,
  `company_name` varchar(50) default NULL,
  `order_quote` varchar(100) default NULL,
  `date_ordered` date default NULL,
  `po_number` varchar(20) default NULL,
  `rpo_or_cwa` char(6) default NULL,
  `incl_chemicals` char(1) default NULL,
  `order_received` char(1) default NULL,
  `order_number` varchar(20) default NULL,
  `notes` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  `updated_by` smallint(6) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=latin1;

CREATE TABLE `pathologies` (
  `id` int(11) NOT NULL auto_increment,
  `patient_id` int(11) NOT NULL,
  `collection_date` date default NULL,
  `pathology_date` date default NULL,
  `pathologist` varchar(50) default NULL,
  `general_pathology` varchar(25) default NULL,
  `pathology_classification` varchar(100) default NULL,
  `tumor_stage` char(2) default NULL,
  `xrt_flag` char(2) default NULL,
  `t_code` char(2) default NULL,
  `n_code` char(2) default NULL,
  `m_code` char(2) default NULL,
  `comments` varchar(255) default NULL,
  `updated_by` smallint(6) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `patients` (
  `id` int(11) NOT NULL auto_increment,
  `clinical_id_encrypted` tinyblob,
  `gender` char(1) default NULL,
  `ethnicity` varchar(35) default NULL,
  `race` varchar(70) default NULL,
  `hipaa_encrypted` varbinary(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 1434624 kB';

CREATE TABLE `pools` (
  `id` int(11) NOT NULL auto_increment,
  `pool_name` varchar(35) NOT NULL,
  `tube_label` varchar(15) NOT NULL,
  `pool_description` varchar(80) default NULL,
  `from_pools` varchar(100) default NULL,
  `from_plates` varchar(100) default NULL,
  `total_oligos` int(11) NOT NULL default '0',
  `enzyme_code` varchar(50) default NULL,
  `source_conc_um` decimal(8,3) default NULL,
  `pool_volume` decimal(8,3) default NULL,
  `project_id` smallint(6) default NULL,
  `storage_location_id` smallint(6) default NULL,
  `notes` varchar(255) default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;

CREATE TABLE `processed_samples` (
  `id` int(11) NOT NULL auto_increment,
  `sample_id` int(11) default NULL,
  `patient_id` int(11) default NULL,
  `protocol_id` int(11) default NULL,
  `extraction_type` varchar(25) default NULL,
  `processing_date` date default NULL,
  `input_uom` varchar(25) default NULL,
  `input_amount` decimal(11,3) default NULL,
  `barcode_key` varchar(25) default NULL,
  `old_barcode` varchar(25) default NULL,
  `support` varchar(25) default NULL,
  `elution_buffer` varchar(25) default NULL,
  `vial` varchar(10) default NULL,
  `final_vol` decimal(11,3) default NULL,
  `final_conc` decimal(11,3) default NULL,
  `final_a260_a280` decimal(11,3) default NULL,
  `final_rin_nr` decimal(4,1) default NULL,
  `psample_remaining` char(2) default NULL,
  `storage_location_id` int(11) default NULL,
  `storage_shelf` varchar(10) default NULL,
  `storage_boxbin` varchar(25) default NULL,
  `comments` varchar(255) default NULL,
  `updated_by` smallint(6) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `ps_sample_fk` (`sample_id`),
  KEY `ps_barcode_idx` (`barcode_key`),
  CONSTRAINT `ps_sample_fk` FOREIGN KEY (`sample_id`) REFERENCES `samples` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 657408 kB; (`tissue_id`) REFER `sampleDB/tissue';

CREATE TABLE `protocols` (
  `id` int(11) NOT NULL auto_increment,
  `protocol_name` varchar(50) default NULL,
  `protocol_abbrev` varchar(25) default NULL,
  `protocol_version` varchar(10) default NULL,
  `protocol_type` char(1) default NULL,
  `protocol_code` char(3) default NULL,
  `reference` varchar(100) default NULL,
  `comments` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 1434624 kB';

CREATE TABLE `researchers` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `researcher_name` varchar(50) NOT NULL,
  `researcher_initials` varchar(3) NOT NULL,
  `company` varchar(50) default NULL,
  `phone_number` varchar(20) default NULL,
  `active_inactive` char(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

CREATE TABLE `reserved_barcodes` (
  `id` int(11) NOT NULL auto_increment,
  `barcode_key` varchar(20) default NULL,
  `protocol_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `rb_barcode_idx` (`barcode_key`)
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=latin1;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

CREATE TABLE `roles_users` (
  `role_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  KEY `index_roles_users_on_role_id` (`role_id`),
  KEY `index_roles_users_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `run_dirs` (
  `id` int(11) NOT NULL auto_increment,
  `flow_cell_id` int(11) NOT NULL,
  `sequencing_key` varchar(50) default NULL,
  `storage_device_id` smallint(6) NOT NULL,
  `device_name` varchar(25) default NULL,
  `rdir_name` varchar(50) default NULL,
  `file_count` int(11) default NULL,
  `total_size_gb` decimal(6,2) default NULL,
  `date_sized` date default NULL,
  `date_copied` date default NULL,
  `copied_by` smallint(6) default NULL,
  `date_verified` date default NULL,
  `verified_by` smallint(6) default NULL,
  `delete_flag` char(1) default NULL,
  `date_deleted` date default NULL,
  `notes` varchar(255) default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

CREATE TABLE `sample_characteristics` (
  `id` int(11) NOT NULL auto_increment,
  `patient_id` int(11) default NULL,
  `collection_date` date default NULL,
  `clinic_or_location` varchar(100) default NULL,
  `consent_protocol_id` int(11) default NULL,
  `consent_nr` varchar(15) default NULL,
  `gender` char(1) default NULL,
  `ethnicity` varchar(35) default NULL,
  `race` varchar(70) default NULL,
  `nccc_tumor_id` varchar(20) default NULL,
  `nccc_pathno` varchar(20) default NULL,
  `pathology_id` int(11) default NULL,
  `pathology` varchar(50) default NULL,
  `comments` varchar(255) default NULL,
  `updated_by` smallint(6) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 1434624 kB';

CREATE TABLE `samples` (
  `id` int(11) NOT NULL auto_increment,
  `patient_id` int(11) default NULL,
  `sample_characteristic_id` int(11) default NULL,
  `source_sample_id` int(11) default NULL,
  `source_barcode_key` varchar(20) default NULL,
  `barcode_key` varchar(20) NOT NULL,
  `alt_identifier` varchar(20) default NULL COMMENT 'NCCC new path no',
  `sample_date` date default NULL,
  `sample_type` varchar(50) default NULL,
  `sample_tissue` varchar(50) default NULL,
  `left_right` char(1) default NULL,
  `tissue_preservation` varchar(25) default NULL,
  `tumor_normal` varchar(25) default NULL,
  `sample_container` varchar(20) default NULL,
  `vial_type` varchar(30) default NULL,
  `amount_initial` decimal(10,3) default '0.000',
  `amount_rem` decimal(10,3) default '0.000',
  `amount_uom` varchar(20) default NULL,
  `sample_remaining` char(2) default NULL,
  `storage_location_id` int(11) default NULL,
  `storage_shelf` varchar(10) default NULL,
  `storage_boxbin` varchar(25) default NULL,
  `comments` varchar(255) default NULL,
  `updated_by` smallint(6) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `smp_patient_fk` (`patient_id`),
  KEY `smp_sample_characteristic_fk` (`sample_characteristic_id`),
  CONSTRAINT `smp_sample_characteristic_fk` FOREIGN KEY (`sample_characteristic_id`) REFERENCES `sample_characteristics` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 657408 kB; (`patient_id`) REFER `sampleDB/patie';

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `seq_libs` (
  `id` int(11) NOT NULL auto_increment,
  `barcode_key` varchar(20) default NULL,
  `lib_name` varchar(50) NOT NULL,
  `library_type` char(2) default NULL,
  `lib_status` char(2) default NULL,
  `protocol_id` int(11) default NULL,
  `owner` varchar(25) default NULL,
  `preparation_date` date default NULL,
  `runtype_adapter` varchar(25) default NULL,
  `project` varchar(50) default NULL,
  `pool_id` mediumint(9) default NULL,
  `oligo_pool` varchar(8) default NULL,
  `alignment_ref_id` int(11) default NULL,
  `alignment_ref` varchar(50) default NULL,
  `trim_bases` smallint(6) default NULL,
  `sample_conc` decimal(15,9) default NULL,
  `sample_conc_uom` varchar(10) default NULL,
  `lib_conc_requested` decimal(15,9) default NULL,
  `lib_conc_uom` varchar(10) default NULL,
  `notebook_ref` varchar(50) default NULL,
  `notes` varchar(255) default NULL,
  `quantitation_method` varchar(20) default NULL,
  `starting_amt_ng` decimal(11,3) default NULL,
  `pcr_size` smallint(6) default NULL,
  `dilution` decimal(6,3) default NULL,
  `updated_by` smallint(6) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 657408 kB; InnoDB free: 1434624 kB; (`processed';

CREATE TABLE `seq_machines` (
  `id` int(11) NOT NULL auto_increment,
  `machine_name` varchar(20) NOT NULL,
  `bldg_location` varchar(12) default NULL,
  `machine_type` varchar(20) default NULL,
  `machine_desc` varchar(50) default NULL,
  `last_seq_num` smallint(6) default NULL,
  `notes` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

CREATE TABLE `storage_devices` (
  `id` int(11) NOT NULL auto_increment,
  `device_name` varchar(25) NOT NULL,
  `building_loc` varchar(25) default NULL,
  `base_run_dir` varchar(50) default NULL,
  `last_upd_of_runs` date default NULL,
  `updated_by` smallint(6) default NULL,
  `updated_at` timestamp NULL default NULL on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

CREATE TABLE `storage_locations` (
  `id` int(11) NOT NULL auto_increment,
  `room_nr` varchar(25) NOT NULL,
  `freezer_nr` varchar(25) default NULL,
  `owner_name` varchar(25) default NULL,
  `owner_email` varchar(50) default NULL,
  `comments` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

CREATE TABLE `user_logins` (
  `id` int(11) NOT NULL auto_increment,
  `ip_address` varchar(20) NOT NULL,
  `user_id` smallint(6) default NULL,
  `user_login` char(25) NOT NULL,
  `login_timestamp` datetime default NULL,
  `logout_timestamp` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;

CREATE TABLE `user_logs` (
  `id` int(11) NOT NULL auto_increment,
  `ip_address` varchar(20) default NULL,
  `user_id` smallint(6) default NULL,
  `user_login` char(25) NOT NULL,
  `controller_name` varchar(25) NOT NULL,
  `action_name` varchar(25) NOT NULL,
  `log_timestamp` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1756 DEFAULT CHARSET=latin1;

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(25) default NULL,
  `email` varchar(255) default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `reset_code` varchar(50) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `remember_token` varchar(255) default NULL,
  `remember_token_expires_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

