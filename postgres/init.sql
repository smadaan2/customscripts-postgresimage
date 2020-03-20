CREATE USER postgres;
CREATE DATABASE postgres;
GRANT ALL PRIVILEGES ON DATABASE postgres TO postgres;
\connect postgres 

CREATE TABLE product_store.pm_ptflio_clstr (	ptflio_clstr_mstr_key uuid NOT NULL,	row_seq int4 NOT NULL DEFAULT 1,	ptflio_clstr_nm varchar(300) NOT NULL,	ptflio_clstr_desc varchar(500) NULL,	mstr_stat_cd varchar(8) NOT NULL,	chng_usr varchar(50) NOT NULL DEFAULT CURRENT_USER,	chng_dttm timestamp NOT NULL DEFAULT now(),	chng_rmrk text NOT NULL DEFAULT 'Created on '::text || to_char(CURRENT_TIMESTAMP, 'YYY-MM-DD HH12:MI:SS'::text),	CONSTRAINT pm_ptflio_clstr_pkey PRIMARY KEY (ptflio_clstr_mstr_key));

ALTER TABLE product_store.pm_ptflio_clstr ADD CONSTRAINT pm_ptflio_clstr_mstr_stat_cd_fkey FOREIGN KEY (mstr_stat_cd) REFERENCES product_store.pm_mstr_stat(mstr_stat_cd);

INSERT INTO product_store.pm_ptflio_clstr (ptflio_clstr_mstr_key,row_seq,ptflio_clstr_nm,ptflio_clstr_desc,mstr_stat_cd,chng_usr,chng_dttm,chng_rmrk) VALUES 
('d03ead5d-952a-46a5-97db-bcb623fa8000',1,'Access & Connectivity',NULL,'ACT','postgres','2019-11-26 10:10:28.515','Created on 019-11-26 10:10:28')
,('5449f8e0-f979-45a0-9695-a65ccf62aa40',1,'Cloud & Workspace',NULL,'ACT','postgres','2019-11-26 10:10:28.515','Created on 019-11-26 10:10:28')
,('38a2576f-0472-4d17-8c85-9a70122bee4b',1,'Security & Business Continuity',NULL,'ACT','postgres','2019-11-26 10:10:28.515','Created on 019-11-26 10:10:28')
,('78d39e72-6e9e-4960-a5ae-e254d66a4614',1,'Consulting & Service Management',NULL,'ACT','postgres','2019-11-26 10:10:28.515','Created on 019-11-26 10:10:28')
,('dc3016cb-3419-4c7b-b8cc-f16d170f6440',1,'Hardware & Software',NULL,'ACT','postgres','2019-11-26 10:10:28.515','Created on 019-11-26 10:10:28')
;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE pm_atmc_prd_offr
( 
	atmc_prd_offr_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	ptflio_bld_blck_mstr_key UUID  NULL   DEFAULT  uuid_generate_v4(),
	lcm_phase_cd         varchar(8)  NOT NULL ,
	prd_spec_mstr_key    UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	lcm_phase_start_dttm timestamp  NULL ,
	lcm_phase_end_dttm   timestamp  NULL ,
	atmc_prd_offr_type_ind char(1)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_atmc_prd_offr
	ADD  PRIMARY KEY (atmc_prd_offr_mstr_key);

CREATE TABLE pm_atmc_prd_offr_hist
( 
	atmc_prd_offr_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	ptflio_bld_blck_mstr_key char(18)  NOT NULL   DEFAULT  uuid_generate_v4(),
	lcm_phase_cd         char(18)  NOT NULL ,
	lcm_phase_start_dttm timestamp  NULL ,
	lcm_phase_end_dttm   timestamp  NULL ,
	atmc_prd_offr_type_ind char(1)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_atmc_prd_offr_hist
	ADD  PRIMARY KEY (atmc_prd_offr_mstr_key,row_seq);

CREATE TABLE pm_atmc_prd_offr_rel
( 
	prmry_prd_offr_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	suppl_prd_offr_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	mstr_stat_cd         varchar(8)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_atmc_prd_offr_rel
	ADD  PRIMARY KEY (prmry_prd_offr_mstr_key,suppl_prd_offr_mstr_key);

CREATE TABLE pm_atmc_prd_offr_rel_hist
( 
	prmry_prd_offr_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	suppl_prd_offr_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	mstr_stat_cd         varchar(8)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_atmc_prd_offr_rel_hist
	ADD  PRIMARY KEY (prmry_prd_offr_mstr_key,suppl_prd_offr_mstr_key,row_seq);

CREATE TABLE pm_atmc_prd_spec
( 
	atmc_prd_spec_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4()
);

ALTER TABLE pm_atmc_prd_spec
	ADD  PRIMARY KEY (atmc_prd_spec_mstr_key);

CREATE TABLE pm_cmp_prd_spec
( 
	cmp_prd_spec_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4()
);

ALTER TABLE pm_cmp_prd_spec
	ADD  PRIMARY KEY (cmp_prd_spec_mstr_key);

CREATE TABLE pm_cmp_prd_spec_atmc_prd_spec
( 
	cmp_prd_spec_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	atmc_prd_spec_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4()
);

ALTER TABLE pm_cmp_prd_spec_atmc_prd_spec
	ADD  PRIMARY KEY (cmp_prd_spec_mstr_key,atmc_prd_spec_mstr_key);

CREATE TABLE pm_lcm_phase
( 
	lcm_phase_cd         varchar(8)  NOT NULL ,
	lcm_phase_nm         varchar(300)  NOT NULL ,
	lcm_phase_desc       varchar(500)  NULL ,
	lcm_act_ind          char(1)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_lcm_phase
	ADD  PRIMARY KEY (lcm_phase_cd);

CREATE TABLE pm_mstr_key_ldgr
( 
	mstr_obj_key         UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	mstr_obj_nm          varchar(300)  NOT NULL ,
	mstr_obj_desc        varchar(500)  NULL ,
	mstr_obj_type        varchar(1000)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_mstr_key_ldgr
	ADD  PRIMARY KEY (mstr_obj_key);

CREATE TABLE pm_mstr_stat
( 
	mstr_stat_cd         varchar(8)  NOT NULL ,
	mstr_stat_nm         varchar(300)  NOT NULL ,
	mstr_stat_desc       varchar(500)  NULL ,
	mstr_stat_act_ind    char(1)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_mstr_stat
	ADD  PRIMARY KEY (mstr_stat_cd);

CREATE TABLE pm_offr_idstry
( 
	offr_idstry_cd       varchar(8)  NOT NULL ,
	offr_idstry_nm       varchar(300)  NOT NULL ,
	offr_idstry_desc     varchar(500)  NULL ,
	offr_idstry_act_ind  char(1)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_offr_idstry
	ADD  PRIMARY KEY (offr_idstry_cd);

CREATE TABLE pm_offr_mrkt_sgmt
( 
	offr_mrkt_sgmt_cd    varchar(8)  NOT NULL ,
	offr_mrkt_sgmt_nm    varchar(300)  NOT NULL ,
	offr_mrkt_sgmt_desc  varchar(500)  NULL ,
	offr_mrkt_sgmt_act_ind char(1)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_offr_mrkt_sgmt
	ADD  PRIMARY KEY (offr_mrkt_sgmt_cd);

CREATE TABLE pm_prd_config
( 
	prd_config_mstr_key  UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	atmc_prd_spec_mstr_key UUID  NULL   DEFAULT  uuid_generate_v4(),
	prd_config_char_nm   varchar(300)  NOT NULL ,
	prod_config_char_val varchar(1000)  NULL ,
	mstr_stat_cd         varchar(8)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_prd_config
	ADD  PRIMARY KEY (prd_config_mstr_key);

CREATE TABLE pm_prd_config_hist
( 
	prd_config_mstr_key  UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	atmc_prd_spec_mstr_key char(18)  NOT NULL   DEFAULT  uuid_generate_v4(),
	prd_config_char_nm   varchar(300)  NOT NULL ,
	prod_config_char_val varchar(1000)  NULL ,
	mstr_stat_cd         varchar(8)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_prd_config_hist
	ADD  PRIMARY KEY (prd_config_mstr_key,row_seq);

CREATE TABLE pm_prd_offr
( 
	prd_offr_mstr_key    UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	prd_offr_nm          varchar(300)  NOT NULL ,
	trgt_ptflio_ind      char(1)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_prd_offr
	ADD  PRIMARY KEY (prd_offr_mstr_key);

CREATE TABLE pm_prd_offr_hist
( 
	prd_offr_mstr_key    UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	prd_offr_nm          varchar(300)  NOT NULL ,
	trgt_ptflio_ind      char(1)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_prd_offr_hist
	ADD  PRIMARY KEY (prd_offr_mstr_key,row_seq);

CREATE TABLE pm_prd_offr_idstry
( 
	prd_offr_mstr_key    UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	offr_idstry_cd       varchar(8)  NOT NULL 
);

ALTER TABLE pm_prd_offr_idstry
	ADD  PRIMARY KEY (prd_offr_mstr_key,offr_idstry_cd);

CREATE TABLE pm_prd_offr_price
( 
	prd_offr_price_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	prd_offr_mstr_key    UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	price_cond_mstr_key  UUID  NULL   DEFAULT  uuid_generate_v4(),
	mstr_stat_cd         varchar(8)  NOT NULL ,
	price_unit_cd        varchar(8)  NOT NULL ,
	price_type_cd        varchar(8)  NOT NULL ,
	price_curr_cd        varchar(8)  NOT NULL ,
	prd_offr_price       decimal(18,4)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_prd_offr_price
	ADD  PRIMARY KEY (prd_offr_price_mstr_key,prd_offr_mstr_key);

CREATE TABLE pm_prd_offr_price_hist
( 
	prd_offr_price_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	prd_offr_mstr_key    UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	price_cond_mstr_key  char(18)  NOT NULL   DEFAULT  uuid_generate_v4(),
	mstr_stat_cd         varchar(8)  NOT NULL ,
	price_unit_cd        char(18)  NOT NULL ,
	price_type_cd        char(18)  NOT NULL ,
	price_curr_cd        char(18)  NULL ,
	prd_offr_price       decimal(18,4)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_prd_offr_price_hist
	ADD  PRIMARY KEY (prd_offr_price_mstr_key,prd_offr_mstr_key,row_seq);

CREATE TABLE pm_prd_offr_sgmt
( 
	prd_offr_mstr_key    UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	offr_mrkt_sgmt_cd    varchar(8)  NOT NULL 
);

ALTER TABLE pm_prd_offr_sgmt
	ADD  PRIMARY KEY (prd_offr_mstr_key,offr_mrkt_sgmt_cd);

CREATE TABLE pm_prd_spec
( 
	prd_spec_mstr_key    UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	prd_spec_nm          varchar(300)  NOT NULL ,
	mstr_stat_cd         varchar(8)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_prd_spec
	ADD  PRIMARY KEY (prd_spec_mstr_key);

CREATE TABLE pm_prd_spec_hist
( 
	prd_spec_mstr_key    UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	prd_spec_nm          varchar(300)  NOT NULL ,
	mstr_stat_cd         varchar(8)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_prd_spec_hist
	ADD  PRIMARY KEY (prd_spec_mstr_key,row_seq);

CREATE TABLE pm_price_cond
( 
	price_cond_mstr_key  UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	price_cond_mstr_obj_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	price_cond_rel_mstr_obj_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	price_cond_type_cd   varchar(8)  NOT NULL ,
	mstr_stat_cd         varchar(8)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_price_cond
	ADD  PRIMARY KEY (price_cond_mstr_key);

CREATE TABLE pm_price_cond_hist
( 
	price_cond_mstr_key  UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	price_cond_mstr_obj_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	price_cond_rel_mstr_obj_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	price_cond_type_cd   char(18)  NOT NULL ,
	mstr_stat_cd         varchar(8)  NOT NULL ,
	chng_usr             text  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            date  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_price_cond_hist
	ADD  PRIMARY KEY (price_cond_mstr_key,row_seq);

CREATE TABLE pm_price_cond_type
( 
	price_cond_type_cd   varchar(8)  NOT NULL ,
	price_cond_type_nm   varchar(300)  NOT NULL ,
	price_cond_type_desc varchar(500)  NULL ,
	price_cond_type_act_ind char(1)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_price_cond_type
	ADD  PRIMARY KEY (price_cond_type_cd);

CREATE TABLE pm_price_curr
( 
	price_curr_cd        varchar(8)  NOT NULL ,
	price_curr_nm        varchar(300)  NOT NULL ,
	price_curr_desc      varchar(500)  NULL ,
	price_curr_act_ind   char(1)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_price_curr
	ADD  PRIMARY KEY (price_curr_cd);

CREATE TABLE pm_price_type
( 
	price_type_cd        varchar(8)  NOT NULL ,
	price_type_nm        varchar(300)  NOT NULL ,
	price_type_desc      varchar(500)  NULL ,
	price_type_act_ind   char(1)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_price_type
	ADD  PRIMARY KEY (price_type_cd);

CREATE TABLE pm_price_unit
( 
	price_unit_cd        varchar(8)  NOT NULL ,
	price_unit_nm        varchar(300)  NOT NULL ,
	price_unit_desc      varchar(500)  NULL ,
	price_unit_act_ind   char(1)  NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW()
);

ALTER TABLE pm_price_unit
	ADD  PRIMARY KEY (price_unit_cd);

CREATE TABLE pm_ptflio_bld_blck
( 
	ptflio_bld_blck_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	ptflio_bld_blck_nm   varchar(300)  NOT NULL ,
	ptflio_bld_blck_desc varchar(500)  NULL ,
	ptflio_bld_blck_grp_mstr_key UUID  NOT NULL ,
	mstr_stat_cd         varchar(8)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW(),
	chng_rmrk            text  NOT NULL   DEFAULT  'Created on '||to_char(current_timestamp, 'YYY-MM-DD HH12:MI:SS')
);

ALTER TABLE pm_ptflio_bld_blck
	ADD  PRIMARY KEY (ptflio_bld_blck_mstr_key);

CREATE TABLE pm_ptflio_bld_blck_grp
( 
	ptflio_bld_blck_grp_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	ptflio_bld_blck_grp_nm varchar(300)  NOT NULL ,
	ptflio_bld_blck_grp_desc varchar(500)  NULL ,
	ptflio_clstr_mstr_key UUID  NOT NULL ,
	mstr_stat_cd         varchar(8)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW(),
	chng_rmrk            text  NOT NULL   DEFAULT  'Created on '||to_char(current_timestamp, 'YYY-MM-DD HH12:MI:SS')
);

ALTER TABLE pm_ptflio_bld_blck_grp
	ADD  PRIMARY KEY (ptflio_bld_blck_grp_mstr_key);

CREATE TABLE pm_ptflio_bld_blck_grp_hist
( 
	ptflio_bld_blck_grp_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	ptflio_bld_blck_grp_nm varchar(300)  NOT NULL ,
	ptflio_bld_blck_grp_desc varchar(500)  NULL ,
	ptflio_clstr_key     char(18)  NOT NULL   DEFAULT  uuid_generate_v4(),
	mstr_stat_cd         char(18)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NULL ,
	chng_rmrk            text  NULL 
);

ALTER TABLE pm_ptflio_bld_blck_grp_hist
	ADD  PRIMARY KEY (ptflio_bld_blck_grp_mstr_key,row_seq);

CREATE TABLE pm_ptflio_bld_blck_hist
( 
	ptflio_bld_blck_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	ptflio_bld_blck_nm   varchar(300)  NOT NULL ,
	ptflio_bld_blck_desc varchar(500)  NULL ,
	ptflio_bld_blck_grp_mstr_key char(18)  NOT NULL   DEFAULT  uuid_generate_v4(),
	mstr_stat_cd         char(18)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW(),
	chng_rmrk            text  NULL 
);

ALTER TABLE pm_ptflio_bld_blck_hist
	ADD  PRIMARY KEY (ptflio_bld_blck_mstr_key,row_seq);

CREATE TABLE pm_ptflio_clstr
( 
	ptflio_clstr_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	ptflio_clstr_nm      varchar(300)  NOT NULL ,
	ptflio_clstr_desc    varchar(500)  NULL ,
	mstr_stat_cd         varchar(8)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW(),
	chng_rmrk            text  NOT NULL   DEFAULT  'Created on '||to_char(current_timestamp, 'YYY-MM-DD HH12:MI:SS')
);

ALTER TABLE pm_ptflio_clstr
	ADD  PRIMARY KEY (ptflio_clstr_mstr_key);

CREATE TABLE pm_ptflio_clstr_hist
( 
	ptflio_clstr_mstr_key UUID  NOT NULL   DEFAULT  uuid_generate_v4(),
	row_seq              integer  NOT NULL   DEFAULT  1,
	ptflio_clstr_nm      varchar(300)  NOT NULL ,
	ptflio_clstr_desc    varchar(500)  NULL ,
	mstr_stat_cd         char(18)  NOT NULL ,
	chng_usr             varchar(50)  NOT NULL   DEFAULT  CURRENT_USER,
	chng_dttm            timestamp  NOT NULL   DEFAULT  NOW(),
	chng_rmrk            text  NOT NULL 
);

ALTER TABLE pm_ptflio_clstr_hist
	ADD  PRIMARY KEY (ptflio_clstr_mstr_key,row_seq);


ALTER TABLE pm_atmc_prd_offr
	ADD  FOREIGN KEY (atmc_prd_offr_mstr_key) REFERENCES pm_prd_offr(prd_offr_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_atmc_prd_offr
	ADD  FOREIGN KEY (ptflio_bld_blck_mstr_key) REFERENCES pm_ptflio_bld_blck(ptflio_bld_blck_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_atmc_prd_offr
	ADD  FOREIGN KEY (lcm_phase_cd) REFERENCES pm_lcm_phase(lcm_phase_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_atmc_prd_offr
	ADD  FOREIGN KEY (prd_spec_mstr_key) REFERENCES pm_prd_spec(prd_spec_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_atmc_prd_offr_hist
	ADD  FOREIGN KEY (atmc_prd_offr_mstr_key) REFERENCES pm_atmc_prd_offr(atmc_prd_offr_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_atmc_prd_offr_rel
	ADD  FOREIGN KEY (prmry_prd_offr_mstr_key) REFERENCES pm_atmc_prd_offr(atmc_prd_offr_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_atmc_prd_offr_rel
	ADD  FOREIGN KEY (suppl_prd_offr_mstr_key) REFERENCES pm_atmc_prd_offr(atmc_prd_offr_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_atmc_prd_offr_rel
	ADD  FOREIGN KEY (mstr_stat_cd) REFERENCES pm_mstr_stat(mstr_stat_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_atmc_prd_offr_rel_hist
	ADD  FOREIGN KEY (prmry_prd_offr_mstr_key,suppl_prd_offr_mstr_key) REFERENCES pm_atmc_prd_offr_rel(prmry_prd_offr_mstr_key,suppl_prd_offr_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_atmc_prd_spec
	ADD  FOREIGN KEY (atmc_prd_spec_mstr_key) REFERENCES pm_prd_spec(prd_spec_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_cmp_prd_spec
	ADD  FOREIGN KEY (cmp_prd_spec_mstr_key) REFERENCES pm_prd_spec(prd_spec_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_cmp_prd_spec_atmc_prd_spec
	ADD  FOREIGN KEY (cmp_prd_spec_mstr_key) REFERENCES pm_cmp_prd_spec(cmp_prd_spec_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_cmp_prd_spec_atmc_prd_spec
	ADD  FOREIGN KEY (atmc_prd_spec_mstr_key) REFERENCES pm_atmc_prd_spec(atmc_prd_spec_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_prd_config
	ADD  FOREIGN KEY (mstr_stat_cd) REFERENCES pm_mstr_stat(mstr_stat_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_prd_config
	ADD  FOREIGN KEY (atmc_prd_spec_mstr_key) REFERENCES pm_atmc_prd_spec(atmc_prd_spec_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_prd_config_hist
	ADD  FOREIGN KEY (prd_config_mstr_key) REFERENCES pm_prd_config(prd_config_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_prd_offr_hist
	ADD  FOREIGN KEY (prd_offr_mstr_key) REFERENCES pm_prd_offr(prd_offr_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_prd_offr_idstry
	ADD  FOREIGN KEY (prd_offr_mstr_key) REFERENCES pm_prd_offr(prd_offr_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_prd_offr_idstry
	ADD  FOREIGN KEY (offr_idstry_cd) REFERENCES pm_offr_idstry(offr_idstry_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_prd_offr_price
	ADD  FOREIGN KEY (prd_offr_mstr_key) REFERENCES pm_prd_offr(prd_offr_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_prd_offr_price
	ADD  FOREIGN KEY (price_cond_mstr_key) REFERENCES pm_price_cond(price_cond_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_prd_offr_price
	ADD  FOREIGN KEY (mstr_stat_cd) REFERENCES pm_mstr_stat(mstr_stat_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_prd_offr_price
	ADD  FOREIGN KEY (price_unit_cd) REFERENCES pm_price_unit(price_unit_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_prd_offr_price
	ADD  FOREIGN KEY (price_type_cd) REFERENCES pm_price_type(price_type_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_prd_offr_price
	ADD  FOREIGN KEY (price_curr_cd) REFERENCES pm_price_curr(price_curr_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_prd_offr_price_hist
	ADD  FOREIGN KEY (prd_offr_price_mstr_key,prd_offr_mstr_key) REFERENCES pm_prd_offr_price(prd_offr_price_mstr_key,prd_offr_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_prd_offr_sgmt
	ADD  FOREIGN KEY (prd_offr_mstr_key) REFERENCES pm_prd_offr(prd_offr_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_prd_offr_sgmt
	ADD  FOREIGN KEY (offr_mrkt_sgmt_cd) REFERENCES pm_offr_mrkt_sgmt(offr_mrkt_sgmt_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_prd_spec
	ADD  FOREIGN KEY (mstr_stat_cd) REFERENCES pm_mstr_stat(mstr_stat_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_prd_spec_hist
	ADD  FOREIGN KEY (prd_spec_mstr_key) REFERENCES pm_prd_spec(prd_spec_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_price_cond
	ADD  FOREIGN KEY (price_cond_type_cd) REFERENCES pm_price_cond_type(price_cond_type_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_price_cond
	ADD  FOREIGN KEY (mstr_stat_cd) REFERENCES pm_mstr_stat(mstr_stat_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_price_cond_hist
	ADD  FOREIGN KEY (price_cond_mstr_key) REFERENCES pm_price_cond(price_cond_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_ptflio_bld_blck
	ADD  FOREIGN KEY (ptflio_bld_blck_grp_mstr_key) REFERENCES pm_ptflio_bld_blck_grp(ptflio_bld_blck_grp_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_ptflio_bld_blck
	ADD  FOREIGN KEY (mstr_stat_cd) REFERENCES pm_mstr_stat(mstr_stat_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_ptflio_bld_blck_grp
	ADD  FOREIGN KEY (mstr_stat_cd) REFERENCES pm_mstr_stat(mstr_stat_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;

ALTER TABLE pm_ptflio_bld_blck_grp
	ADD  FOREIGN KEY (ptflio_clstr_mstr_key) REFERENCES pm_ptflio_clstr(ptflio_clstr_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_ptflio_bld_blck_grp_hist
	ADD  FOREIGN KEY (ptflio_bld_blck_grp_mstr_key) REFERENCES pm_ptflio_bld_blck_grp(ptflio_bld_blck_grp_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_ptflio_bld_blck_hist
	ADD  FOREIGN KEY (ptflio_bld_blck_mstr_key) REFERENCES pm_ptflio_bld_blck(ptflio_bld_blck_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_ptflio_clstr
	ADD  FOREIGN KEY (mstr_stat_cd) REFERENCES pm_mstr_stat(mstr_stat_cd)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;


ALTER TABLE pm_ptflio_clstr_hist
	ADD  FOREIGN KEY (ptflio_clstr_mstr_key) REFERENCES pm_ptflio_clstr(ptflio_clstr_mstr_key)
		ON UPDATE NO ACTION
		ON DELETE NO ACTION;