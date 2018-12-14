--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

CREATE ROLE _developer WITH
  NOLOGIN
  SUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  REPLICATION
  VALID UNTIL 'infinity';
  
CREATE ROLE regular WITH
  NOLOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  VALID UNTIL 'infinity';
  
CREATE USER console WITH
  LOGIN
  PASSWORD 'md51a0b932931d4e29d39fbde415fc46d6d'
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  VALID UNTIL 'infinity';

GRANT _developer TO console;

--
-- Name: helloworld; Type: DATABASE; Schema: -; Owner: _developer
--

CREATE DATABASE helloworld WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE helloworld OWNER TO _developer;

\connect helloworld

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: infra; Type: SCHEMA; Schema: -; Owner: _developer
--

CREATE SCHEMA infra;


ALTER SCHEMA infra OWNER TO _developer;

--
-- Name: postgres_fdw; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgres_fdw WITH SCHEMA public;


--
-- Name: EXTENSION postgres_fdw; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgres_fdw IS 'foreign-data wrapper for remote PostgreSQL servers';


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: sysreferenceorg_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysreferenceorg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysreferenceorg_seq OWNER TO _developer;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: sysreferenceorg; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysreferenceorg (
    rfo_seq bigint DEFAULT nextval('infra.sysreferenceorg_seq'::regclass) NOT NULL,
    rfo_class character varying(15) NOT NULL,
    rfo_value character varying(15) NOT NULL,
    rfo_desc character varying(100) NOT NULL,
    rfo_order smallint,
    rfo_active smallint,
    rfo_char text,
    rfo_int bigint,
    rfo_number double precision,
    rfo_date date,
    rfo_bin bytea,
    rfo_time time without time zone,
    rfo_effective date,
    rfo_expires date,
    rfo_json jsonb,
    rfo_go_ref bigint NOT NULL,
    rfo_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfo_cby character varying(15) NOT NULL,
    rfo_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfo_mby character varying(15) NOT NULL,
    rfo_mcount integer DEFAULT 0 NOT NULL,
    rfo_inherit smallint DEFAULT 0 NOT NULL,
    rfo_unique character varying(50) NOT NULL
);


ALTER TABLE infra.sysreferenceorg OWNER TO _developer;

--
-- Name: COLUMN sysreferenceorg.rfo_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_seq IS 'primary key';


--
-- Name: COLUMN sysreferenceorg.rfo_class; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_class IS 'classification column';


--
-- Name: COLUMN sysreferenceorg.rfo_value; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_value IS 'specific reference value';


--
-- Name: COLUMN sysreferenceorg.rfo_desc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_desc IS 'description';


--
-- Name: COLUMN sysreferenceorg.rfo_order; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_order IS 'ordering column';


--
-- Name: COLUMN sysreferenceorg.rfo_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_active IS '1 means an active lookup/reference entry';


--
-- Name: COLUMN sysreferenceorg.rfo_char; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_char IS 'big character column';


--
-- Name: COLUMN sysreferenceorg.rfo_int; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_int IS 'integer value';


--
-- Name: COLUMN sysreferenceorg.rfo_number; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_number IS 'floating number value';


--
-- Name: COLUMN sysreferenceorg.rfo_date; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_date IS 'date column';


--
-- Name: COLUMN sysreferenceorg.rfo_bin; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_bin IS 'binary value';


--
-- Name: initinherited(text, text, integer); Type: FUNCTION; Schema: infra; Owner: _developer
--

CREATE FUNCTION infra.initinherited(pclass text, pvalue text DEFAULT ''::text, pgoref integer DEFAULT 0) RETURNS SETOF infra.sysreferenceorg
    LANGUAGE plpgsql
    AS $_$
/*******************************************************************************************
Purpose:    to offer the functionality of Omnis oValues.$initInherited returning one row
Created:    2016-08-31 Graham Stevens
Revisions:  2017-06-08 GRS reworked to return a full set of records for pClass when pValue is empty
            2018-01-29 GRS bug fix: added rfo_active to the order by clause 
                                    added check for pValue is null
            2018-02-08 GRS added to include/exclude records according to rfo/rfl_inherit
            2018-08-16 GRS reverted the rfo_inherit change above
			2018-08-17 GRS properly (I hpoe) incorporated xxx_inherit
			2018-08-20 GRS fixed: rows were missing when rfo_active = 1 but rfg_active = 0 
*******************************************************************************************/
declare
    rfoRow  infra.sysreferenceorg%rowtype;
    
begin
    if pClass is null or pClass = '' then
        raise invalid_parameter_value using message = 'Class must have a value';
    end if;
    
    
    if pValue = '' or pValue is null then
    	for rfoRow in
			-- select all relevant columns from the result set
			-- for the first row only in each partition
			-- ignoring inactive records
			select rfo_seq, rfo_class, rfo_value, rfo_desc, rfo_order, rfo_active, rfo_char, rfo_int, rfo_number, rfo_date, rfo_bin, rfo_time, rfo_effective, rfo_expires, rfo_json
			from
			(
			-- partition the results by class and value ordering each partition by its _active value desc and priority
			-- and numbering each row
			select *, row_number()
			over (partition by rfo_class, rfo_value order by rfo_active, priority)
			from
			(
			-- fetch all matching rows from all tables incl. ACTIVE = 0
			-- priority is used to order the rows in the outer windowing clause
			with rfo as ( -- get all the relevant refOrg records
			select 1 as priority, rfo_seq, rfo_class, rfo_value, rfo_desc, rfo_order, rfo_active, rfo_char, rfo_int, rfo_number, rfo_date, rfo_bin, rfo_time, rfo_effective, rfo_expires, rfo_json
			from infra.sysreferenceorg rfo
			where rfo_class = pClass
			and rfo_go_ref = pgoref 
			and not (rfo_active= 0 and rfo_inherit = 1) -- inherit overrides the deactivation as though the record did not exist
			), 
			rfl as ( -- get the relevant refLocal records and override rfl_active if rfo_active = 1
			select 2, rfl_seq, rfl_class, rfl_value, rfl_desc, rfl_order
			, case when rfo_active = 1 then rfo_active else rfl_active end, rfl_char, rfl_int, rfl_number, rfl_date, rfl_bin, rfl_time, rfl_effective, rfl_expires, rfl_json
			from infra.sysreferencelocal
			left join rfo on rfo_value = rfl_value
			where rfl_class = pClass
			and not (rfl_active= 0 and rfl_inherit = 1) -- inherit overrides the deactivation as though the record did not exist
			), 
			rfg as ( --get the relevant refGlobal records and override rfg_active if rfo_active = 1 or rfl_active = 1
			select 3 as priority, rfg_seq, rfg_class, rfg_value, rfg_desc, rfg_order
			, case when rfo_active = 1 then rfo_active when rfl_active = 1 then rfl_active else rfg_active end, rfg_char, rfg_int, rfg_number, rfg_date, rfg_bin, rfg_time, rfg_effective, rfg_expires, rfg_json
			from infra.sysreferenceglobal
			left join rfl on rfl_value = rfg_value
			left join rfo on rfo_value = rfg_value
			where rfg_class = pClass
			)
			-- put all of the above together
			select * from rfo union select * from rfl union select * from rfg
			) x 
			) y
			where row_number = 1 and rfo_active = 1
		
		loop
			return next rfoRow;
		end loop;
		
	else
		for rfoRow in
			-- select all relevant columns from the result set
			-- for the first row only in each partition
			-- ignoring inactive records
            select rfo_seq, rfo_class, rfo_value, rfo_desc, rfo_order, rfo_active, rfo_char, rfo_int, rfo_number, rfo_date, rfo_bin, rfo_time, rfo_effective, rfo_expires, rfo_json
			from
			(
			-- partition the results by class and value ordering each partition by its priority
			-- priority is used to order the rows in the outer windowing clause
			select *, row_number()
			over (partition by rfo_class, rfo_value order by rfo_active, priority)
			from
			(
			-- fetch all matching rows from all tables incl. ACTIVE = 0
			-- priority is used to order the rows in the outer windowing clause
			with rfo as ( -- get all the relevant refOrg records
			select 1 as priority, rfo_seq, rfo_class, rfo_value, rfo_desc, rfo_order, rfo_active, rfo_char, rfo_int, rfo_number, rfo_date, rfo_bin, rfo_time, rfo_effective, rfo_expires, rfo_json
			from infra.sysreferenceorg rfo
			where rfo_class = pClass and rfo_value = pValue
			and rfo_go_ref = pgoref 
			and not (rfo_active= 0 and rfo_inherit = 1) -- inherit overrides the deactivation as though the record did not exist
			), 
			rfl as ( -- get the relevant refLocal records and override rfl_active if rfo_active = 1
			select 2, rfl_seq, rfl_class, rfl_value, rfl_desc, rfl_order
			, case when rfo_active = 1 then rfo_active else rfl_active end, rfl_char, rfl_int, rfl_number, rfl_date, rfl_bin, rfl_time, rfl_effective, rfl_expires, rfl_json
			from infra.sysreferencelocal
			left join rfo on rfo_value = rfl_value
			where rfl_class = pClass and rfl_value = pValue
			and not (rfl_active= 0 and rfl_inherit = 1) -- inherit overrides the deactivation as though the record did not exist
			), 
			rfg as ( --get the relevant refGlobal records and override rfg_active if rfo_active = 1 or rfl_active = 1
			select 3 as priority, rfg_seq, rfg_class, rfg_value, rfg_desc, rfg_order
			, case when rfo_active = 1 then rfo_active when rfl_active = 1 then rfl_active else rfg_active end, rfg_char, rfg_int, rfg_number, rfg_date, rfg_bin, rfg_time, rfg_effective, rfg_expires, rfg_json
			from infra.sysreferenceglobal
			left join rfl on rfl_value = rfg_value
			left join rfo on rfo_value = rfg_value
			where rfg_class = pClass and rfg_value = pValue
			)
			-- put all of the above together
			select * from rfo union select * from rfl union select * from rfg
			) x
			) y
			where row_number = 1 and rfo_active = 1

		loop
			return next rfoRow;
		end loop;
		
	end if;	
	
    return;
    
end;
$_$;


ALTER FUNCTION infra.initinherited(pclass text, pvalue text, pgoref integer) OWNER TO _developer;

--
-- Name: nextseqno(character, boolean); Type: FUNCTION; Schema: infra; Owner: _developer
--

CREATE FUNCTION infra.nextseqno(pclass character, pcommit boolean) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
/***********************************************************************************************
  Purpose: To get the next sequence number from syssesequenceomnis for a designated class,
           optionally committing the increase
  Created: 16/5/2014 Graham Stevens

  Revisions: 09/09/2014 GRS added schema name

***********************************************************************************************/
declare

    vnCount integer;
    vnNewSeq bigint;
    
BEGIN

    -- check for the existence of the class
    select count(*) into vnCount
    from conf.syssequencemulticompany
    where seq_class = pClass;

    if vncount = 0 then 
        if pCommit then -- create it
            insert into conf.syssequencemulticompany
            (seq_class, seq_number)
            values
            (pClass, 1)
            returning seq_number into vnNewSeq;

            return vnNewSeq;
        else -- just return 1 and let the record be created when needed
            return 1;
        end if;    
    elsif pCommit then -- increment and save
        update conf.syssequencemulticompany
        set seq_number = seq_number + 1
        where seq_class = pClass
        returning seq_number into vnNewSeq;

        return vnNewSeq;

    else -- just fetch the next number
        select seq_number + 1 into vnNewseq
        from conf.syssequencemulticompany
        where seq_class = pClass;
        
        return vnNewSeq;
    end if;

EXCEPTION
    when others then
        RAISE;

END;
$$;


ALTER FUNCTION infra.nextseqno(pclass character, pcommit boolean) OWNER TO _developer;

--
-- Name: null_to_zero(integer); Type: FUNCTION; Schema: infra; Owner: _developer
--

CREATE FUNCTION infra.null_to_zero(pvalue integer) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE
    AS $$
begin
    if pvalue is null then
        return 0;
    else
        return pValue;
    end if;
end;
$$;


ALTER FUNCTION infra.null_to_zero(pvalue integer) OWNER TO _developer;

--
-- Name: report_year(text, date, integer); Type: FUNCTION; Schema: infra; Owner: _developer
--

CREATE FUNCTION infra.report_year(pclass text, pdate date, pgoref integer DEFAULT 0) RETURNS integer
    LANGUAGE plpgsql
    AS $$

/***************************************************************************************************
Purpose:    return the reporting year (end) that pDate is in based on YEAR_END date/month (rfo_date)
Created:    2018-06-20 Graham Stevens
Revisions:  none
***************************************************************************************************/

declare
    yearEnd date;
    
begin
    if pClass is null or pClass = '' then
        raise invalid_parameter_value using message = 'Class must have a value';
    end if;
    
    if pDate is null then
        raise invalid_parameter_value using message = 'Date must have a value';
    end if;
    
    if pgoref is null then
        raise invalid_parameter_value using message = 'OrgSeq must have a value';
    end if;
    
    select rfo_date into yearend
    from infra.initinherited(pClass, 'YEAR_END', pGoRef);
    
    if yearend is null then
        return date_part('year', pDate);
    end if;
    
    --reset yearEnd to the pDate year for comparison with pDate
    yearend := (date_part('year', pDate) || '-' || date_part('month', yearend) || '-' || date_part('day', yearend))::date;
    
    if pDate > yearend then
        return date_part('year', yearend) + 1;
    
    else
        return date_part('year', yearend);
    
    end if;
    
EXCEPTION 
    when others then
        RAISE;
    
end;

$$;


ALTER FUNCTION infra.report_year(pclass text, pdate date, pgoref integer) OWNER TO _developer;

--
-- Name: rfg_before_ins_upd(); Type: FUNCTION; Schema: infra; Owner: _developer
--

CREATE FUNCTION infra.rfg_before_ins_upd() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    /*
    used before insert or update into sysreferenceglobal
    to populate the rfg_unique column
    */
    new.rfg_unique := concat(new.rfg_class, new.rfg_value, new.rfg_effective::text);

    return new;
end;
$$;


ALTER FUNCTION infra.rfg_before_ins_upd() OWNER TO _developer;

--
-- Name: rfl_before_ins_upd(); Type: FUNCTION; Schema: infra; Owner: _developer
--

CREATE FUNCTION infra.rfl_before_ins_upd() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    /*
    used before insert or update into sysreferencelocal
    to populate the rfl_unique column
    */
    new.rfl_unique := concat(new.rfl_class, new.rfl_value, new.rfl_effective::text);

    return new;
end;
$$;


ALTER FUNCTION infra.rfl_before_ins_upd() OWNER TO _developer;

--
-- Name: rfo_before_ins_upd(); Type: FUNCTION; Schema: infra; Owner: _developer
--

CREATE FUNCTION infra.rfo_before_ins_upd() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    /*
    used before insert or update into sysreferenceorg
    to populate the rfo_unique column
    */
    new.rfo_unique := concat(new.rfo_go_ref, ':', new.rfo_class, ':', new.rfo_value, ':', new.rfo_effective::text);

    return new;
end;
$$;


ALTER FUNCTION infra.rfo_before_ins_upd() OWNER TO _developer;

--
-- Name: rfu_before_ins_upd(); Type: FUNCTION; Schema: infra; Owner: _developer
--

CREATE FUNCTION infra.rfu_before_ins_upd() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    /*
    used before insert or update into sysreferenceuser
    to populate the rfu_unique column
    */
    new.rfu_unique := concat(new.rfu_go_ref, ':', new.rfu_usr_ref, ':', new.rfu_class, ':', new.rfu_value, ':', new.rfu_effective::text);

    return new;
end;
$$;


ALTER FUNCTION infra.rfu_before_ins_upd() OWNER TO _developer;

--
-- Name: checkproductsource(text, smallint, smallint, text); Type: FUNCTION; Schema: public; Owner: _developer
--

CREATE FUNCTION public.checkproductsource(pprodcode text, pstartchar smallint, pstringlength smallint, plabel text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN

    if substr(pProdcode, pstartchar, pstringlength) = plabel then
        return true;
    else
        return false;
    end if;
END;
$$;


ALTER FUNCTION public.checkproductsource(pprodcode text, pstartchar smallint, pstringlength smallint, plabel text) OWNER TO _developer;

--
-- Name: checkproductsource(text, smallint, text, text); Type: FUNCTION; Schema: public; Owner: _developer
--

CREATE FUNCTION public.checkproductsource(pprodcode text, ptokenno smallint, pdelimiter text, plabel text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    for x in 1 .. pTokenNo - 1 loop
        pProdcode := substr(pProdcode,position(pDelimiter in pProdcode) + length(pDelimiter),length(pProdcode));
    End loop;

    if position(pDelimiter in pProdcode) > 0 then 
        If substr(pProdcode,1,position(pDelimiter in pProdcode) - 1) = pLabel then
            RETURN true;
        else 
            RETURN false;
        end if;
    else
        If substr(pProdcode,1,length(pProdcode)) = pLabel then
            RETURN true;
        else 
            RETURN false;
        end if;
    end if;
END;
$$;


ALTER FUNCTION public.checkproductsource(pprodcode text, ptokenno smallint, pdelimiter text, plabel text) OWNER TO _developer;

--
-- Name: clone_processmodel(bigint, character); Type: FUNCTION; Schema: public; Owner: _developer
--

CREATE FUNCTION public.clone_processmodel(INOUT pnprmref bigint, pcuser character) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
/***************************************************************************************
Purpose: to copy a process model with all its steps and step child records
Created: 17/3/2014 Graham Stevens
To Do: EXCEPTION handling

Revisions:
01/05/2014 GRS fixed a bug where the proc was failing with inputs based on previous outputs
09/05/2014 GRS changed localtimestamp to date_trunc(localtimestamp), for Omnis column comparisons
02/06/2014 GRS changed column psi_ohh_ref to psi_ool_ref
16/09/2014 GRS added schema prefix to table names

***************************************************************************************/
DECLARE

    newprmref bigint;
    newpmsref bigint;

    all_steps cursor for select * from pmprocessmodelsteps
                        where pms_prm_ref = pnprmref
                        order by pms_order;
    child record;
    newvsn integer;
    newpsoref bigint;
   
BEGIN
    -- copy the model to a new record
    with currprm as (select prm_go_ref, prm_name
                     from pmprocessmodel
                     where prm_seq = pnprmref)
    select max(prm_vsn) + 1 into newvsn
    from pmprocessmodel prm, currprm
    where prm.prm_go_ref = currprm.prm_go_ref
      and prm.prm_name = currprm.prm_name;

    insert into pmprocessmodel
    ( prm_go_ref, prm_name, prm_desc, prm_vsn, prm_division
    , prm_plant, prm_busunit, prm_category, prm_costcentre, prm_project
    , prm_cwhen, prm_cby, prm_mwhen, prm_mby)
    select prm_go_ref, prm_name, prm_desc, newvsn, prm_division
    , prm_plant, prm_busunit, prm_category, prm_costcentre, prm_project
    , date_trunc('second', localtimestamp), pcuser, date_trunc('second', localtimestamp), pcuser
    from pmprocessmodel
    where prm_seq = pnprmref
    returning prm_seq into newprmref;

    if FOUND then
        null;  -- new record created successfully, move on
    else
        RAISE EXCEPTION no_data_found;
    end if;

    -- loop through all model steps
    for step in all_steps
    loop
	insert into pmprocessmodelsteps
	( pms_prm_ref, pms_order, pms_desc, pms_repeat
	, pms_cwhen, pms_cby, pms_mwhen, pms_mby)
	values
	( newprmref, step.pms_order, step.pms_desc, step.pms_repeat
	, date_trunc('second', localtimestamp), pcuser, date_trunc('second', localtimestamp), pcuser)
	returning pms_seq into newpmsref;

	if FOUND then
	    null;
	else
	    RAISE EXCEPTION no_data_found;
	end if; 

        -- loop through all inputs
	for child in select * from pmprocessstepinputs
                     where psi_pms_ref = step.pms_seq
	loop
            if child.psi_pso_ref > 0 then -- fetch the pk of the duplicated PSO record

                select  npso.pso_seq into newpsoref
                from pmprocessstepoutputs opso, pmprocessmodelsteps opms, pmprocessmodelsteps npms, pmprocessstepoutputs npso
                where opms.pms_seq = opso.pso_pms_ref
                and opso.pso_seq = child.psi_pso_ref
                and npms.pms_order = opms.pms_order
                and npms.pms_prm_ref = newprmref
                and npso.pso_order = opso.pso_order
                and npso.pso_pms_ref = npms.pms_seq;
            else
              newpsoref := child.psi_pso_ref;
            end if;

            insert into pmprocessstepinputs
            ( psi_pms_ref, psi_order, psi_pso_ref, psi_op_ref, psi_prd_ref
            , psi_ool_ref, psi_sh_ref, psi_from_nature, psi_set_tier1, psi_set_tier2
            , psi_set_tier3, psi_set_tier4, psi_qty, psi_desc
            , psi_cwhen, psi_cby, psi_mwhen, psi_mby)
            values
            ( newpmsref, child.psi_order, newpsoref, child.psi_op_ref, child.psi_prd_ref
            , child.psi_ool_ref, child.psi_sh_ref, child.psi_from_nature, child.psi_set_tier1, child.psi_set_tier2
            , child.psi_set_tier3, child.psi_set_tier4, child.psi_qty, child.psi_desc
            , date_trunc('second', localtimestamp), pcuser, date_trunc('second', localtimestamp), pcuser);
        end loop;
      
        -- loop through all outputs
        for child in select * from pmprocessstepoutputs
                     where pso_pms_ref = step.pms_seq
	loop
            insert into pmprocessstepoutputs
            ( pso_pms_ref, pso_order, pso_op_ref, pso_prd_ref, pso_sh_ref, pso_input_only
            , pso_set_tier1, pso_set_tier2, pso_set_tier3, pso_set_tier4, pso_qty, pso_desc
            , pso_cwhen, pso_cby, pso_mwhen, pso_mby)
            values
            ( newpmsref, child.pso_order, child.pso_op_ref, child.pso_prd_ref, child.pso_sh_ref, child.pso_input_only
            , child.pso_set_tier1, child.pso_set_tier2, child.pso_set_tier3, child.pso_set_tier4, child.pso_qty, child.pso_desc
            , date_trunc('second', localtimestamp), pcuser, date_trunc('second', localtimestamp), pcuser);
        end loop;

        -- loop through all reactions
        for child in select * from pmprocessstepreactions
                     where psr_pms_ref = step.pms_seq
	loop
            insert into pmprocessstepreactions
            ( psr_pms_ref, psr_order, psr_crh_ref, psr_desc
            , psr_cwhen, psr_cby, psr_mwhen, psr_mby)
            values
            ( newpmsref, child.psr_order, child.psr_crh_ref, child.psr_desc
            , date_trunc('second', localtimestamp), pcuser, date_trunc('second', localtimestamp), pcuser);
        end loop;
                
        -- loop through all calculations
        for child in select * from pmprocessstepcalcs
                     where psc_pms_ref = step.pms_seq
	loop
            insert into pmprocessstepcalcs
            ( psc_pms_ref, psc_order, psc_calc, psc_syntax, psc_desc
            , psc_cwhen, psc_cby, psc_mwhen, psc_mby)
            values
            ( newpmsref, child.psc_order, child.psc_calc, child.psc_syntax, child.psc_desc
            , date_trunc('second', localtimestamp), pcuser, date_trunc('second', localtimestamp), pcuser);
        end loop;
            
        -- loop through all descriptions
        for child in select * from pmprocessstepdescs
                     where psd_pms_ref = step.pms_seq
	loop
            insert into pmprocessstepdescs
            ( psd_pms_ref, psd_type, psd_iso_lang, psd_order, psd_comment
            , psd_cwhen, psd_cby, psd_mwhen, psd_mby)
            values
            ( newpmsref, child.psd_type, child.psd_iso_lang, child.psd_order, child.psd_comment
            , date_trunc('second', localtimestamp), pcuser, date_trunc('second', localtimestamp), pcuser);
        end loop;

    end loop;

    pnprmref := newprmref;
--EXCEPTION


end;
$$;


ALTER FUNCTION public.clone_processmodel(INOUT pnprmref bigint, pcuser character) OWNER TO _developer;

--
-- Name: clone_processmodel(bigint, character, boolean); Type: FUNCTION; Schema: public; Owner: _developer
--

CREATE FUNCTION public.clone_processmodel(INOUT pnprmref bigint, pcuser character, pbnewmodel boolean) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
/***************************************************************************************
Purpose: to call clone_processmodel(bigint,character) and either reset the name and version
         or link it to all products using the previous version
Created: 02/06/2014 Graham Stevens
To Do: EXCEPTION handling

Revisions: 19/06/14 GRS fixed date_trunc() changed 'day' to 'second'
           16/09/14 GRS addedd schema prefix 


***************************************************************************************/
DECLARE

    oldprmref bigint := pnprmref;
    newprmref bigint;

   
BEGIN
    
    -- copy the model to a new record
    select clone_processmodel(pnprmref, pcUser) into newprmref;

    if pbnewmodel then
        update pmprocessmodel
        set prm_name = 'Copy of ' || prm_name
          , prm_vsn = 1
        where prm_seq = newprmref;
    else
        insert into bushmi.pmproductprocess
        (pp_prm_ref, pp_prd_ref, pp_desc,
         pp_cwhen, pp_cby, pp_mwhen, pp_mby)
        select newprmref, pp_prd_ref, pp_desc,
               date_trunc('second',localtimestamp), pcuser, date_trunc('second',localtimestamp), pcuser
        from pmproductprocess
        where pp_prm_ref = oldprmref;

    end if;
       
    pnprmref := newprmref;
    
--EXCEPTION


end;
$$;


ALTER FUNCTION public.clone_processmodel(INOUT pnprmref bigint, pcuser character, pbnewmodel boolean) OWNER TO _developer;

--
-- Name: f_unaccent(text); Type: FUNCTION; Schema: public; Owner: _developer
--

CREATE FUNCTION public.f_unaccent(text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT public.unaccent('public.unaccent', $1)  -- schema-qualify function and dictionary
$_$;


ALTER FUNCTION public.f_unaccent(text) OWNER TO _developer;

--
-- Name: fix_sequences(); Type: FUNCTION; Schema: public; Owner: _developer
--

CREATE FUNCTION public.fix_sequences() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    all_tables cursor is select relname as parenttable, attname as pkcol
                         from pg_class, pg_attribute, pg_tables
                         where oid = attrelid
                         and tablename = relname
                         and tableowner = 'mec_developer'
                         and attname like '%\_seq' escape '\';
    dynSQL text;
    maxSeq integer;
BEGIN
    for each_table in all_tables
    loop
	dynSQL := 'select max(' || each_table.pkcol || ') from ' || each_table.parenttable;
	execute dynSQL into maxSeq;

	if maxSeq > 0 then
	    dynSQL := 'SELECT setval(''' || each_table.parenttable || '_seq'', ' || maxSeq ||', true)';
	    execute dynSQL;
	end if;
    end loop;
end;
$$;


ALTER FUNCTION public.fix_sequences() OWNER TO _developer;

--
-- Name: floor_time(timestamp without time zone, integer); Type: FUNCTION; Schema: public; Owner: _developer
--

CREATE FUNCTION public.floor_time(ptimestamp timestamp without time zone, pminutes integer DEFAULT 60) RETURNS timestamp without time zone
    LANGUAGE plpgsql
    AS $$
DECLARE

    newTimestamp timestamp;

BEGIN
    -- this function truncates timestamps according to pminutes
    -- 15 will clump into 15 minute bunches, 60 will produce hourly and so on
    if pminutes = 0 then
       pminutes := 60;
    end if;
       
    select cast ( concat(date(pTimestamp),' ',extract(hour from pTimestamp),':',extract (minute from pTimestamp)-mod(cast(extract (minute from pTimestamp) as integer),pMinutes)) as timestamp) into newTimestamp;
    return newTimestamp;

END;
$$;


ALTER FUNCTION public.floor_time(ptimestamp timestamp without time zone, pminutes integer) OWNER TO _developer;

--
-- Name: nextseqno(character, boolean); Type: FUNCTION; Schema: public; Owner: _developer
--

CREATE FUNCTION public.nextseqno(pclass character, pcommit boolean) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
/***********************************************************************************************
  Purpose: To get the next sequence number from syssesequenceomnis for a designated class,
           optionally committing the increase
  Created: 16/5/2014 Graham Stevens

  Revisions: 09/09/2014 GRS added schema name

***********************************************************************************************/
declare

    vnCount integer;
    vnNewSeq bigint;
    
BEGIN

    -- check for the existence of the class
    select count(*) into vnCount
    from conf.syssequencemulticompany
    where seq_class = pClass;

    if vncount = 0 then 
        if pCommit then -- create it
            insert into conf.syssequencemulticompany
            (seq_class, seq_number)
            values
            (pClass, 1)
            returning seq_number into vnNewSeq;

            return vnNewSeq;
        else -- just return 1 and let the record be created when needed
            return 1;
        end if;    
    elsif pCommit then -- increment and save
        update conf.syssequencemulticompany
        set seq_number = seq_number + 1
        where seq_class = pClass
        returning seq_number into vnNewSeq;

        return vnNewSeq;

    else -- just fetch the next number
        select seq_number + 1 into vnNewseq
        from conf.syssequencemulticompany
        where seq_class = pClass;
        
        return vnNewSeq;
    end if;

EXCEPTION
    when others then
        RAISE;

END;
$$;


ALTER FUNCTION public.nextseqno(pclass character, pcommit boolean) OWNER TO _developer;

--
-- Name: geodata; Type: SERVER; Schema: -; Owner: _developer
--

CREATE SERVER geodata FOREIGN DATA WRAPPER postgres_fdw OPTIONS (
    dbname 'geodata',
    host 'localhost',
    port '5436'
);


ALTER SERVER geodata OWNER TO _developer;

--
-- Name: USER MAPPING public SERVER geodata; Type: USER MAPPING; Schema: -; Owner: _developer
--

CREATE USER MAPPING FOR public SERVER geodata;


--
-- Name: accountingperiod_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.accountingperiod_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.accountingperiod_seq OWNER TO _developer;

--
-- Name: accountingperiod; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.accountingperiod (
    acp_seq bigint DEFAULT nextval('infra.accountingperiod_seq'::regclass) NOT NULL,
    acp_span smallint NOT NULL,
    acp_from date NOT NULL,
    acp_to date NOT NULL,
    acp_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    acp_cby character varying(15) NOT NULL,
    acp_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    acp_mby character varying(15) NOT NULL,
    acp_mcount integer DEFAULT 0 NOT NULL
);


ALTER TABLE infra.accountingperiod OWNER TO _developer;

--
-- Name: COLUMN accountingperiod.acp_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiod.acp_seq IS 'primary key';


--
-- Name: COLUMN accountingperiod.acp_span; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiod.acp_span IS 'period length defined as parts of a year, ie. 1=year, 4=quarter, 12=month';


--
-- Name: COLUMN accountingperiod.acp_from; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiod.acp_from IS 'start date of accounting period';


--
-- Name: COLUMN accountingperiod.acp_to; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiod.acp_to IS 'end date of accounting period';


--
-- Name: COLUMN accountingperiod.acp_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiod.acp_cwhen IS 'creation timestamp';


--
-- Name: COLUMN accountingperiod.acp_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiod.acp_cby IS 'created by';


--
-- Name: COLUMN accountingperiod.acp_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiod.acp_mwhen IS 'modification timestamp';


--
-- Name: COLUMN accountingperiod.acp_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiod.acp_mby IS 'modified by';


--
-- Name: accountingperiodlinks_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.accountingperiodlinks_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.accountingperiodlinks_seq OWNER TO _developer;

--
-- Name: accountingperiodlinks; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.accountingperiodlinks (
    acl_seq bigint DEFAULT nextval('infra.accountingperiodlinks_seq'::regclass) NOT NULL,
    acl_acp_ref bigint NOT NULL,
    acl_go_ref bigint NOT NULL,
    acl_fc_adjust numeric(15,2) NOT NULL,
    acl_comment character varying(255),
    acl_closed smallint,
    acl_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    acl_cby character varying(15) NOT NULL,
    acl_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    acl_mby character varying(15) NOT NULL,
    acl_mcount integer DEFAULT 0 NOT NULL
);


ALTER TABLE infra.accountingperiodlinks OWNER TO _developer;

--
-- Name: COLUMN accountingperiodlinks.acl_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiodlinks.acl_seq IS 'primary key';


--
-- Name: COLUMN accountingperiodlinks.acl_acp_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiodlinks.acl_acp_ref IS 'foreign key to accountingperiod';


--
-- Name: COLUMN accountingperiodlinks.acl_go_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiodlinks.acl_go_ref IS 'foreign key to entgrouporganisations';


--
-- Name: COLUMN accountingperiodlinks.acl_fc_adjust; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiodlinks.acl_fc_adjust IS 'forecast adjustment multiplier, eg. to account for seasonal differences';


--
-- Name: COLUMN accountingperiodlinks.acl_comment; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiodlinks.acl_comment IS 'reason for period adjustment';


--
-- Name: COLUMN accountingperiodlinks.acl_closed; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiodlinks.acl_closed IS 'flag to indicate period is closed for posting';


--
-- Name: COLUMN accountingperiodlinks.acl_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiodlinks.acl_cwhen IS 'creation timestamp';


--
-- Name: COLUMN accountingperiodlinks.acl_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiodlinks.acl_cby IS 'created by';


--
-- Name: COLUMN accountingperiodlinks.acl_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiodlinks.acl_mwhen IS 'modification timestamp';


--
-- Name: COLUMN accountingperiodlinks.acl_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.accountingperiodlinks.acl_mby IS 'modified by';


--
-- Name: autosave_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.autosave_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.autosave_seq OWNER TO _developer;

--
-- Name: autosave; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.autosave (
    as_seq bigint DEFAULT nextval('infra.autosave_seq'::regclass) NOT NULL,
    as_table_prefix character varying(5) NOT NULL,
    as_pk bigint NOT NULL,
    as_binary bytea NOT NULL,
    as_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    as_cby character varying(15) NOT NULL,
    as_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    as_mby character varying(15) NOT NULL,
    as_mcount integer DEFAULT 0 NOT NULL
);


ALTER TABLE infra.autosave OWNER TO _developer;

--
-- Name: COLUMN autosave.as_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.autosave.as_seq IS 'primary key';


--
-- Name: COLUMN autosave.as_table_prefix; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.autosave.as_table_prefix IS 'identifier for the table the record belongs to';


--
-- Name: COLUMN autosave.as_pk; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.autosave.as_pk IS 'primary key of the record this is attached to';


--
-- Name: COLUMN autosave.as_binary; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.autosave.as_binary IS 'data in binary format';


--
-- Name: COLUMN autosave.as_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.autosave.as_mwhen IS 'last update timestamp';


--
-- Name: COLUMN autosave.as_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.autosave.as_mby IS 'updated by';


--
-- Name: countries_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.countries_seq
    START WITH 240
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.countries_seq OWNER TO _developer;

--
-- Name: countries; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.countries (
    co_seq integer DEFAULT nextval('infra.countries_seq'::regclass) NOT NULL,
    co_cwhen timestamp without time zone,
    co_cby character varying(15),
    co_mwhen timestamp without time zone,
    co_mby character varying(15),
    co_mcount integer DEFAULT 0 NOT NULL,
    co_active smallint,
    co_name character varying(50),
    co_iso2 character varying(2) NOT NULL,
    co_iso3 character varying(3) NOT NULL,
    co_region character varying(4),
    co_continent character varying(4),
    co_code_other character varying(4),
    co_code_origin character varying(4),
    co_langs character varying(20),
    co_name_local character varying(50),
    co_intl_dial_code character varying(4),
    co_pcode_format character varying(255),
    co_money_symb character varying(3),
    co_mm_office character varying(3),
    co_other_info character varying(500)
);


ALTER TABLE infra.countries OWNER TO _developer;

--
-- Name: entextorganisations_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.entextorganisations_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.entextorganisations_seq OWNER TO _developer;

--
-- Name: entextorganisations; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.entextorganisations (
    eo_seq bigint DEFAULT nextval('infra.entextorganisations_seq'::regclass) NOT NULL,
    eo_mec_id character varying(20),
    eo_name character varying(100) NOT NULL,
    eo_addr_bill character varying(255),
    eo_addr_ship character varying(255),
    eo_contact character varying(100),
    eo_phone character varying(20),
    eo_fax character varying(20),
    eo_email character varying(100),
    eo_instructions character varying(255),
    eo_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    eo_cby character varying(15) NOT NULL,
    eo_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    eo_mby character varying(15) NOT NULL,
    eo_comment text,
    eo_company_no character varying(20),
    eo_vat_no character varying(15),
    eo_mcount integer DEFAULT 0 NOT NULL,
    eo_addr_building character varying(100),
    eo_addr_street character varying(100),
    eo_addr_locality character varying(100),
    eo_addr_town character varying(100),
    eo_addr_state character varying(50),
    eo_addr_postcode character varying(20),
    eo_co_iso3_ref character varying(3),
    eo_mobile character varying(20)
);


ALTER TABLE infra.entextorganisations OWNER TO _developer;

--
-- Name: COLUMN entextorganisations.eo_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_seq IS 'primary key';


--
-- Name: COLUMN entextorganisations.eo_mec_id; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_mec_id IS 'myEcoCost identifier';


--
-- Name: COLUMN entextorganisations.eo_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_name IS 'organisation''s name';


--
-- Name: COLUMN entextorganisations.eo_addr_bill; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_addr_bill IS 'organisation''s address for billing';


--
-- Name: COLUMN entextorganisations.eo_addr_ship; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_addr_ship IS 'optional address (shipping for customer records)';


--
-- Name: COLUMN entextorganisations.eo_contact; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_contact IS 'name of contact within organisation';


--
-- Name: COLUMN entextorganisations.eo_phone; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_phone IS 'phone number';


--
-- Name: COLUMN entextorganisations.eo_fax; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_fax IS 'fax number';


--
-- Name: COLUMN entextorganisations.eo_email; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_email IS 'contact email address';


--
-- Name: COLUMN entextorganisations.eo_instructions; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_instructions IS 'other relevant information/instructions';


--
-- Name: COLUMN entextorganisations.eo_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_cwhen IS 'created timestamp';


--
-- Name: COLUMN entextorganisations.eo_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_cby IS 'created by';


--
-- Name: COLUMN entextorganisations.eo_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_mwhen IS 'modified timestamp';


--
-- Name: COLUMN entextorganisations.eo_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entextorganisations.eo_mby IS 'modified by';


--
-- Name: entgrouporganisations_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.entgrouporganisations_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.entgrouporganisations_seq OWNER TO _developer;

--
-- Name: entgrouporganisations; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.entgrouporganisations (
    go_seq bigint DEFAULT nextval('infra.entgrouporganisations_seq'::regclass) NOT NULL,
    go_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    go_cby character varying(15) NOT NULL,
    go_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    go_mby character varying(15) NOT NULL,
    go_mcount integer DEFAULT 0 NOT NULL,
    go_name_full character varying(255),
    go_name_short character varying(10) NOT NULL,
    go_addr_building character varying(100),
    go_addr_street character varying(100),
    go_addr_locality character varying(100),
    go_addr_town character varying(100),
    go_addr_state character varying(50),
    go_addr_postcode character varying(20),
    go_addr_country character varying(50),
    go_comm_ph character varying(20),
    go_comm_mob character varying(20),
    go_comm_email character varying(100),
    go_company_no character varying(20),
    go_vat_no character varying(15),
    go_currency character varying(3),
    go_mec_id character varying(20),
    go_mec_type smallint,
    go_rrs character varying(255),
    go_ddn_ap1 character varying(255),
    go_ddn_ap2 character varying(255),
    go_surname character varying(30),
    go_firstnames character varying(60),
    go_name_ltbc character varying(15),
    go_dob date,
    go_sex character varying(1),
    go_mmn character varying(15),
    go_id_type character varying(15),
    go_id_code character varying(20),
    go_mc_listid character varying(16),
    go_report_to_go_ref integer,
    go_report_to_percent numeric(5,4) DEFAULT 0,
    CONSTRAINT go_report_to_percent_check CHECK (((go_report_to_percent >= (0)::numeric) AND (go_report_to_percent <= (1)::numeric)))
);


ALTER TABLE infra.entgrouporganisations OWNER TO _developer;

--
-- Name: COLUMN entgrouporganisations.go_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporganisations.go_seq IS 'priomary key';


--
-- Name: COLUMN entgrouporganisations.go_mc_listid; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporganisations.go_mc_listid IS 'MailChimp default list id';


--
-- Name: entgrouporgnames_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.entgrouporgnames_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.entgrouporgnames_seq OWNER TO _developer;

--
-- Name: entgrouporgnames; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.entgrouporgnames (
    gon_seq bigint DEFAULT nextval('infra.entgrouporgnames_seq'::regclass) NOT NULL,
    gon_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    gon_cby character varying(15) NOT NULL,
    gon_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    gon_mby character varying(15) NOT NULL,
    gon_mcount integer DEFAULT 0 NOT NULL,
    gon_go_ref bigint NOT NULL,
    gon_name_full character varying(255) NOT NULL,
    gon_type character varying(1),
    CONSTRAINT gon_type_chk CHECK (((gon_type IS NULL) OR ((gon_type)::text = 'I'::text) OR ((gon_type)::text = 'E'::text)))
);


ALTER TABLE infra.entgrouporgnames OWNER TO _developer;

--
-- Name: COLUMN entgrouporgnames.gon_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_seq IS 'primary key';


--
-- Name: COLUMN entgrouporgnames.gon_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_cwhen IS 'creation timestamp';


--
-- Name: COLUMN entgrouporgnames.gon_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_cby IS 'created by';


--
-- Name: COLUMN entgrouporgnames.gon_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_mwhen IS 'modification timestamp';


--
-- Name: COLUMN entgrouporgnames.gon_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_mby IS 'modified by';


--
-- Name: COLUMN entgrouporgnames.gon_mcount; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_mcount IS 'modification count';


--
-- Name: COLUMN entgrouporgnames.gon_go_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_go_ref IS 'foreign key to entgrouporganisations';


--
-- Name: COLUMN entgrouporgnames.gon_name_full; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_name_full IS 'organisation name in referenced language';


--
-- Name: COLUMN entgrouporgnames.gon_type; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_type IS 'I = internal use, E = default for export, null';


--
-- Name: entgrouporgstructure_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.entgrouporgstructure_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.entgrouporgstructure_seq OWNER TO _developer;

--
-- Name: entgrouporgstructure; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.entgrouporgstructure (
    gs_seq integer DEFAULT nextval('infra.entgrouporgstructure_seq'::regclass) NOT NULL,
    gs_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    gs_cby character varying(15) NOT NULL,
    gs_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    gs_mby character varying(15) NOT NULL,
    gs_mcount integer DEFAULT 0 NOT NULL,
    gs_go_ref integer,
    gs_superior_gs_ref integer,
    gs_order smallint NOT NULL,
    gs_active smallint,
    gs_desc_short character varying(15),
    gs_desc_full character varying(50),
    gs_type character varying(15),
    CONSTRAINT gs_order_not_zero CHECK ((gs_order > 0))
);


ALTER TABLE infra.entgrouporgstructure OWNER TO _developer;

--
-- Name: COLUMN entgrouporgstructure.gs_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_seq IS 'primary key';


--
-- Name: COLUMN entgrouporgstructure.gs_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_cwhen IS 'creation timestamp';


--
-- Name: COLUMN entgrouporgstructure.gs_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_cby IS 'created by';


--
-- Name: COLUMN entgrouporgstructure.gs_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_mwhen IS 'modification timestamp';


--
-- Name: COLUMN entgrouporgstructure.gs_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_mby IS 'modified by';


--
-- Name: COLUMN entgrouporgstructure.gs_mcount; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_mcount IS 'modification count';


--
-- Name: COLUMN entgrouporgstructure.gs_go_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_go_ref IS 'foreign key to entgrouporganisations';


--
-- Name: COLUMN entgrouporgstructure.gs_superior_gs_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_superior_gs_ref IS 'self referencing foreign key pointing to parent record';


--
-- Name: COLUMN entgrouporgstructure.gs_order; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_order IS 'sort order with the record hiearachical level';


--
-- Name: COLUMN entgrouporgstructure.gs_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_active IS 'acive flag';


--
-- Name: COLUMN entgrouporgstructure.gs_desc_short; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_desc_short IS 'short description (unique the record hierarchical level)';


--
-- Name: COLUMN entgrouporgstructure.gs_desc_full; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_desc_full IS 'full description';


--
-- Name: COLUMN entgrouporgstructure.gs_type; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgstructure.gs_type IS 'hierarchical level identifier';


--
-- Name: entorglinks_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.entorglinks_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.entorglinks_seq OWNER TO _developer;

--
-- Name: entorglinks; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.entorglinks (
    eol_seq bigint DEFAULT nextval('infra.entorglinks_seq'::regclass) NOT NULL,
    eol_go_ref bigint NOT NULL,
    eol_eo_ref bigint NOT NULL,
    eol_finacct_cuid character varying(15),
    eol_finacct_suid character varying(15),
    eol_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    eol_cby character varying(15) NOT NULL,
    eol_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    eol_mby character varying(15) NOT NULL,
    eol_mcount integer DEFAULT 0 NOT NULL,
    CONSTRAINT eol_custsupp_chk CHECK (((eol_finacct_cuid IS NOT NULL) OR (eol_finacct_suid IS NOT NULL)))
);


ALTER TABLE infra.entorglinks OWNER TO _developer;

--
-- Name: COLUMN entorglinks.eol_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entorglinks.eol_seq IS 'primary key';


--
-- Name: COLUMN entorglinks.eol_go_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entorglinks.eol_go_ref IS 'foreign key to internal organisation - entGroupOrganisations';


--
-- Name: COLUMN entorglinks.eol_eo_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entorglinks.eol_eo_ref IS 'foreign key to external organisation - entExtOrganaisations';


--
-- Name: COLUMN entorglinks.eol_finacct_cuid; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entorglinks.eol_finacct_cuid IS 'customer ID in financial accounting system sales ledger';


--
-- Name: COLUMN entorglinks.eol_finacct_suid; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entorglinks.eol_finacct_suid IS 'supplier ID in financial accounting system purchase ledger';


--
-- Name: COLUMN entorglinks.eol_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entorglinks.eol_cwhen IS 'created timestamp';


--
-- Name: COLUMN entorglinks.eol_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entorglinks.eol_cby IS 'created by';


--
-- Name: COLUMN entorglinks.eol_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entorglinks.eol_mwhen IS 'modified timestamp';


--
-- Name: COLUMN entorglinks.eol_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entorglinks.eol_mby IS 'modified by';


--
-- Name: fininvoiceoutchain_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.fininvoiceoutchain_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.fininvoiceoutchain_seq OWNER TO _developer;

--
-- Name: fininvoiceoutchain; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.fininvoiceoutchain (
    foc_seq bigint DEFAULT nextval('infra.fininvoiceoutchain_seq'::regclass) NOT NULL,
    foc_foh_ref_prev bigint NOT NULL,
    foc_foh_ref_next bigint NOT NULL
);


ALTER TABLE infra.fininvoiceoutchain OWNER TO _developer;

--
-- Name: COLUMN fininvoiceoutchain.foc_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutchain.foc_seq IS 'primary key';


--
-- Name: COLUMN fininvoiceoutchain.foc_foh_ref_prev; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutchain.foc_foh_ref_prev IS 'primary key of the previous invoice';


--
-- Name: COLUMN fininvoiceoutchain.foc_foh_ref_next; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutchain.foc_foh_ref_next IS 'primary key of the next invoice';


--
-- Name: fininvoiceoutd_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.fininvoiceoutd_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.fininvoiceoutd_seq OWNER TO _developer;

--
-- Name: fininvoiceoutd; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.fininvoiceoutd (
    fod_seq bigint DEFAULT nextval('infra.fininvoiceoutd_seq'::regclass) NOT NULL,
    fod_foh_ref bigint NOT NULL,
    fod_prd_ref bigint NOT NULL,
    fod_desc character varying(255) NOT NULL,
    fod_unit_price numeric(15,2) NOT NULL,
    fod_unit_tax numeric(15,2) NOT NULL,
    fod_qty numeric(15,2) NOT NULL,
    fod_order smallint NOT NULL,
    fod_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    fod_cby character varying(15) NOT NULL,
    fod_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    fod_mby character varying(15) NOT NULL,
    fod_mcount integer DEFAULT 0 NOT NULL
);


ALTER TABLE infra.fininvoiceoutd OWNER TO _developer;

--
-- Name: COLUMN fininvoiceoutd.fod_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutd.fod_seq IS 'primary key; this table stores financial invoicing for micro businesses who don''t use an accounting system';


--
-- Name: COLUMN fininvoiceoutd.fod_foh_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutd.fod_foh_ref IS 'foreign key to fininvoiceouth';


--
-- Name: COLUMN fininvoiceoutd.fod_prd_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutd.fod_prd_ref IS 'foreign key to products';


--
-- Name: COLUMN fininvoiceoutd.fod_desc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutd.fod_desc IS 'description of product, cloned from PRD_NAME, able to be changed by user';


--
-- Name: COLUMN fininvoiceoutd.fod_unit_price; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutd.fod_unit_price IS 'price per unit of product';


--
-- Name: COLUMN fininvoiceoutd.fod_unit_tax; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutd.fod_unit_tax IS 'sales tax (VAT) applied per unit';


--
-- Name: COLUMN fininvoiceoutd.fod_qty; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutd.fod_qty IS 'quantity ordered';


--
-- Name: COLUMN fininvoiceoutd.fod_order; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutd.fod_order IS 'display order';


--
-- Name: COLUMN fininvoiceoutd.fod_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutd.fod_cwhen IS 'creation timestamp';


--
-- Name: COLUMN fininvoiceoutd.fod_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutd.fod_cby IS 'created by';


--
-- Name: COLUMN fininvoiceoutd.fod_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutd.fod_mwhen IS 'modification timestamp';


--
-- Name: COLUMN fininvoiceoutd.fod_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceoutd.fod_mby IS 'modified by';


--
-- Name: fininvoiceouth_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.fininvoiceouth_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.fininvoiceouth_seq OWNER TO _developer;

--
-- Name: fininvoiceouth; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.fininvoiceouth (
    foh_seq bigint DEFAULT nextval('infra.fininvoiceouth_seq'::regclass) NOT NULL,
    foh_go_ref bigint NOT NULL,
    foh_eo_ref bigint NOT NULL,
    foh_inv_no bigint NOT NULL,
    foh_addr_ship character varying(255),
    foh_addr_bill character varying(255),
    foh_cust_name character varying(100),
    foh_date date,
    foh_instructions character varying(255),
    foh_status character varying(15) NOT NULL,
    foh_cust_po character varying(10),
    foh_currency character varying(3),
    foh_swhen timestamp without time zone,
    foh_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    foh_cby character varying(15) NOT NULL,
    foh_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    foh_mby character varying(15) NOT NULL,
    foh_mcount integer DEFAULT 0 NOT NULL,
    foh_mec_id character varying(20)
);


ALTER TABLE infra.fininvoiceouth OWNER TO _developer;

--
-- Name: COLUMN fininvoiceouth.foh_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_seq IS 'primary key (used as invoice number)';


--
-- Name: COLUMN fininvoiceouth.foh_go_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_go_ref IS 'foreign key to entgrouporganisations';


--
-- Name: COLUMN fininvoiceouth.foh_eo_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_eo_ref IS 'foreign key to entextorganisations';


--
-- Name: COLUMN fininvoiceouth.foh_inv_no; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_inv_no IS 'invoice number';


--
-- Name: COLUMN fininvoiceouth.foh_addr_ship; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_addr_ship IS 'shipping address';


--
-- Name: COLUMN fininvoiceouth.foh_addr_bill; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_addr_bill IS 'billing address';


--
-- Name: COLUMN fininvoiceouth.foh_cust_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_cust_name IS 'name of customer cloned from EO_NAME';


--
-- Name: COLUMN fininvoiceouth.foh_date; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_date IS 'date of invoice';


--
-- Name: COLUMN fininvoiceouth.foh_instructions; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_instructions IS 'note to include on invoice - message to customer';


--
-- Name: COLUMN fininvoiceouth.foh_status; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_status IS 'invoice status, eg. QUOTE, ALPHA, SUBSTITUTE';


--
-- Name: COLUMN fininvoiceouth.foh_swhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_swhen IS 'submission (for ecoInvoice) timestamp';


--
-- Name: COLUMN fininvoiceouth.foh_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_cwhen IS 'creation timestamp';


--
-- Name: COLUMN fininvoiceouth.foh_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_cby IS 'created by';


--
-- Name: COLUMN fininvoiceouth.foh_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_mwhen IS 'modifcation timestamp';


--
-- Name: COLUMN fininvoiceouth.foh_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_mby IS 'modified by';


--
-- Name: COLUMN fininvoiceouth.foh_mec_id; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.fininvoiceouth.foh_mec_id IS 'myEcoCost ID';


--
-- Name: generictranslations_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.generictranslations_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.generictranslations_seq OWNER TO _developer;

--
-- Name: generictranslations; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.generictranslations (
    gt_seq bigint DEFAULT nextval('infra.generictranslations_seq'::regclass) NOT NULL,
    gt_ft_prefix character varying(5) NOT NULL,
    gt_ft_ref bigint NOT NULL,
    gt_lang_code character varying(7) NOT NULL,
    gt_name_lang character varying(255),
    gt_desc_lang character varying(255),
    gt_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    gt_cby character varying(15) NOT NULL,
    gt_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    gt_mby character varying(15),
    gt_mcount integer DEFAULT 0 NOT NULL
);


ALTER TABLE infra.generictranslations OWNER TO _developer;

--
-- Name: COLUMN generictranslations.gt_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.generictranslations.gt_seq IS 'primary key';


--
-- Name: COLUMN generictranslations.gt_ft_prefix; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.generictranslations.gt_ft_prefix IS 'prefix identifying foreign table this record belongs to';


--
-- Name: COLUMN generictranslations.gt_ft_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.generictranslations.gt_ft_ref IS 'foreign key to table identified by GT_FT_PREFIX';


--
-- Name: COLUMN generictranslations.gt_lang_code; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.generictranslations.gt_lang_code IS 'language and country code, eg. it_it';


--
-- Name: COLUMN generictranslations.gt_name_lang; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.generictranslations.gt_name_lang IS 'translation of foreign table NAME column';


--
-- Name: COLUMN generictranslations.gt_desc_lang; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.generictranslations.gt_desc_lang IS 'translation of foreign table DESC column';


--
-- Name: COLUMN generictranslations.gt_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.generictranslations.gt_cwhen IS 'created timestamp';


--
-- Name: COLUMN generictranslations.gt_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.generictranslations.gt_cby IS 'created by';


--
-- Name: COLUMN generictranslations.gt_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.generictranslations.gt_mwhen IS 'modifed timestamp';


--
-- Name: COLUMN generictranslations.gt_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.generictranslations.gt_mby IS 'modified by';


--
-- Name: importtemplate_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.importtemplate_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.importtemplate_seq OWNER TO _developer;

--
-- Name: importtemplate; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.importtemplate (
    imt_seq bigint DEFAULT nextval('infra.importtemplate_seq'::regclass) NOT NULL,
    imt_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    imt_cby character varying(15) NOT NULL,
    imt_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    imt_mby character varying(15) NOT NULL,
    imt_mcount integer DEFAULT 0 NOT NULL,
    imt_go_ref integer NOT NULL,
    imt_usr_ref integer,
    imt_name character varying(50) NOT NULL,
    imt_schema character varying(50) NOT NULL,
    imt_col_count integer NOT NULL,
    imt_imp_flags character varying(50) NOT NULL,
    imt_col_order character varying(1000) NOT NULL,
    imt_sep_thou character varying(1),
    imt_sep_dec character varying(1),
    imt_fmt_date character varying(8),
    imt_header smallint DEFAULT 0,
    imt_last_used timestamp without time zone,
    imt_ignore_rows integer DEFAULT 0
);


ALTER TABLE infra.importtemplate OWNER TO _developer;

--
-- Name: COLUMN importtemplate.imt_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_seq IS 'primary key';


--
-- Name: COLUMN importtemplate.imt_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_cwhen IS 'creation timestamp';


--
-- Name: COLUMN importtemplate.imt_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_cby IS 'created vby';


--
-- Name: COLUMN importtemplate.imt_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_mwhen IS 'modification timestamp';


--
-- Name: COLUMN importtemplate.imt_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_mby IS 'modified by';


--
-- Name: COLUMN importtemplate.imt_mcount; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_mcount IS 'modification count';


--
-- Name: COLUMN importtemplate.imt_go_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_go_ref IS 'foreign key to entGroupOrganisations';


--
-- Name: COLUMN importtemplate.imt_usr_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_usr_ref IS 'foreign key to uaUsers';


--
-- Name: COLUMN importtemplate.imt_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_name IS 'user supplied name';


--
-- Name: COLUMN importtemplate.imt_schema; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_schema IS 'omnis schema class';


--
-- Name: COLUMN importtemplate.imt_col_count; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_col_count IS 'number of columns in import file';


--
-- Name: COLUMN importtemplate.imt_imp_flags; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_imp_flags IS 'binary representation of columns to import';


--
-- Name: COLUMN importtemplate.imt_col_order; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_col_order IS 'csv string of schema columns in the order of import';


--
-- Name: COLUMN importtemplate.imt_sep_thou; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_sep_thou IS 'thousands separator';


--
-- Name: COLUMN importtemplate.imt_sep_dec; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_sep_dec IS 'decimal separator';


--
-- Name: COLUMN importtemplate.imt_fmt_date; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.importtemplate.imt_fmt_date IS 'date format';


--
-- Name: langcountry_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.langcountry_seq
    START WITH 885
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.langcountry_seq OWNER TO _developer;

--
-- Name: langcountry; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.langcountry (
    lc_seq integer DEFAULT nextval('infra.langcountry_seq'::regclass) NOT NULL,
    lc_lg_ref integer NOT NULL,
    lc_co_ref_iso3 character varying(3),
    lc_lgref_iso3 character varying(3),
    lc_co_exonym character varying(100),
    lc_co_endonym character varying(100),
    lc_capital_exonym character varying(100),
    lc_capital_endonym character varying(100),
    lc_official smallint,
    lc_mainlang smallint,
    lc_country_translit_endonym character varying(100),
    lc_capital_translit_endonym character varying(100),
    lc_cwhen timestamp without time zone NOT NULL,
    lc_cby character varying(15) NOT NULL,
    lc_mwhen timestamp without time zone NOT NULL,
    lc_mby character varying(15) NOT NULL,
    lc_mcount integer DEFAULT 0 NOT NULL,
    lc_co_ref integer
);


ALTER TABLE infra.langcountry OWNER TO _developer;

--
-- Name: languages_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.languages_seq
    START WITH 572
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.languages_seq OWNER TO _developer;

--
-- Name: languages; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.languages (
    lg_seq integer DEFAULT nextval('infra.languages_seq'::regclass) NOT NULL,
    lg_iso2 character varying(2),
    lg_iso3 character varying(3),
    lg_desc character varying(40) NOT NULL,
    lg_active smallint,
    lg_iso3_alt character varying(3),
    lg_endonym character varying(40),
    lg_no_of_speakers integer,
    lg_cwhen timestamp without time zone NOT NULL,
    lg_cby character varying(15) NOT NULL,
    lg_mwhen timestamp without time zone NOT NULL,
    lg_mby character varying(15) NOT NULL,
    lg_mcount integer DEFAULT 0 NOT NULL
);


ALTER TABLE infra.languages OWNER TO _developer;

--
-- Name: productclassifications_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.productclassifications_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.productclassifications_seq OWNER TO _developer;

--
-- Name: productclassifications; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.productclassifications (
    pcl_seq bigint DEFAULT nextval('infra.productclassifications_seq'::regclass) NOT NULL,
    pcl_prd_ref bigint NOT NULL,
    pcl_type character varying(15) NOT NULL,
    pcl_code character varying(15) NOT NULL,
    pcl_subcode character varying(15),
    pcl_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    pcl_cby character varying(15) NOT NULL
);


ALTER TABLE infra.productclassifications OWNER TO _developer;

--
-- Name: COLUMN productclassifications.pcl_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productclassifications.pcl_seq IS 'primary key - sequence generated';


--
-- Name: COLUMN productclassifications.pcl_prd_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productclassifications.pcl_prd_ref IS 'foreign key to Product';


--
-- Name: COLUMN productclassifications.pcl_type; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productclassifications.pcl_type IS 'classification type, eg. ISO';


--
-- Name: COLUMN productclassifications.pcl_code; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productclassifications.pcl_code IS 'classification system''s identifying code for the product';


--
-- Name: COLUMN productclassifications.pcl_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productclassifications.pcl_cwhen IS 'created timestamp';


--
-- Name: COLUMN productclassifications.pcl_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productclassifications.pcl_cby IS 'created by';


--
-- Name: productinternaldata; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.productinternaldata (
    pid_prd_ref bigint NOT NULL,
    pid_division character varying(15),
    pid_plant character varying(15),
    pid_busunit character varying(15),
    pid_category character varying(15),
    pid_costcentre character varying(15),
    pid_project character varying(15),
    pid_suppress_ecocost smallint,
    pid_unit_price numeric(15,2),
    pid_tax_band character varying(1),
    pid_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    pid_cby character varying(15) NOT NULL,
    pid_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    pid_mby character varying(15) NOT NULL,
    pid_mcount integer DEFAULT 0 NOT NULL,
    pid_cmp_ref bigint
);


ALTER TABLE infra.productinternaldata OWNER TO _developer;

--
-- Name: COLUMN productinternaldata.pid_prd_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_prd_ref IS 'primary key/foreign key to Product (1:1 relationship)';


--
-- Name: COLUMN productinternaldata.pid_division; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_division IS 'organisation division';


--
-- Name: COLUMN productinternaldata.pid_plant; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_plant IS 'company plant';


--
-- Name: COLUMN productinternaldata.pid_busunit; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_busunit IS 'business unit';


--
-- Name: COLUMN productinternaldata.pid_category; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_category IS 'business category';


--
-- Name: COLUMN productinternaldata.pid_costcentre; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_costcentre IS 'accounting cost centre';


--
-- Name: COLUMN productinternaldata.pid_project; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_project IS 'project';


--
-- Name: COLUMN productinternaldata.pid_suppress_ecocost; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_suppress_ecocost IS 'flag: 0 or 1=suppress publication of this product''s EcoCost';


--
-- Name: COLUMN productinternaldata.pid_unit_price; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_unit_price IS 'price per prd_unit';


--
-- Name: COLUMN productinternaldata.pid_tax_band; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_tax_band IS 'sales tax (VAT) band';


--
-- Name: COLUMN productinternaldata.pid_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_cwhen IS 'created timestamp';


--
-- Name: COLUMN productinternaldata.pid_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_cby IS 'created by';


--
-- Name: COLUMN productinternaldata.pid_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_mwhen IS 'modified timestamp';


--
-- Name: COLUMN productinternaldata.pid_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.productinternaldata.pid_mby IS 'modified by';


--
-- Name: products_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.products_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.products_seq OWNER TO _developer;

--
-- Name: products; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.products (
    prd_seq bigint DEFAULT nextval('infra.products_seq'::regclass) NOT NULL,
    prd_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    prd_cby character varying(15) NOT NULL,
    prd_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    prd_mby character varying(15) NOT NULL,
    prd_unit_price numeric(8,2),
    prd_tax_band character varying(1),
    prd_mcount integer DEFAULT 0 NOT NULL,
    prd_go_ref bigint,
    prd_eo_ref bigint,
    prd_supp_prodcode character varying(15),
    prd_int_prodcode character varying(15),
    prd_brand character varying(15),
    prd_name character varying(255),
    prd_desc text,
    prd_size double precision,
    prd_uos_code character varying(15),
    prd_unit_divisor double precision,
    prd_ecocost_uos_code character varying(15),
    prd_discontinued date,
    prd_service_unit character varying(15),
    prd_barcode character varying(128),
    prd_mfr_fback_service character varying(255),
    prd_meta smallint DEFAULT 0 NOT NULL,
    prd_micro_prd_ref bigint,
    prd_mass_factor double precision,
    CONSTRAINT prd_meta_chk CHECK (((prd_meta >= 0) AND (prd_meta <= 2)))
);


ALTER TABLE infra.products OWNER TO _developer;

--
-- Name: COLUMN products.prd_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_seq IS 'primary key';


--
-- Name: COLUMN products.prd_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_cwhen IS 'created timestamp';


--
-- Name: COLUMN products.prd_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_cby IS 'created by';


--
-- Name: COLUMN products.prd_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_mwhen IS 'modified timestamp';


--
-- Name: COLUMN products.prd_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_mby IS 'modified by';


--
-- Name: COLUMN products.prd_go_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_go_ref IS 'foreign key to entGroupOrganisations';


--
-- Name: COLUMN products.prd_eo_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_eo_ref IS 'foreign key to entExtOrganisations';


--
-- Name: COLUMN products.prd_supp_prodcode; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_supp_prodcode IS 'supplier''s product code';


--
-- Name: COLUMN products.prd_int_prodcode; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_int_prodcode IS 'internal product code';


--
-- Name: COLUMN products.prd_brand; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_brand IS 'brand identifier';


--
-- Name: COLUMN products.prd_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_name IS 'product name';


--
-- Name: COLUMN products.prd_desc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_desc IS 'full description';


--
-- Name: COLUMN products.prd_size; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_size IS 'package size';


--
-- Name: COLUMN products.prd_uos_code; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_uos_code IS 'unit of measure';


--
-- Name: COLUMN products.prd_meta; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_meta IS 'meta product flag';


--
-- Name: COLUMN products.prd_micro_prd_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_micro_prd_ref IS 'foreign key to resale product when this product is an input to a resale process model';


--
-- Name: COLUMN products.prd_mass_factor; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.products.prd_mass_factor IS 'density of product when uos_code is a measure of volume';


--
-- Name: sysasyncemails_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysasyncemails_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysasyncemails_seq OWNER TO _developer;

--
-- Name: sysasyncemails; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysasyncemails (
    ae_seq bigint DEFAULT nextval('infra.sysasyncemails_seq'::regclass) NOT NULL,
    ae_to jsonb,
    ae_subject character varying(255),
    ae_message text,
    ae_cc jsonb,
    ae_bcc jsonb,
    ae_priority smallint,
    ae_encl jsonb,
    ae_html text,
    ae_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    ae_go_ref integer,
    ae_fail_count smallint,
    ae_fail_dialogue text,
    ae_fail_status integer,
    ae_from jsonb,
    ae_extraheaders jsonb,
    ae_sendercode character varying(15)
);


ALTER TABLE infra.sysasyncemails OWNER TO _developer;

--
-- Name: COLUMN sysasyncemails.ae_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_seq IS 'primary key';


--
-- Name: COLUMN sysasyncemails.ae_to; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_to IS 'list of email addressees';


--
-- Name: COLUMN sysasyncemails.ae_subject; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_subject IS 'subject line of email';


--
-- Name: COLUMN sysasyncemails.ae_message; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_message IS 'email content';


--
-- Name: COLUMN sysasyncemails.ae_cc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_cc IS 'list of email addressees';


--
-- Name: COLUMN sysasyncemails.ae_bcc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_bcc IS 'list of email addressees';


--
-- Name: COLUMN sysasyncemails.ae_priority; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_priority IS 'priority - 0 to 3';


--
-- Name: COLUMN sysasyncemails.ae_encl; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_encl IS 'attachments';


--
-- Name: COLUMN sysasyncemails.ae_html; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_html IS 'HTML version of email message';


--
-- Name: COLUMN sysasyncemails.ae_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_cwhen IS 'creation timestamp';


--
-- Name: sysfeedback_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysfeedback_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysfeedback_seq OWNER TO _developer;

--
-- Name: sysfeedback; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysfeedback (
    sf_seq bigint DEFAULT nextval('infra.sysfeedback_seq'::regclass) NOT NULL,
    sf_topic character varying(50),
    sf_class character varying(30) NOT NULL,
    sf_class_vsn character varying(15),
    sf_type character varying(15) NOT NULL,
    sf_from character varying(15) NOT NULL,
    sf_comment character varying(255) NOT NULL,
    sf_resp_type character varying(15),
    sf_resp_due date,
    sf_reply character varying(255),
    sf_complete date,
    sf_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    sf_cby character varying(15) NOT NULL,
    sf_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    sf_mby character varying(15) NOT NULL,
    sf_mcount integer DEFAULT 0 NOT NULL
);


ALTER TABLE infra.sysfeedback OWNER TO _developer;

--
-- Name: syslogerrors; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.syslogerrors (
    sle_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    sle_code character varying(15),
    sle_subcode character varying(15),
    sle_message character varying(1000),
    sle_vhost_ref integer,
    sle_server_ip character varying(45),
    sle_server_port integer
);


ALTER TABLE infra.syslogerrors OWNER TO _developer;

--
-- Name: COLUMN syslogerrors.sle_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogerrors.sle_cwhen IS 'creation timestamp';


--
-- Name: COLUMN syslogerrors.sle_code; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogerrors.sle_code IS 'primary grouping category';


--
-- Name: COLUMN syslogerrors.sle_subcode; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogerrors.sle_subcode IS 'secondary grouping category';


--
-- Name: COLUMN syslogerrors.sle_message; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogerrors.sle_message IS 'message';


--
-- Name: syslogevents; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.syslogevents (
    slv_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    slv_code character varying(15),
    slv_subcode character varying(15),
    slv_message character varying(1000),
    slv_vhost_ref integer,
    slv_server_ip character varying(45),
    slv_server_port integer
);


ALTER TABLE infra.syslogevents OWNER TO _developer;

--
-- Name: COLUMN syslogevents.slv_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogevents.slv_cwhen IS 'creation timestamp';


--
-- Name: COLUMN syslogevents.slv_code; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogevents.slv_code IS 'primary grouping category';


--
-- Name: COLUMN syslogevents.slv_subcode; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogevents.slv_subcode IS 'secondary grouping category';


--
-- Name: COLUMN syslogevents.slv_message; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogevents.slv_message IS 'message';


--
-- Name: sysreferenceglobal_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysreferenceglobal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysreferenceglobal_seq OWNER TO _developer;

--
-- Name: sysreferenceglobal; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysreferenceglobal (
    rfg_seq bigint DEFAULT nextval('infra.sysreferenceglobal_seq'::regclass) NOT NULL,
    rfg_class character varying(15) NOT NULL,
    rfg_value character varying(15) NOT NULL,
    rfg_desc character varying(100) NOT NULL,
    rfg_order smallint,
    rfg_active smallint,
    rfg_char text,
    rfg_int bigint,
    rfg_number double precision,
    rfg_date date,
    rfg_bin bytea,
    rfg_time time without time zone,
    rfg_effective date,
    rfg_expires date,
    rfg_json jsonb,
    rfg_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfg_cby character varying(15) NOT NULL,
    rfg_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfg_mby character varying(15) NOT NULL,
    rfg_mcount integer DEFAULT 0 NOT NULL,
    rfg_unique character varying(50) NOT NULL
);


ALTER TABLE infra.sysreferenceglobal OWNER TO _developer;

--
-- Name: COLUMN sysreferenceglobal.rfg_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_seq IS 'primary key';


--
-- Name: COLUMN sysreferenceglobal.rfg_class; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_class IS 'classification column';


--
-- Name: COLUMN sysreferenceglobal.rfg_value; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_value IS 'specific reference value';


--
-- Name: COLUMN sysreferenceglobal.rfg_desc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_desc IS 'description';


--
-- Name: COLUMN sysreferenceglobal.rfg_order; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_order IS 'ordering column';


--
-- Name: COLUMN sysreferenceglobal.rfg_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_active IS '1 means an active lookup/reference entry';


--
-- Name: COLUMN sysreferenceglobal.rfg_char; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_char IS 'big character column';


--
-- Name: COLUMN sysreferenceglobal.rfg_int; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_int IS 'integer value';


--
-- Name: COLUMN sysreferenceglobal.rfg_number; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_number IS 'floating number value';


--
-- Name: COLUMN sysreferenceglobal.rfg_date; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_date IS 'date column';


--
-- Name: COLUMN sysreferenceglobal.rfg_bin; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_bin IS 'binary value';


--
-- Name: sysreferencelocal_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysreferencelocal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysreferencelocal_seq OWNER TO _developer;

--
-- Name: sysreferencelocal; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysreferencelocal (
    rfl_seq bigint DEFAULT nextval('infra.sysreferencelocal_seq'::regclass) NOT NULL,
    rfl_class character varying(15) NOT NULL,
    rfl_value character varying(15) NOT NULL,
    rfl_desc character varying(100) NOT NULL,
    rfl_order smallint,
    rfl_active smallint,
    rfl_char text,
    rfl_int bigint,
    rfl_number double precision,
    rfl_date date,
    rfl_bin bytea,
    rfl_time time without time zone,
    rfl_effective date,
    rfl_expires date,
    rfl_json jsonb,
    rfl_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfl_cby character varying(15) NOT NULL,
    rfl_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfl_mby character varying(15) NOT NULL,
    rfl_mcount integer DEFAULT 0 NOT NULL,
    rfl_inherit smallint DEFAULT 0 NOT NULL,
    rfl_unique character varying(50) NOT NULL
);


ALTER TABLE infra.sysreferencelocal OWNER TO _developer;

--
-- Name: COLUMN sysreferencelocal.rfl_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_seq IS 'primary key';


--
-- Name: COLUMN sysreferencelocal.rfl_class; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_class IS 'classification column';


--
-- Name: COLUMN sysreferencelocal.rfl_value; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_value IS 'specific reference value';


--
-- Name: COLUMN sysreferencelocal.rfl_desc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_desc IS 'description';


--
-- Name: COLUMN sysreferencelocal.rfl_order; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_order IS 'ordering column';


--
-- Name: COLUMN sysreferencelocal.rfl_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_active IS '1 means an active lookup/reference entry';


--
-- Name: COLUMN sysreferencelocal.rfl_char; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_char IS 'big character column';


--
-- Name: COLUMN sysreferencelocal.rfl_int; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_int IS 'integer value';


--
-- Name: COLUMN sysreferencelocal.rfl_number; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_number IS 'floating number value';


--
-- Name: COLUMN sysreferencelocal.rfl_date; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_date IS 'date column';


--
-- Name: COLUMN sysreferencelocal.rfl_bin; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_bin IS 'binary value';


--
-- Name: sysreferenceuser_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysreferenceuser_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysreferenceuser_seq OWNER TO _developer;

--
-- Name: sysreferenceuser; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysreferenceuser (
    rfu_seq bigint DEFAULT nextval('infra.sysreferenceuser_seq'::regclass) NOT NULL,
    rfu_class character varying(15) NOT NULL,
    rfu_value character varying(15) NOT NULL,
    rfu_desc character varying(100) NOT NULL,
    rfu_order smallint,
    rfu_active smallint,
    rfu_char character varying(1000),
    rfu_int bigint,
    rfu_number double precision,
    rfu_date date,
    rfu_bin bytea,
    rfu_time time without time zone,
    rfu_effective date,
    rfu_expires date,
    rfu_json jsonb,
    rfu_go_ref bigint NOT NULL,
    rfu_usr_ref bigint NOT NULL,
    rfu_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfu_cby character varying(15) NOT NULL,
    rfu_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfu_mby character varying(15) NOT NULL,
    rfu_mcount integer DEFAULT 0 NOT NULL,
    rfu_unique character varying(50) NOT NULL
);


ALTER TABLE infra.sysreferenceuser OWNER TO _developer;

--
-- Name: COLUMN sysreferenceuser.rfu_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_seq IS 'primary key';


--
-- Name: COLUMN sysreferenceuser.rfu_class; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_class IS 'classification column';


--
-- Name: COLUMN sysreferenceuser.rfu_value; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_value IS 'specific reference value';


--
-- Name: COLUMN sysreferenceuser.rfu_desc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_desc IS 'description';


--
-- Name: COLUMN sysreferenceuser.rfu_order; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_order IS 'ordering column';


--
-- Name: COLUMN sysreferenceuser.rfu_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_active IS '1 means an active lookup/reference entry';


--
-- Name: COLUMN sysreferenceuser.rfu_char; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_char IS 'big character column';


--
-- Name: COLUMN sysreferenceuser.rfu_int; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_int IS 'integer value';


--
-- Name: COLUMN sysreferenceuser.rfu_number; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_number IS 'floating number value';


--
-- Name: COLUMN sysreferenceuser.rfu_date; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_date IS 'date column';


--
-- Name: COLUMN sysreferenceuser.rfu_bin; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_bin IS 'binary value';


--
-- Name: syssemaphores; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.syssemaphores (
    smh_table_prfx character varying(10),
    smh_pkey_i bigint,
    smh_pkey_c character varying(30),
    smh_owner character varying(15),
    smh_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone
);


ALTER TABLE infra.syssemaphores OWNER TO _developer;

--
-- Name: systaskstats_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.systaskstats_seq
    START WITH 380
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.systaskstats_seq OWNER TO _developer;

--
-- Name: systaskstats; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.systaskstats (
    sts_seq bigint DEFAULT nextval('infra.systaskstats_seq'::regclass) NOT NULL,
    sts_start timestamp without time zone,
    sts_count_start smallint,
    sts_end timestamp without time zone,
    sts_count_end smallint,
    sts_last_response timestamp without time zone,
    sts_go_ref integer,
    sts_bytes_reqcursent bigint,
    sts_bytes_reqcurrecd bigint,
    sts_bytes_reqmaxsent bigint,
    sts_bytes_reqmaxrecd bigint,
    sts_bytes_reqtotsent bigint,
    sts_bytes_reqtotrecd bigint,
    sts_tot_events integer,
    sts_ula_ref integer,
    sts_ip4 character varying(16),
    sts_type character varying(1) DEFAULT 'R'::character varying NOT NULL,
    sts_db_requests integer DEFAULT 0,
    sts_fetches integer DEFAULT 0,
    sts_inserts integer DEFAULT 0,
    sts_updates integer DEFAULT 0,
    sts_deletes integer DEFAULT 0,
    sts_device_size character varying(255),
    sts_init_class character varying(100),
    sts_gl_ref bigint,
    sts_browser text,
    sts_ws_name character varying(255),
    sts_table_name character varying(50),
    sts_table_method character varying(50),
    sts_params text,
    sts_table_list text,
    CONSTRAINT sts_type_chk CHECK ((((sts_type)::text = 'F'::text) OR ((sts_type)::text = 'R'::text) OR ((sts_type)::text = 'U'::text) OR ((sts_type)::text = 'J'::text) OR ((sts_type)::text = 'S'::text) OR ((sts_type)::text = '?'::text)))
);


ALTER TABLE infra.systaskstats OWNER TO _developer;

--
-- Name: COLUMN systaskstats.sts_type; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_type IS '(S)tartup Task, (R)emoteTask';


--
-- Name: COLUMN systaskstats.sts_db_requests; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_db_requests IS 'total number of DB calls';


--
-- Name: COLUMN systaskstats.sts_fetches; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_fetches IS 'total number of rows fetched from the DB';


--
-- Name: COLUMN systaskstats.sts_inserts; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_inserts IS 'total number of rows inserted into the DB';


--
-- Name: COLUMN systaskstats.sts_updates; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_updates IS 'total number of rows updated in the DB';


--
-- Name: COLUMN systaskstats.sts_deletes; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_deletes IS 'total number of rows deleted from the DB';


--
-- Name: COLUMN systaskstats.sts_ws_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_ws_name IS 'web service name';


--
-- Name: COLUMN systaskstats.sts_table_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_table_name IS 'table class name';


--
-- Name: COLUMN systaskstats.sts_table_method; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_table_method IS 'table class method';


--
-- Name: COLUMN systaskstats.sts_params; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_params IS 'parameters pass to table class method in JSON format';


--
-- Name: COLUMN systaskstats.sts_table_list; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_table_list IS 'tables accessed during REST and SOAP service calls';


--
-- Name: sysunitofmeasure_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysunitofmeasure_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysunitofmeasure_seq OWNER TO _developer;

--
-- Name: sysunitofmeasure; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysunitofmeasure (
    uom_seq bigint DEFAULT nextval('infra.sysunitofmeasure_seq'::regclass) NOT NULL,
    uom_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    uom_cby character varying(15) NOT NULL,
    uom_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    uom_mby character varying(15) NOT NULL,
    uom_mcount integer DEFAULT 0 NOT NULL,
    uom_code character varying(15) NOT NULL,
    uom_desc_en character varying(255),
    uom_group character varying(15) NOT NULL,
    uom_active smallint DEFAULT 1 NOT NULL
);


ALTER TABLE infra.sysunitofmeasure OWNER TO _developer;

--
-- Name: COLUMN sysunitofmeasure.uom_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitofmeasure.uom_seq IS 'primary key';


--
-- Name: COLUMN sysunitofmeasure.uom_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitofmeasure.uom_cwhen IS 'created when';


--
-- Name: COLUMN sysunitofmeasure.uom_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitofmeasure.uom_cby IS 'created by';


--
-- Name: COLUMN sysunitofmeasure.uom_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitofmeasure.uom_mwhen IS 'modification timestamp';


--
-- Name: COLUMN sysunitofmeasure.uom_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitofmeasure.uom_mby IS 'modified by';


--
-- Name: COLUMN sysunitofmeasure.uom_mcount; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitofmeasure.uom_mcount IS 'modification count';


--
-- Name: COLUMN sysunitofmeasure.uom_code; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitofmeasure.uom_code IS 'unique alpha code for UOM';


--
-- Name: COLUMN sysunitofmeasure.uom_desc_en; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitofmeasure.uom_desc_en IS 'description of unit of measure (in english)';


--
-- Name: COLUMN sysunitofmeasure.uom_group; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitofmeasure.uom_group IS 'group classification of measurement';


--
-- Name: COLUMN sysunitofmeasure.uom_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitofmeasure.uom_active IS 'availability flag for user selection';


--
-- Name: sysunitsynonyms_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysunitsynonyms_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysunitsynonyms_seq OWNER TO _developer;

--
-- Name: sysunitsynonyms; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysunitsynonyms (
    uos_seq bigint DEFAULT nextval('infra.sysunitsynonyms_seq'::regclass) NOT NULL,
    uos_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    uos_cby character varying(15),
    uos_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    uos_mby character varying(15) NOT NULL,
    uos_mcount integer DEFAULT 0 NOT NULL,
    uos_uom_ref bigint NOT NULL,
    uos_code character varying(15) NOT NULL,
    uos_factor double precision NOT NULL,
    uos_filter character varying(15),
    uos_active smallint DEFAULT 1 NOT NULL
);


ALTER TABLE infra.sysunitsynonyms OWNER TO _developer;

--
-- Name: COLUMN sysunitsynonyms.uos_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitsynonyms.uos_seq IS 'primary key';


--
-- Name: COLUMN sysunitsynonyms.uos_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitsynonyms.uos_cwhen IS 'created when';


--
-- Name: COLUMN sysunitsynonyms.uos_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitsynonyms.uos_cby IS 'created by';


--
-- Name: COLUMN sysunitsynonyms.uos_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitsynonyms.uos_mwhen IS 'moodification timestamp';


--
-- Name: COLUMN sysunitsynonyms.uos_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitsynonyms.uos_mby IS 'modified by';


--
-- Name: COLUMN sysunitsynonyms.uos_mcount; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitsynonyms.uos_mcount IS 'modification count';


--
-- Name: COLUMN sysunitsynonyms.uos_uom_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitsynonyms.uos_uom_ref IS 'foreign key to sysunitofmeasure';


--
-- Name: COLUMN sysunitsynonyms.uos_code; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitsynonyms.uos_code IS 'unique code';


--
-- Name: COLUMN sysunitsynonyms.uos_factor; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitsynonyms.uos_factor IS 'adjustment factor';


--
-- Name: COLUMN sysunitsynonyms.uos_filter; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitsynonyms.uos_filter IS 'filter, eg. metric, imperial, US';


--
-- Name: COLUMN sysunitsynonyms.uos_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysunitsynonyms.uos_active IS 'availability flag for user selection';


--
-- Name: uagrouporglinks_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.uagrouporglinks_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.uagrouporglinks_seq OWNER TO _developer;

--
-- Name: uagrouporglinks; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.uagrouporglinks (
    ugo_seq bigint DEFAULT nextval('infra.uagrouporglinks_seq'::regclass) NOT NULL,
    ugo_go_ref bigint NOT NULL,
    ugo_usr_ref bigint NOT NULL,
    ugo_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    ugo_cby character varying(15) NOT NULL
);


ALTER TABLE infra.uagrouporglinks OWNER TO _developer;

--
-- Name: COLUMN uagrouporglinks.ugo_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uagrouporglinks.ugo_seq IS 'primary key';


--
-- Name: COLUMN uagrouporglinks.ugo_go_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uagrouporglinks.ugo_go_ref IS 'foreign key to entGroupOrganisations';


--
-- Name: COLUMN uagrouporglinks.ugo_usr_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uagrouporglinks.ugo_usr_ref IS 'foreign key to uaUsers';


--
-- Name: COLUMN uagrouporglinks.ugo_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uagrouporglinks.ugo_cwhen IS 'creation date';


--
-- Name: COLUMN uagrouporglinks.ugo_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uagrouporglinks.ugo_cby IS 'created by';


--
-- Name: ualogaccess_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.ualogaccess_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.ualogaccess_seq OWNER TO _developer;

--
-- Name: ualogaccess; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.ualogaccess (
    ula_seq bigint DEFAULT nextval('infra.ualogaccess_seq'::regclass) NOT NULL,
    ula_usr_ref bigint,
    ula_login timestamp without time zone,
    ula_logout timestamp without time zone,
    ula_forms_visited character varying(255),
    ula_ip_address character varying(50),
    ula_go_name character varying(10),
    ula_connect_time timestamp without time zone,
    ula_bytes_connect bigint,
    ula_bytes_total_sent bigint,
    ula_bytes_total_recd bigint,
    ula_bytes_max_sent bigint,
    ula_bytes_max_recd bigint,
    ula_requests bigint,
    ula_comment character varying(1000),
    ula_last_hit timestamp without time zone,
    ula_dg_ref bigint
);


ALTER TABLE infra.ualogaccess OWNER TO _developer;

--
-- Name: COLUMN ualogaccess.ula_go_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.ualogaccess.ula_go_name IS 'group organisation short name';


--
-- Name: COLUMN ualogaccess.ula_dg_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.ualogaccess.ula_dg_ref IS 'foreign key to delegates (for specific applications only)';


--
-- Name: uapermissions_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.uapermissions_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.uapermissions_seq OWNER TO _developer;

--
-- Name: uapermissions; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.uapermissions (
    per_seq bigint DEFAULT nextval('infra.uapermissions_seq'::regclass) NOT NULL,
    per_label character varying(15) NOT NULL,
    per_desc_en character varying(30),
    per_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    per_cby character varying(15) NOT NULL,
    per_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    per_mby character varying(15) NOT NULL,
    per_mcount integer DEFAULT 0 NOT NULL,
    per_su smallint DEFAULT 0
);


ALTER TABLE infra.uapermissions OWNER TO _developer;

--
-- Name: COLUMN uapermissions.per_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uapermissions.per_seq IS 'primary key';


--
-- Name: COLUMN uapermissions.per_label; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uapermissions.per_label IS 'permission code used by the application';


--
-- Name: COLUMN uapermissions.per_desc_en; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uapermissions.per_desc_en IS 'descriptive label eg. create users, modify process models, etc.';


--
-- Name: COLUMN uapermissions.per_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uapermissions.per_cwhen IS 'created timestamp';


--
-- Name: COLUMN uapermissions.per_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uapermissions.per_cby IS 'created by';


--
-- Name: COLUMN uapermissions.per_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uapermissions.per_mwhen IS 'modified timestamp';


--
-- Name: COLUMN uapermissions.per_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uapermissions.per_mby IS 'modified by';


--
-- Name: uarolepermissions_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.uarolepermissions_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.uarolepermissions_seq OWNER TO _developer;

--
-- Name: uarolepermissions; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.uarolepermissions (
    rp_seq bigint DEFAULT nextval('infra.uarolepermissions_seq'::regclass) NOT NULL,
    rp_rol_ref bigint,
    rp_per_ref bigint,
    rp_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    rp_cby character varying(15)
);


ALTER TABLE infra.uarolepermissions OWNER TO _developer;

--
-- Name: COLUMN uarolepermissions.rp_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uarolepermissions.rp_seq IS 'primary key';


--
-- Name: COLUMN uarolepermissions.rp_rol_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uarolepermissions.rp_rol_ref IS 'foreign key to uaRoles';


--
-- Name: COLUMN uarolepermissions.rp_per_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uarolepermissions.rp_per_ref IS 'foreign key to uaPermissions';


--
-- Name: COLUMN uarolepermissions.rp_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uarolepermissions.rp_cwhen IS 'created timestamp';


--
-- Name: COLUMN uarolepermissions.rp_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uarolepermissions.rp_cby IS 'created by';


--
-- Name: uaroles_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.uaroles_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.uaroles_seq OWNER TO _developer;

--
-- Name: uaroles; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.uaroles (
    rol_seq bigint DEFAULT nextval('infra.uaroles_seq'::regclass) NOT NULL,
    rol_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    rol_cby character varying,
    rol_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    rol_mby character varying,
    rol_mcount integer DEFAULT 0,
    rol_name character varying(15),
    rol_revoke smallint,
    rol_rol_ref bigint,
    rol_active smallint DEFAULT (1)::smallint NOT NULL,
    rol_su smallint DEFAULT 0,
    CONSTRAINT rol_rol_ref_chk CHECK ((rol_rol_ref <> rol_seq))
);


ALTER TABLE infra.uaroles OWNER TO _developer;

--
-- Name: COLUMN uaroles.rol_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uaroles.rol_seq IS 'primary key';


--
-- Name: COLUMN uaroles.rol_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uaroles.rol_cwhen IS 'created timetamp';


--
-- Name: COLUMN uaroles.rol_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uaroles.rol_cby IS 'created by';


--
-- Name: COLUMN uaroles.rol_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uaroles.rol_mwhen IS 'modified timestamp';


--
-- Name: COLUMN uaroles.rol_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uaroles.rol_mby IS 'modified by';


--
-- Name: COLUMN uaroles.rol_mcount; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uaroles.rol_mcount IS 'modification count';


--
-- Name: COLUMN uaroles.rol_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uaroles.rol_name IS 'name of the role, eg. auditor, administrator, manager, ';


--
-- Name: COLUMN uaroles.rol_revoke; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uaroles.rol_revoke IS '1=revoke permission(s)';


--
-- Name: COLUMN uaroles.rol_rol_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uaroles.rol_rol_ref IS 'key to parent role';


--
-- Name: COLUMN uaroles.rol_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uaroles.rol_active IS '0=inactive, 1=active';


--
-- Name: uauserroles_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.uauserroles_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.uauserroles_seq OWNER TO _developer;

--
-- Name: uauserroles; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.uauserroles (
    ur_seq bigint DEFAULT nextval('infra.uauserroles_seq'::regclass) NOT NULL,
    ur_usr_ref bigint,
    ur_rol_ref bigint,
    ur_active smallint,
    ur_default smallint,
    ur_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    ur_cby character varying(15)
);


ALTER TABLE infra.uauserroles OWNER TO _developer;

--
-- Name: COLUMN uauserroles.ur_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uauserroles.ur_seq IS 'primary key';


--
-- Name: COLUMN uauserroles.ur_usr_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uauserroles.ur_usr_ref IS 'foreign key to uaUsers';


--
-- Name: COLUMN uauserroles.ur_rol_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uauserroles.ur_rol_ref IS 'foreign key to uaRoles';


--
-- Name: COLUMN uauserroles.ur_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uauserroles.ur_active IS 'is this User-Role relationship currently active?';


--
-- Name: COLUMN uauserroles.ur_default; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uauserroles.ur_default IS 'does the user get this role by default?';


--
-- Name: COLUMN uauserroles.ur_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uauserroles.ur_cwhen IS 'created timestamp';


--
-- Name: COLUMN uauserroles.ur_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uauserroles.ur_cby IS 'created by';


--
-- Name: uausers_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.uausers_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.uausers_seq OWNER TO _developer;

--
-- Name: uausers; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.uausers (
    usr_seq bigint DEFAULT nextval('infra.uausers_seq'::regclass) NOT NULL,
    usr_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usr_cby character varying(15),
    usr_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usr_mby character varying(15),
    usr_mcount integer,
    usr_usr_ref bigint,
    usr_name character varying(15),
    usr_real_name character varying(30),
    usr_salt character varying(40),
    usr_hashpass character varying(100),
    usr_extn character varying(15),
    usr_mobile character varying(20),
    usr_email character varying(100),
    usr_pw_expires date,
    usr_ac_expires date,
    usr_initials character varying(5),
    usr_job_title character varying(50),
    usr_team character varying(15),
    usr_startdate date,
    usr_active smallint DEFAULT (1)::smallint NOT NULL,
    usr_su smallint DEFAULT 0,
    CONSTRAINT usr_usr_ref_chk CHECK ((usr_usr_ref <> usr_seq))
);


ALTER TABLE infra.uausers OWNER TO _developer;

--
-- Name: COLUMN uausers.usr_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_seq IS 'primary key';


--
-- Name: COLUMN uausers.usr_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_cwhen IS 'created timestamp';


--
-- Name: COLUMN uausers.usr_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_cby IS 'created by';


--
-- Name: COLUMN uausers.usr_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_mwhen IS 'last modified';


--
-- Name: COLUMN uausers.usr_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_mby IS 'modified by';


--
-- Name: COLUMN uausers.usr_mcount; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_mcount IS 'update count';


--
-- Name: COLUMN uausers.usr_usr_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_usr_ref IS 'manager key';


--
-- Name: COLUMN uausers.usr_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_name IS 'user login name';


--
-- Name: COLUMN uausers.usr_real_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_real_name IS 'user full name';


--
-- Name: COLUMN uausers.usr_salt; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_salt IS 'hash salt for password';


--
-- Name: COLUMN uausers.usr_hashpass; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_hashpass IS 'user password hashed';


--
-- Name: COLUMN uausers.usr_extn; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_extn IS 'phone extension';


--
-- Name: COLUMN uausers.usr_mobile; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_mobile IS 'mobile number';


--
-- Name: COLUMN uausers.usr_email; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_email IS 'email address';


--
-- Name: COLUMN uausers.usr_pw_expires; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_pw_expires IS 'password expiry date';


--
-- Name: COLUMN uausers.usr_ac_expires; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_ac_expires IS 'account expiry date';


--
-- Name: COLUMN uausers.usr_initials; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_initials IS 'user initials';


--
-- Name: COLUMN uausers.usr_job_title; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_job_title IS 'job title';


--
-- Name: COLUMN uausers.usr_team; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_team IS 'team name';


--
-- Name: v_sysreferenceglobal_seq; Type: VIEW; Schema: infra; Owner: _developer
--

CREATE VIEW infra.v_sysreferenceglobal_seq AS
 SELECT nextval('infra.sysreferenceglobal_seq'::regclass) AS seq;


ALTER TABLE infra.v_sysreferenceglobal_seq OWNER TO _developer;

--
-- Name: v_sysreferencelocal_seq; Type: VIEW; Schema: infra; Owner: _developer
--

CREATE VIEW infra.v_sysreferencelocal_seq AS
 SELECT nextval('infra.sysreferencelocal_seq'::regclass) AS seq;


ALTER TABLE infra.v_sysreferencelocal_seq OWNER TO _developer;

--
-- Name: v_sysreferenceorg_seq; Type: VIEW; Schema: infra; Owner: _developer
--

CREATE VIEW infra.v_sysreferenceorg_seq AS
 SELECT nextval('infra.sysreferenceorg_seq'::regclass) AS seq;


ALTER TABLE infra.v_sysreferenceorg_seq OWNER TO _developer;

--
-- Name: vi_timezones; Type: VIEW; Schema: infra; Owner: _developer
--

CREATE VIEW infra.vi_timezones AS
 SELECT concat(tz.region, '/', tz.firsttown) AS timezone,
    tz.region,
    tz.abbrev,
    string_agg(tz.town, ', '::text ORDER BY tz.town) AS tooltip,
    tz.utc_offset,
    tz.is_dst
   FROM ( SELECT "substring"(pg_timezone_names.name, 1, ("position"(pg_timezone_names.name, '/'::text) - 1)) AS region,
            pg_timezone_names.abbrev,
            "substring"(pg_timezone_names.name, ("position"(pg_timezone_names.name, '/'::text) + 1)) AS town,
            pg_timezone_names.utc_offset,
            pg_timezone_names.is_dst,
            first_value("substring"(pg_timezone_names.name, ("position"(pg_timezone_names.name, '/'::text) + 1))) OVER (PARTITION BY ("substring"(pg_timezone_names.name, 1, ("position"(pg_timezone_names.name, '/'::text) - 1))), pg_timezone_names.abbrev ORDER BY ("substring"(pg_timezone_names.name, ("position"(pg_timezone_names.name, '/'::text) + 1)))) AS firsttown
           FROM pg_timezone_names
          WHERE (("position"(pg_timezone_names.name, '/'::text) > 0) AND ("position"("substring"(pg_timezone_names.name, ("position"(pg_timezone_names.name, '/'::text) + 1)), '/'::text) = 0) AND ("position"(pg_timezone_names.name, 'Havana'::text) = 0) AND ("substring"(pg_timezone_names.name, 1, 3) <> 'Etc'::text))) tz
  GROUP BY (concat(tz.region, '/', tz.firsttown)), tz.region, tz.abbrev, tz.utc_offset, tz.is_dst;


ALTER TABLE infra.vi_timezones OWNER TO _developer;

--
-- Name: websessions; Type: VIEW; Schema: public; Owner: _developer
--

CREATE VIEW public.websessions AS
 SELECT systaskstats.sts_seq AS ws_seq,
    systaskstats.sts_start AS ws_cwhen,
    systaskstats.sts_ip4 AS ws_ip,
    systaskstats.sts_gl_ref AS ws_gl_ref
   FROM infra.systaskstats;


ALTER TABLE public.websessions OWNER TO _developer;

--
-- Data for Name: accountingperiod; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.accountingperiod (acp_seq, acp_span, acp_from, acp_to, acp_cwhen, acp_cby, acp_mwhen, acp_mby, acp_mcount) FROM stdin;
\.


--
-- Data for Name: accountingperiodlinks; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.accountingperiodlinks (acl_seq, acl_acp_ref, acl_go_ref, acl_fc_adjust, acl_comment, acl_closed, acl_cwhen, acl_cby, acl_mwhen, acl_mby, acl_mcount) FROM stdin;
\.


--
-- Data for Name: autosave; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.autosave (as_seq, as_table_prefix, as_pk, as_binary, as_cwhen, as_cby, as_mwhen, as_mby, as_mcount) FROM stdin;
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.countries (co_seq, co_cwhen, co_cby, co_mwhen, co_mby, co_mcount, co_active, co_name, co_iso2, co_iso3, co_region, co_continent, co_code_other, co_code_origin, co_langs, co_name_local, co_intl_dial_code, co_pcode_format, co_money_symb, co_mm_office, co_other_info) FROM stdin;
1	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	AFGHANISTAN	AF	AFG	MIDE	\N							\N		
2	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ALBANIA	AL	ALB	EUR	\N							\N		
3	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ALGERIA	DZ	DZA	AFRN	\N							\N		
4	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	AMERICAN SAMOA	AS	ASM	OPAC	\N							\N		
5	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ANDORRA	AD	AND	EUR	\N							\N		
6	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ANGOLA	AO	AGO	AFRS	\N							\N		
7	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ANGUILLA	AI	AIA	CARI								\N		
8	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	ANTARCTICA	AQ	ATA	ANTA	\N							\N		
9	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	ANTIGUA AND BARBUDA	AG	ATG	CARI	\N							\N		
10	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ARGENTINA	AR	ARG	AMES	\N							\N		
11	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ARMENIA	AM	ARM	EURA	\N							\N		
12	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ARUBA	AW	ABW	CARI	\N							\N		
13	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	AUSTRALIA	AU	AUS	OCEA	\N					61	<EVAL>len(pPostcode)=4&chk(pPostcode,'0000','9999')</EVAL><LOOKUP>AUS</LOOKUP>	\N		
14	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	AUSTRIA	AT	AUT	EUR	\N							\N		
15	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	AZERBAIJAN	AZ	AZE	EURA	\N							\N		
16	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BAHAMAS	BS	BHS	CARI	\N							\N		
17	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BAHRAIN	BH	BHR	MIDE								\N		
18	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BANGLADESH	BD	BGD	ASIA	\N							\N		
19	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BARBADOS	BB	BRB	CARI	\N							\N		
20	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BELARUS	BY	BLR	USSR	\N							\N		
21	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BELGIUM	BE	BEL	EUR	\N							\N		
22	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BELIZE	BZ	BLZ	AMEC	\N							\N		
23	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BENIN	BJ	BEN	AFRW	\N							\N		
24	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BERMUDA	BM	BMU	CARI	\N							\N		
25	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BHUTAN	BT	BTN	ASIA	\N							\N		
26	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BOLIVIA	BO	BOL	AMES	\N							\N		
27	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BOSNIA-HERZEGOVINA	BA	BIH	EUR								\N		
28	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BOTSWANA	BW	BWA	AFRS	\N							\N		
29	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	BOUVET ISLAND	BV	BVT	OATS	\N							\N		
30	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BRAZIL	BR	BRA	AMES								\N		
31	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	BRITISH INDIAN OCEAN TERRITORY	IO	IOT	OIND								\N		
32	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BRUNEI	BN	BRN	ASIA								\N		
33	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BULGARIA	BG	BGR	EUR	\N							\N		
34	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BURKINA FASO	BF	BFA	AFRN	\N							\N		
35	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	BURUNDI	BI	BDI	AFRE	\N							\N		
36	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CAMBODIA	KH	KHM	ASIA	\N							\N		
37	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CAMEROON	CM	CMR	AFRC	\N							\N		
38	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CANADA	CA	CAN	AMEN	\N							\N		
39	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CAPE VERDE	CV	CPV	OATN	\N							\N		
40	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CAYMAN ISLANDS	KY	CYM	CARI								\N		
41	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CENTRAL AFRICAN REPUBLIC	CF	CAF	AFRC	\N							\N		
42	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CHAD	TD	TCD	AFRN	\N							\N		
43	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CHILE	CL	CHL	AMES	\N							\N		
44	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CHINA	CN	CHN	ASIA	\N							\N		
45	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	CHRISTMAS ISLAND	CX	CXR	OIND	\N							\N		
46	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	COCOS ISLANDS	CC	CCK	OIND	\N							\N		
47	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	COLOMBIA	CO	COL	AMEC	\N							\N		
48	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	COMOROS	KM	COM	OIND	\N							\N		
49	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CONGO (DRC)	CD	COD	AFRC	\N							\N		
50	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CONGO	CG	COG	AFRC	\N							\N		
51	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	COOK ISLANDS	CK	COK	OPAC	\N							\N		
52	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	COSTA RICA	CR	CRI	AMEC	\N							\N		
53	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	COTE D'IVOIRE	CI	CIV	AFRW	\N							\N		
54	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CROATIA	HR	HRV	EUR	\N							\N		
55	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CUBA	CU	CUB	CARI	\N							\N		
56	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CYPRUS	CY	CYP	EUR	\N							\N		
57	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	CZECH REPUBLIC	CZ	CZE	EUR	\N							\N		
58	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	DENMARK	DK	DNK	EUR	\N							\N		
59	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	DJIBOUTI	DJ	DJI	AFRE	\N							\N		
60	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	DOMINICA	DM	DMA	CARI	\N							\N		
61	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	DOMINICAN REPUBLIC	DO	DOM	CARI	\N							\N		
62	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	EAST TIMOR	TL	TLS	ASIA	\N							\N		
63	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ECUADOR	EC	ECU	AMEC	\N							\N		
64	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	EGYPT	EG	EGY	AFRN	\N							\N		
65	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	EL SALVADOR	SV	SLV	AMEC	\N							\N		
66	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	EQUATORIAL GUINEA	GQ	GNQ	AFWC	\N							\N		
67	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ERITREA	ER	ERI	AFRE	\N							\N		
68	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ESTONIA	EE	EST	EUR	\N							\N		
69	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ETHIOPIA	ET	ETH	AFRE	\N							\N		
70	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	FALKLAND ISLANDS (MALVINAS)	FK	FLK	OATS	\N							\N		
71	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	FAROE ISLANDS	FO	FRO	OATN	\N							\N		
72	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	FIJI	FJ	FJI	PACI	\N							\N		
73	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	FINLAND	FI	FIN	EUR	\N							\N		
74	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	FRANCE	FR	FRA	EUR	\N							\N		
75	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	FRANCE, METROPOLITAN	FX	FXX	EUR	\N							\N		
76	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	FRENCH GUIANA	GF	GUF	AMES	\N							\N		
77	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	FRENCH POLYNESIA	PF	PYF	PACI	\N							\N		
78	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	FRENCH SOUTHERN TERRITORIES	TF	ATF	OIND	\N							\N		
79	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GABON	GA	GAB	AFWC	\N							\N		
80	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GAMBIA	GM	GMB	AFRW	\N							\N		
81	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GEORGIA	GE	GEO	USSR	\N							\N		
82	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GERMANY	DE	DEU	EUR	\N					49		\N		
83	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GHANA	GH	GHA	AFRW	\N							\N		
84	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GIBRALTAR	GI	GIB	EUR	\N							\N		
85	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GREECE	GR	GRC	EUR	\N							\N		
86	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GREENLAND	GL	GRL	EUR	\N							\N		
87	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GRENADA	GD	GRD	CARI	\N							\N		
88	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GUADELOUPE	GP	GLP	CARI	\N							\N		
89	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GUAM	GU	GUM	PACI	\N							\N		
90	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GUATEMALA	GT	GTM	AMEC	\N							\N		
91	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GUINEA	GN	GIN	AFRW	\N							\N		
92	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GUINEA-BISSAU	GW	GNB	AFRW	\N							\N		
93	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	GUYANA	GY	GUY	AMEC	\N							\N		
94	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	HAITI	HT	HTI	CARI	\N							\N		
95	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	HEARD AND MC DONALD ISLANDS	HM	HMD	OSOU	\N							\N		
96	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	HONDURAS	HN	HND	AMEC								\N		
97	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	HONG KONG	HK	HKG	ASIA	\N							\N		
98	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	HUNGARY	HU	HUN	EUR	\N							\N		
99	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ICELAND	IS	ISL	OATN								\N		
100	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	INDIA	IN	IND	ASIA	\N						<EVAL>len(pPostcode)=6&chk(pPostcode,'000000','999999')</EVAL>	\N		
101	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	INDONESIA	ID	IDN	ASIA	\N							\N		
102	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	IRAN	IR	IRN	MIDE	\N							\N		
103	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	IRAQ	IQ	IRQ	MIDE	\N							\N		
104	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	IRELAND	IE	IRL	EUR	\N							\N		
105	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ISRAEL	IL	ISR	MIDE	\N							\N		
106	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ITALY	IT	ITA	EUR	\N							\N		
107	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	JAMAICA	JM	JAM	CARI	\N							\N		
108	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	JAPAN	JP	JPN	ASIA	\N							\N		
109	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	JORDAN	JO	JOR	MIDE	\N							\N		
110	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	KAZAKHSTAN	KZ	KAZ	USSR	\N							\N		
111	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	KENYA	KE	KEN	AFRE	\N							\N		
112	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	KIRIBATI	KI	KIR	OPAC	\N							\N		
113	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	KOREA, NORTH	KP	PRK	ASIA	\N							\N		
114	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	KOREA, SOUTH	KR	KOR	ASIA	\N							\N		
115	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	KUWAIT	KW	KWT	MIDE	\N							\N		
116	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	KYRGYZSTAN	KG	KGZ	USSR	\N							\N		
117	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	LAOS	LA	LAO	ASIA	\N							\N		
118	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	LATVIA	LV	LVA	EUR	\N							\N		
119	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	LEBANON	LB	LBN	MIDE	\N							\N		
120	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	LESOTHO	LS	LSO	AFRS	\N							\N		
121	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	LIBERIA	LR	LBR	AFRW	\N							\N		
122	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	LIBYA	LY	LBY	AFRN	\N							\N		
123	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	LIECHTENSTEIN	LI	LIE	EUR	\N							\N		
124	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	LITHUANIA	LT	LTU	EUR	\N							\N		
125	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	LUXEMBOURG	LU	LUX	EUR	\N							\N		
126	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MACAO	MO	MAC	ASIA	\N							\N		
127	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MACEDONIA	MK	MKD	EUR	\N							\N		
128	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MADAGASCAR	MG	MDG	OIND	\N							\N		
129	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MALAWI	MW	MWI	AFRS	\N							\N		
130	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MALAYSIA	MY	MYS	ASIA	\N							\N		
131	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MALDIVES	MV	MDV	OIND	\N							\N		
132	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MALI	ML	MLI	AFRW	\N							\N		
133	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MALTA	MT	MLT	EUR	\N							\N		
134	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MARSHALL ISLANDS	MH	MHL	OPAC	\N							\N		
135	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MARTINIQUE	MQ	MTQ	CARI	\N							\N		
136	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MAURITANIA	MR	MRT	AFRW	\N							\N		
137	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MAURITIUS	MU	MUS	OIND	\N							\N		
138	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MAYOTTE	YT	MYT	OIND	\N							\N		
139	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MEXICO	MX	MEX	AMEC	\N							\N		
140	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MICRONESIA	FM	FSM	PACI	\N							\N		
141	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MOLDOVA	MD	MDA	EUR	\N							\N		
142	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MONACO	MC	MCO	EUR	\N							\N		
143	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MONGOLIA	MN	MNG	ASIA	\N							\N		
144	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MONTSERRAT	MS	MSR	EUR	\N							\N		
145	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MOROCCO	MA	MAR	AFRN	\N							\N		
146	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MOZAMBIQUE	MZ	MOZ	AFRE	\N							\N		
147	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	MYANMAR	MM	MMR	ASIA	\N							\N		
148	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NAMIBIA	NA	NAM	AFRS	\N							\N		
149	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	NAURU	NR	NRU	OPAC	\N							\N		
150	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NEPAL	NP	NPL	ASIA	\N							\N		
151	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NETHERLANDS	NL	NLD	EUR	\N							\N		
152	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NETHERLANDS ANTILLES	AN	ANT	CARI	\N							\N		
153	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NEW CALEDONIA	NC	NCL	PACI	\N							\N		
154	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NEW ZEALAND	NZ	NZL	OCEA	\N							\N		
155	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NICARAGUA	NI	NIC	AMEC	\N							\N		
156	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NIGER	NE	NER	AFR	\N							\N		
157	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NIGERIA	NG	NGA	AFRW	\N							\N		
158	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NIUE	NU	NIU	OPAC	\N							\N		
159	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NORFOLK ISLAND	NF	NFK	PACI	\N							\N		
160	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NORTHERN MARIANA ISLANDS	MP	MNP	OPAC	\N							\N		
161	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	NORWAY	NO	NOR	EUR	\N							\N		
162	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	OMAN	OM	OMN	MIDE	\N							\N		
163	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	PAKISTAN	PK	PAK	ASIA	\N							\N		
164	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	PALAU	PW	PLW	OPAC	\N							\N		
165	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	PALESTINIAN TERRITORY	PS	PSE	MIDE	\N							\N		
166	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	PANAMA	PA	PAN	AMEC	\N							\N		
167	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	PAPUA NEW GUINEA	PG	PNG	OCEA	\N							\N		
168	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	PARAGUAY	PY	PRY	AMEC	\N							\N		
169	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	PERU	PE	PER	AMES	\N							\N		
170	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	PHILIPPINES	PH	PHL	ASIA	\N							\N		
171	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	PITCAIRN	PN	PCN	OPAC	\N							\N		
172	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	POLAND	PL	POL	EUR	\N							\N		
173	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	PORTUGAL	PT	PRT	EUR	\N							\N		
174	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	PUERTO RICO	PR	PRI	CARI	\N							\N		
175	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	QATAR	QA	QAT	MIDE	\N							\N		
176	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	REUNION	RE	REU	OIND	\N							\N		
177	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ROMANIA	RO	ROU	EUR	\N							\N		
178	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	RUSSIA	RU	RUS	USSR	\N							\N		
179	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	RWANDA	RW	RWA	AFRC	\N							\N		
180	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	SAINT KITTS AND NEVIS	KN	KNA	CARI	\N							\N		
181	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SAINT LUCIA	LC	LCA	CARI	\N							\N		
182	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SAINT VINCENT AND THE GRENADINES	VC	VCT	CARI	\N							\N		
183	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SAMOA	WS	WSM	PACI	\N							\N		
184	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	SAN MARINO	SM	SMR	EUR	\N							\N		
185	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SAO TOME AND PRINCIPE	ST	STP	OATS	\N							\N		
186	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SAUDI ARABIA	SA	SAU	MIDE	\N							\N		
187	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SENEGAL	SN	SEN	AFRW	\N							\N		
188	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SEYCHELLES	SC	SYC	OIND	\N							\N		
189	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SIERRA LEONE	SL	SLE	AFR	\N							\N		
190	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SINGAPORE	SG	SGP	ASIA	\N							\N		
191	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SLOVAKIA	SK	SVK	EUR	\N							\N		
192	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SLOVENIA	SI	SVN	EUR	\N							\N		
193	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SOLOMON ISLANDS	SB	SLB	PACI	\N							\N		
194	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SOMALIA	SO	SOM	AFR	\N							\N		
195	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SOUTH AFRICA	ZA	ZAF	AFRS	\N							\N		
196	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS	GS	SGS	USSR	\N							\N		
197	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SPAIN	ES	ESP	EUR	\N							\N		
198	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SRI LANKA	LK	LKA	ASIA	\N							\N		
199	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	ST. HELENA	SH	SHN	OATS	\N							\N		
200	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	ST. PIERRE AND MIQUELON	PM	SPM	OATN	\N							\N		
201	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SUDAN	SD	SDN	AFR	\N							\N		
202	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SURINAME	SR	SUR	AMES	\N							\N		
203	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	SVALBARD AND JAN MAYEN ISLANDS	SJ	SJM	OARC	\N							\N		
204	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SWAZILAND	SZ	SWZ	AFRS	\N							\N		
205	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SWEDEN	SE	SWE	EUR	\N							\N	AFR	
206	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SWITZERLAND	CH	CHE	EUR	\N							\N		
207	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	SYRIA	SY	SYR	MIDE	\N							\N		
208	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	TAIWAN	TW	TWN	ASIA	\N							\N		
209	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	TAJIKISTAN	TJ	TJK	USSR	\N							\N		
210	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	TANZANIA	TZ	TZA	AFRW	\N							\N		
211	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	THAILAND	TH	THA	ASIA	\N							\N		
212	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	TOGO	TG	TGO	AFRW	\N							\N		
213	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	TOKELAU	TK	TKL	OPAC								\N		
214	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	TONGA	TO	TON	PACI	\N							\N		
215	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	TRINIDAD AND TOBAGO	TT	TTO	CARI	\N							\N		
216	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	TUNISIA	TN	TUN	AFRN	\N							\N		
217	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	TURKEY	TR	TUR	EUR	\N							\N		
218	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	TURKMENISTAN	TM	TKM	USSR	\N							\N		
219	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	TURKS AND CAICOS ISLANDS	TC	TCA	CARI								\N		
220	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	TUVALU	TV	TUV	OPAC	\N							\N		
221	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	UGANDA	UG	UGA	AFRE	\N							\N	AFR	
222	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	UKRAINE	UA	UKR	USSR	\N							\N		
223	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	UNITED ARAB EMIRATES	AE	ARE	MIDE	\N							\N		
224	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	UNITED KINGDOM	GB	GBR	EUR	\N					44	<METHOD>PostcodeGBR</METHOD>	\N	GBR	
225	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	UNITED STATES	US	USA	AMEN	\N					1	<METHOD>PostcodeUSA</METHOD>	\N		
226	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	UNITED STATES MINOR OUTLYING ISLANDS	UM	UMI	OPAC	\N							\N		
227	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	URUGUAY	UY	URY	AMEC	\N							\N		
228	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	UZBEKISTAN	UZ	UZB	USSR	\N							\N		
229	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	VANUATU	VU	VUT	PACI	\N							\N		
230	2009-01-01 00:00:00		2009-01-01 00:00:00		0	0	VATICAN CITY	VA	VAT	EUR	\N							\N		
231	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	VENEZUELA	VE	VEN	AMES	\N							\N		
232	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	VIETNAM	VN	VNM	ASIA	\N							\N		
233	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	VIRGIN ISLANDS (BRITISH)	VG	VGB	CARI	\N							\N		
234	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	VIRGIN ISLANDS (U.S.)	VI	VIR	CARI	\N							\N		
235	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	WALLIS AND FUTUNA ISLANDS	WF	WLF	OPAC								\N		
236	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	WESTERN SAHARA	EH	ESH	AFRN	\N							\N		
237	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	YEMEN	YE	YEM	MIDE	\N							\N		
238	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	YUGOSLAVIA	YU	YUG	EUR	\N							\N		
239	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ZAMBIA	ZM	ZMB	AFRE	\N							\N		
240	2009-01-01 00:00:00		2009-01-01 00:00:00		0	1	ZIMBABWE	ZW	ZWE	AFRE	\N							\N		
\.


--
-- Data for Name: entextorganisations; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.entextorganisations (eo_seq, eo_mec_id, eo_name, eo_addr_bill, eo_addr_ship, eo_contact, eo_phone, eo_fax, eo_email, eo_instructions, eo_cwhen, eo_cby, eo_mwhen, eo_mby, eo_comment, eo_company_no, eo_vat_no, eo_mcount, eo_addr_building, eo_addr_street, eo_addr_locality, eo_addr_town, eo_addr_state, eo_addr_postcode, eo_co_iso3_ref, eo_mobile) FROM stdin;
\.


--
-- Data for Name: entgrouporganisations; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.entgrouporganisations (go_seq, go_cwhen, go_cby, go_mwhen, go_mby, go_mcount, go_name_full, go_name_short, go_addr_building, go_addr_street, go_addr_locality, go_addr_town, go_addr_state, go_addr_postcode, go_addr_country, go_comm_ph, go_comm_mob, go_comm_email, go_company_no, go_vat_no, go_currency, go_mec_id, go_mec_type, go_rrs, go_ddn_ap1, go_ddn_ap2, go_surname, go_firstnames, go_name_ltbc, go_dob, go_sex, go_mmn, go_id_type, go_id_code, go_mc_listid, go_report_to_go_ref, go_report_to_percent) FROM stdin;
20	2014-12-15 16:57:22	mostynrs	2015-01-23 15:51:33	mostynrs	0	\N	HW	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0.0000
\.


--
-- Data for Name: entgrouporgnames; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.entgrouporgnames (gon_seq, gon_cwhen, gon_cby, gon_mwhen, gon_mby, gon_mcount, gon_go_ref, gon_name_full, gon_type) FROM stdin;
2	2017-03-06 12:02:55	stevensg	2017-03-06 12:02:55	stevensg	0	20	Hello World Ltd.	I
\.


--
-- Data for Name: entgrouporgstructure; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.entgrouporgstructure (gs_seq, gs_cwhen, gs_cby, gs_mwhen, gs_mby, gs_mcount, gs_go_ref, gs_superior_gs_ref, gs_order, gs_active, gs_desc_short, gs_desc_full, gs_type) FROM stdin;
\.


--
-- Data for Name: entorglinks; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.entorglinks (eol_seq, eol_go_ref, eol_eo_ref, eol_finacct_cuid, eol_finacct_suid, eol_cwhen, eol_cby, eol_mwhen, eol_mby, eol_mcount) FROM stdin;
\.


--
-- Data for Name: fininvoiceoutchain; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.fininvoiceoutchain (foc_seq, foc_foh_ref_prev, foc_foh_ref_next) FROM stdin;
\.


--
-- Data for Name: fininvoiceoutd; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.fininvoiceoutd (fod_seq, fod_foh_ref, fod_prd_ref, fod_desc, fod_unit_price, fod_unit_tax, fod_qty, fod_order, fod_cwhen, fod_cby, fod_mwhen, fod_mby, fod_mcount) FROM stdin;
\.


--
-- Data for Name: fininvoiceouth; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.fininvoiceouth (foh_seq, foh_go_ref, foh_eo_ref, foh_inv_no, foh_addr_ship, foh_addr_bill, foh_cust_name, foh_date, foh_instructions, foh_status, foh_cust_po, foh_currency, foh_swhen, foh_cwhen, foh_cby, foh_mwhen, foh_mby, foh_mcount, foh_mec_id) FROM stdin;
\.


--
-- Data for Name: generictranslations; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.generictranslations (gt_seq, gt_ft_prefix, gt_ft_ref, gt_lang_code, gt_name_lang, gt_desc_lang, gt_cwhen, gt_cby, gt_mwhen, gt_mby, gt_mcount) FROM stdin;
\.


--
-- Data for Name: importtemplate; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.importtemplate (imt_seq, imt_cwhen, imt_cby, imt_mwhen, imt_mby, imt_mcount, imt_go_ref, imt_usr_ref, imt_name, imt_schema, imt_col_count, imt_imp_flags, imt_col_order, imt_sep_thou, imt_sep_dec, imt_fmt_date, imt_header, imt_last_used, imt_ignore_rows) FROM stdin;
\.


--
-- Data for Name: langcountry; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.langcountry (lc_seq, lc_lg_ref, lc_co_ref_iso3, lc_lgref_iso3, lc_co_exonym, lc_co_endonym, lc_capital_exonym, lc_capital_endonym, lc_official, lc_mainlang, lc_country_translit_endonym, lc_capital_translit_endonym, lc_cwhen, lc_cby, lc_mwhen, lc_mby, lc_mcount, lc_co_ref) FROM stdin;
565	559	AFG	pus	AFGHANISTAN	افغانستان	KABUL	كابل	1	1	Afghanestan	Kabul	2000-01-01 00:00:00		2000-01-01 00:00:00		0	1
566	433	ALB	sqi	ALBANIA	Shqipëria	TIRANA	Tiranë	1	1	Shqipëria	Tiranë	2000-01-01 00:00:00		2000-01-01 00:00:00		0	2
567	434	DZA	ara	ALGERIA	الجزائر	ALGIERS	الجزائر	1	1	Al-Jazā'ir	Al-Jazā'ir	2000-01-01 00:00:00		2000-01-01 00:00:00		0	3
568	435	ASM	smo	AMERICAN SAMOA	Samoa	PAGO PAGO	Pago Pago	1	1	Samoa	Pago Pago	2000-01-01 00:00:00		2000-01-01 00:00:00		0	4
569	436	ASM	eng	AMERICAN SAMOA	American Samoa	PAGO PAGO	Pago Pago	1	0	American Samoa	Pago Pago	2000-01-01 00:00:00		2000-01-01 00:00:00		0	4
570	437	AND	cat	ANDORRA	Andorra	ANDORRA LA VELLA	Andorra la Vella	1	1	Andorra	Andorra la Vella	2000-01-01 00:00:00		2000-01-01 00:00:00		0	5
571	438	AGO	por	ANGOLA	Angola	LUANDA	Luanda	1	1	Angola	Luanda	2000-01-01 00:00:00		2000-01-01 00:00:00		0	6
849	436	VUT	eng	VANUATU	Vanuatu	PORT VILA	Port-Vila	1	1	Vanuatu	Port-Vila	2000-01-01 00:00:00		2000-01-01 00:00:00		0	229
572	436	AIA	eng	ANGUILLA	The Valley	THE VALLEY	The Valley	1	1	Anguilla	The Valley	2000-01-01 00:00:00		2000-01-01 00:00:00		0	7
573	436	ATG	eng	ANTIGUA AND BARBUDA	Saint John's	SAINT JOHN'S	Saint John's	1	1	Antigua And Barbuda	Saint John's	2000-01-01 00:00:00		2000-01-01 00:00:00		0	9
574	439	ARG	spa	ARGENTINA	Argentina	BUENOS AIRES	Ciudad de Buenos Aires	1	1	Argentina	Ciudad de Buenos Aires	2000-01-01 00:00:00		2000-01-01 00:00:00		0	10
575	440	ARM	hye	ARMENIA	Հայաստան	YEREVAN	Երևան	1	1	Hayastán	Yerevan	2000-01-01 00:00:00		2000-01-01 00:00:00		0	11
576	441	ABW	nld	ARUBA	Oranjestad	ORANJESTAD	Oranjestad	1	1	Aruba	Oranjestad	2000-01-01 00:00:00		2000-01-01 00:00:00		0	12
577	436	AUS	eng	AUSTRALIA	Australia	CANBERRA	Canberra	1	1	Australia	Canberra	2000-01-01 00:00:00		2000-01-01 00:00:00		0	13
578	442	AUT	deu	AUSTRIA	Österreich	VIENNA	Wien	1	1	Österreich	Wien	2000-01-01 00:00:00		2000-01-01 00:00:00		0	14
579	443	AZE	aze	AZERBAIJAN	Azərbaycan	BAKU	Baku	1	1	Azərbaycan	Bakı	2000-01-01 00:00:00		2000-01-01 00:00:00		0	15
580	436	BHS	eng	BAHAMAS	Bahamas	NASSAU	Nassau	1	1	Bahamas	Nassau	2000-01-01 00:00:00		2000-01-01 00:00:00		0	16
581	434	BHR	ara	BAHRAIN	البحرين	MANAMA	المنامة	1	1	Al-Bahrayn	Al-Manāmah	2000-01-01 00:00:00		2000-01-01 00:00:00		0	17
582	444	BGD	ben	BANGLADESH	বাংলাদেশ	DHAKA	ঢাকা	1	1	Bānglādesh	Dhaka	2000-01-01 00:00:00		2000-01-01 00:00:00		0	18
583	436	BRB	eng	BARBADOS	Barbados	BRIDGETOWN	Bridgetown	1	1	Barbados	Bridgetown	2000-01-01 00:00:00		2000-01-01 00:00:00		0	19
584	445	BLR	bel	BELARUS	Белару́сь	MINSK	Менск or Мінск	1	1	Belarus’	Mensk or Minsk	2000-01-01 00:00:00		2000-01-01 00:00:00		0	20
585	446	BLR	rus	BELARUS	Белору́ссия	MINSK	Минск	1	0	Belorussiya or Belorussiâ	Minsk	2000-01-01 00:00:00		2000-01-01 00:00:00		0	20
586	441	BEL	nld	BELGIUM	België	BRUSSELS	Brussel	1	1	België	Brussel	2000-01-01 00:00:00		2000-01-01 00:00:00		0	21
587	447	BEL	fra	BELGIUM	Belgique	BRUSSELS	Bruxelles	1	0	Belgique	Bruxelles	2000-01-01 00:00:00		2000-01-01 00:00:00		0	21
588	442	BEL	deu	BELGIUM	Belgien	BRUSSELS	Brüssel	1	0	Belgien	Brüssel	2000-01-01 00:00:00		2000-01-01 00:00:00		0	21
589	436	BLZ	eng	BELIZE	Belize	BELMOPAN	Belmopan	1	1	Belize	Belmopan	2000-01-01 00:00:00		2000-01-01 00:00:00		0	22
590	447	BEN	fra	BENIN	Bénin	PORTO-NOVO	Porto-Novo	1	1	Bénin	Porto-Novo	2000-01-01 00:00:00		2000-01-01 00:00:00		0	23
591	436	BMU	eng	BERMUDA	Bermuda	HAMILTON	Hamilton	1	1	Bermuda	Hamilton	2000-01-01 00:00:00		2000-01-01 00:00:00		0	24
592	448	BTN	dzo	BHUTAN	Druk Yul	THIMPHU	Thimphu	1	1	Druk Yul	Thimphu	2000-01-01 00:00:00		2000-01-01 00:00:00		0	25
593	439	BOL	spa	BOLIVIA	Bolivia	LA PAZ	La Paz	1	1	Bolivia	La Paz	2000-01-01 00:00:00		2000-01-01 00:00:00		0	26
594	436	BWA	eng	BOTSWANA	Botswana	GABORONE	Gaborone	1	1	Botswana	Gaborone	2000-01-01 00:00:00		2000-01-01 00:00:00		0	28
595	438	BRA	por	BRAZIL	Brasil	BRASILIA	Brasília	1	1	Brasil	Brasília	2000-01-01 00:00:00		2000-01-01 00:00:00		0	30
596	449	BGR	bul	BULGARIA	България	SOFIA	София	1	1	Bulgariya or Bălgarija	Sofiya or Sofija	2000-01-01 00:00:00		2000-01-01 00:00:00		0	33
597	447	BFA	fra	BURKINA FASO	Burkina Faso	OUAGADOUGOU	Ouagadougou	1	1	Burkina Faso	Ouagadougou	2000-01-01 00:00:00		2000-01-01 00:00:00		0	34
598	450	BDI		BURUNDI	Burundi	BUJUMBURA	Bujumbura	1	1	Burundi	Bujumbura	2000-01-01 00:00:00		2000-01-01 00:00:00		0	35
599	451	KHM		CAMBODIA	Kampuchea	PHNOM PENH	Phnom Penh	1	1	Kampuchea	Phnom Penh	2000-01-01 00:00:00		2000-01-01 00:00:00		0	36
600	447	CMR	fra	CAMEROON	Cameroun	YAOUNDÉ	Yaoundé	1	1	Cameroun	Yaoundé	2000-01-01 00:00:00		2000-01-01 00:00:00		0	37
601	436	CMR	eng	CAMEROON	Cameroon	YAOUNDÉ	Yaoundé	1	0	Cameroon	Yaoundé	2000-01-01 00:00:00		2000-01-01 00:00:00		0	37
602	436	CAN	eng	CANADA	Canada	OTTAWA	Ottawa	1	1	Canada	Ottawa	2000-01-01 00:00:00		2000-01-01 00:00:00		0	38
603	447	CAN	fra	CANADA	Canada	OTTAWA	Ottawa	1	0	Canada	Ottawa	2000-01-01 00:00:00		2000-01-01 00:00:00		0	38
604	438	CPV	por	CAPE VERDE	Cabo Verde	PRAIA	Praia	1	1	Cabo Verde	Praia	2000-01-01 00:00:00		2000-01-01 00:00:00		0	39
605	436	CYM	eng	CAYMAN ISLANDS	Cayman Islands	GEORGE TOWN	George Town	1	1	Cayman Islands	George Town	2000-01-01 00:00:00		2000-01-01 00:00:00		0	40
606	447	CAF	fra	CENTRAL AFRICAN REPUBLIC	République Centrafricaine	BANGUI	Bangui	1	1	République Centrafricaine	Bangui	2000-01-01 00:00:00		2000-01-01 00:00:00		0	41
607	447	TCD	fra	CHAD	Tchad	N'DJAMENA	Ndjamena	1	0	Tchad	Ndjamena	2000-01-01 00:00:00		2000-01-01 00:00:00		0	42
608	434	TCD	ara	CHAD	تشاد	N'DJAMENA	نجامينا	1	1	تشاد	نجامينا	2000-01-01 00:00:00		2000-01-01 00:00:00		0	42
609	439	CHL	spa	CHILE	Chile	SANTIAGO	Santiago	1	1	Chile	Santiago	2000-01-01 00:00:00		2000-01-01 00:00:00		0	43
610	436	CXR	eng	CHRISTMAS ISLAND	Christmas Island	THE SETTLEMENT	The Settlement	1	1	Christmas Island	The Settlement	2000-01-01 00:00:00		2000-01-01 00:00:00		0	45
611	439	COL	spa	COLOMBIA	Colombia	BOGOTÁ	Bogotá	1	1	Colombia	Bogotá	2000-01-01 00:00:00		2000-01-01 00:00:00		0	47
612	452	COM		COMOROS	Komori	MORONI	Moroni	1	1	Komori	Moroni	2000-01-01 00:00:00		2000-01-01 00:00:00		0	48
613	434	COM	ara	COMOROS	جزر القمر	MORONI	موروني	1	0	Comoros	Moroni	2000-01-01 00:00:00		2000-01-01 00:00:00		0	48
614	447	COM	fra	COMOROS	Comores	MORONI	Moroni	1	0	Comores	Moroni	2000-01-01 00:00:00		2000-01-01 00:00:00		0	48
615	436	COK	eng	COOK ISLANDS	Cook Islands	AVARUA	Avarua	1	1	Cook Islands	Avarua	2000-01-01 00:00:00		2000-01-01 00:00:00		0	51
616	439	CRI	spa	COSTA RICA	Costa Rica	SAN JOSÉ	San José	1	1	Costa Rica	San José	2000-01-01 00:00:00		2000-01-01 00:00:00		0	52
617	439	CUB	spa	CUBA	Cuba	HAVANA	La Habana	1	1	Cuba	La Habana	2000-01-01 00:00:00		2000-01-01 00:00:00		0	55
618	453	CYP	ell	CYPRUS	Κυπρος	NICOSIA	Λευκωσία	1	1	Kypros	Levkòsia	2000-01-01 00:00:00		2000-01-01 00:00:00		0	56
619	454	CYP	tur	CYPRUS	Kıbrıs	NICOSIA	Lefkoşa	1	1	Kıbrıs	Lefkoşa	2000-01-01 00:00:00		2000-01-01 00:00:00		0	56
620	455	CZE	ces	CZECH REPUBLIC	Česká republika	PRAGUE	Praha	1	1	Česká republika	Praha	2000-01-01 00:00:00		2000-01-01 00:00:00		0	57
621	456	DNK	dan	DENMARK	Danmark	COPENHAGEN	København	1	1	Danmark	København	2000-01-01 00:00:00		2000-01-01 00:00:00		0	58
622	434	DJI	ara	DJIBOUTI	جيبوتي	DJIBOUTI CITY	جيبوتي	1	1	Jībūtī	Jībūtī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	59
623	447	DJI	fra	DJIBOUTI	Djibouti	DJIBOUTI CITY	Djibouti	1	0	Djibouti	Djibouti	2000-01-01 00:00:00		2000-01-01 00:00:00		0	59
624	436	DMA	eng	DOMINICA	Dominica	ROSEAU	Roseau	1	1	Dominica	Roseau	2000-01-01 00:00:00		2000-01-01 00:00:00		0	60
858	560	IRN	fas	IRAN	ایران	TEHRAN	تهران	1	1	Īrān	Tehrān	2000-01-01 00:00:00		2000-01-01 00:00:00		0	102
625	439	DOM	spa	DOMINICAN REPUBLIC	República Dominicana	SANTO DOMINGO	Santo Domingo	1	1	República Dominicana	Santo Domingo	2000-01-01 00:00:00		2000-01-01 00:00:00		0	61
626	457	TLS	tet	EAST TIMOR	Timor Lorosa'e	DÍLI	Díli	1	1	Timor Lorosa'e	Díli	2000-01-01 00:00:00		2000-01-01 00:00:00		0	62
627	438	TLS	por	EAST TIMOR	Timor-Leste	DÍLI	Díli	1	0	Timor-Leste	Díli	2000-01-01 00:00:00		2000-01-01 00:00:00		0	62
628	439	ECU	spa	ECUADOR	Ecuador	QUITO	Quito	1	1	Ecuador	Quito	2000-01-01 00:00:00		2000-01-01 00:00:00		0	63
629	434	EGY	ara	EGYPT	مصر	CAIRO	القاهرة	1	1	Mişr or Maşr	Al-Qāhirah	2000-01-01 00:00:00		2000-01-01 00:00:00		0	64
630	439	SLV	spa	EL SALVADOR	El Salvador	SAN SALVADOR	San Salvador	1	1	El Salvador	San Salvador	2000-01-01 00:00:00		2000-01-01 00:00:00		0	65
631	439	GNQ	spa	EQUATORIAL GUINEA	Guinea Ecuatorial	MALABO	Malabo	1	1	Guinea Ecuatorial	Malabo	2000-01-01 00:00:00		2000-01-01 00:00:00		0	66
632	434	ERI	ara	ERITREA	إرتريا	ASMARA	أسمرا	1	1	Iritriya	Asmaraa	2000-01-01 00:00:00		2000-01-01 00:00:00		0	67
633	458	ERI	tir	ERITREA	ኤርትራ	ASMARA	አሥመራ	1	0	Erta	Asmära	2000-01-01 00:00:00		2000-01-01 00:00:00		0	67
634	459	EST	est	ESTONIA	Eesti	TALLINN	Tallinn	1	1	Eesti	Tallinn	2000-01-01 00:00:00		2000-01-01 00:00:00		0	68
635	460	ETH	amh	ETHIOPIA	ኢትዮጲያ	ADDIS ABABA	አዲስ አበባ	1	1	Ityop'ia	Addis Abäba	2000-01-01 00:00:00		2000-01-01 00:00:00		0	69
636	461	FRO	fao	FAROE ISLANDS	Føroyar	TÓRSHAVN	Tórshavn	1	1	Føroyar	Tórshavn	2000-01-01 00:00:00		2000-01-01 00:00:00		0	71
637	436	FJI	eng	FIJI	Fiji	SUVA	Suva	1	1	Fiji	Suva	2000-01-01 00:00:00		2000-01-01 00:00:00		0	72
638	462	FJI	fij	FIJI	Fiji	SUVA	Suva	1	0	Fiji	Suva	2000-01-01 00:00:00		2000-01-01 00:00:00		0	72
639	463	FJI		FIJI	Fiji	SUVA	Suva	1	0	Fiji	Suva	2000-01-01 00:00:00		2000-01-01 00:00:00		0	72
640	464	FIN	fin	FINLAND	Suomi	HELSINKI	Helsinki	1	1	Suomi	Helsinki	2000-01-01 00:00:00		2000-01-01 00:00:00		0	73
641	465	FIN	swe	FINLAND	Finland	HELSINKI	Helsingfors	1	0	Finland	Helsingfors	2000-01-01 00:00:00		2000-01-01 00:00:00		0	73
642	447	FRA	fra	FRANCE	France	PARIS	Paris	1	1	France	Paris	2000-01-01 00:00:00		2000-01-01 00:00:00		0	74
643	447	GUF	fra	FRENCH GUIANA	Guyane	CAYENNE	Cayenne	1	1	Guyane	Cayenne	2000-01-01 00:00:00		2000-01-01 00:00:00		0	76
644	447	PYF	fra	FRENCH POLYNESIA	Polynésie Française	PAPEETE	Papeete	1	1	Polynésie Française	Papeete	2000-01-01 00:00:00		2000-01-01 00:00:00		0	77
645	447	GAB	fra	GABON	Gabon	LIBREVILLE	Libreville	1	1	Gabon	Libreville	2000-01-01 00:00:00		2000-01-01 00:00:00		0	79
646	436	GMB	eng	GAMBIA	Gambia	BANJUL	Banjul	1	1	Gambia	Banjul	2000-01-01 00:00:00		2000-01-01 00:00:00		0	80
647	466	GEO	kat	GEORGIA	საქართველო	T'BILISI	თბილისი	1	1	Sak'art'velo	T'bilisi	2000-01-01 00:00:00		2000-01-01 00:00:00		0	81
648	442	DEU	deu	GERMANY	Deutschland	BERLIN	Berlin	1	1	Deutschland	Berlin	2000-01-01 00:00:00		2000-01-01 00:00:00		0	82
649	436	GHA	eng	GHANA	Ghana	ACCRA	Accra	1	1	Ghana	Accra	2000-01-01 00:00:00		2000-01-01 00:00:00		0	83
650	436	GIB	eng	GIBRALTAR	Gibraltar	GIBRALTAR	Gibraltar	1	1	Gibraltar	Gibraltar	2000-01-01 00:00:00		2000-01-01 00:00:00		0	84
651	453	GRC	ell	GREECE	Ελλάς	ATHENS	Αθήναι	1	1	Hellas	Athinai	2000-01-01 00:00:00		2000-01-01 00:00:00		0	85
652	467	GRL	kal	GREENLAND	Kalaallit Nunaat	NUUK	Nuuk	1	0	Kalaallit Nunaat	Nuuk	2000-01-01 00:00:00		2000-01-01 00:00:00		0	86
653	456	GRL	dan	GREENLAND	Grønland	NUUK	Godthåb	1	1	Grønland	Godthåb	2000-01-01 00:00:00		2000-01-01 00:00:00		0	86
654	436	GRD	eng	GRENADA	Grenada	SAINT GEORGE'S	Saint George's	1	1	Grenada	Saint George's	2000-01-01 00:00:00		2000-01-01 00:00:00		0	87
655	447	GLP	fra	GUADELOUPE	Guadeloupe	BASSE-TERRE	Basse-Terre	1	1	Guadeloupe	Basse-Terre	2000-01-01 00:00:00		2000-01-01 00:00:00		0	88
656	436	GUM	eng	GUAM	Guam	HAGÅTÑA	Hagåtña	1	1	Guam	Hagåtña	2000-01-01 00:00:00		2000-01-01 00:00:00		0	89
657	439	GTM	spa	GUATEMALA	Guatemala	GUATEMALA CITY	La Nueva Guatemala de la Asunción	1	1	Guatemala	La Nueva Guatemala de la Asunción	2000-01-01 00:00:00		2000-01-01 00:00:00		0	90
658	447	GIN	fra	GUINEA	Guinée	CONAKRY	Konakry	1	1	Guinée	Konakry	2000-01-01 00:00:00		2000-01-01 00:00:00		0	91
659	438	GNB	por	GUINEA-BISSAU	Guiné-Bissau	BISSAU	Bissau	1	1	Guiné-Bissau	Bissau	2000-01-01 00:00:00		2000-01-01 00:00:00		0	92
660	436	GUY	eng	GUYANA	Guyana	GEORGETOWN	Georgetown	1	1	Guyana	Georgetown	2000-01-01 00:00:00		2000-01-01 00:00:00		0	93
661	447	HTI	fra	HAITI	Haiti	PORT-AU-PRINCE	Port-Au-Prince	1	1	Haiti	Port-Au-Prince	2000-01-01 00:00:00		2000-01-01 00:00:00		0	94
662	439	HND	spa	HONDURAS	Honduras	TEGUCIGALPA	Tegucigalpa	1	1	Honduras	Tegucigalpa	2000-01-01 00:00:00		2000-01-01 00:00:00		0	96
663	436	HKG	eng	HONG KONG	Hong Kong	HONG KONG	Hong Kong	1	1	Hong Kong	Hong Kong	2000-01-01 00:00:00		2000-01-01 00:00:00		0	97
664	468	HKG		HONG KONG	香港	HONG KONG	香港	1	1	Hong Kong	Hong Kong	2000-01-01 00:00:00		2000-01-01 00:00:00		0	97
665	469	HUN	hun	HUNGARY	Magyarország	BUDAPEST	Budapest	1	1	Magyarország	Budapest	2000-01-01 00:00:00		2000-01-01 00:00:00		0	98
666	470	ISL	isl	ICELAND	Ísland	REYKJAVÍK	Reykjavík	1	1	Ísland	Reykjavík	2000-01-01 00:00:00		2000-01-01 00:00:00		0	99
667	471	IND	asm	INDIA	ভাৰত	NEW DELHI	নয়া দিল্লী	1	0	Bhārôt	Nôyā Dillī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
668	444	IND	ben	INDIA	ভারত	NEW DELHI	নয়া দিল্লী	1	1	Bhārôt	Nôyā Dillī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
669	436	IND	eng	INDIA	India	NEW DELHI	New Delhi	1	0	India	New Delhi	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
670	472	IND	guj	INDIA	ભારત	NEW DELHI	નવી દિલ્હી	1	1	Bhārat	Navī Dilhī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
671	473	IND	hin	INDIA	भारत, हिंदुस्तान	NEW DELHI	नई दिल्ली	1	1	Bhārat, Hindustān	Naī Dillī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
672	474	IND	kan	INDIA	ಭಾರತ	NEW DELHI	ನವ ದೆಹಲಿ	1	1	Bhārata	Nava Dehali	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
673	475	IND	kas	INDIA	ہندوستان	NEW DELHI	دِلى	1	0	Hindōstān	Dilī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
674	476	IND		INDIA	भारत	NEW DELHI	नवी दिल्ली	1	0	Bhārat	Navī Dillī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
729	447	MYT	fra	MAYOTTE	Mayotte	MAMOUDZOU	Mamoudzou	1	1	Mayotte	Mamoudzou	2000-01-01 00:00:00		2000-01-01 00:00:00		0	138
675	477	IND	mal	INDIA	ഇന്ത്യ, ഭാരതം	NEW DELHI	ന്യൂഡല്ഹി	1	1	Inḍya, Bhāratam	Nyūḍalhi	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
883	438	MAC	por	MACAO	Macau	NONE	None	1	0	Macau	None	2000-01-01 00:00:00		2000-01-01 00:00:00		0	126
676	478	IND	mar	INDIA	भारत	NEW DELHI	नवी दिल्ली	1	1	Bhārat	Navī Dillī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
677	479	IND	nep	INDIA	भारत	NEW DELHI		1	0	Bhārat		2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
678	480	IND	ori	INDIA	ଭାରତ	NEW DELHI	ନୂଆଦିଲ୍ଲୀ	1	0	Bhārôtô	Nūādillī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
679	481	IND	pan	INDIA	ਭਾਰਤ, ਹਿੰਦੁਸਤਾਨ	NEW DELHI	ਨਵੀਂ ਦਿੱਲੀ	1	0	Bhārat, Hindustān	Navīñ Dillī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
680	482	IND	san	INDIA	भारतम्	NEW DELHI	दिल्ली	1	0	Bhāratam	Dillī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
681	483	IND	snd	INDIA	ڀارت، هندستان	NEW DELHI	نئين دهلي	1	0	Bhāratu, Hindustānu	Puduḍilli	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
682	484	IND	tam	INDIA	இந்தியா, பாரத	NEW DELHI	புதுடில்லி	1	1	Indiyā, Bārata	Puduḍilli	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
683	485	IND	tel	INDIA	భారత దేశం, ఇండియా	NEW DELHI	న్యూఢిల్లీ	1	1	Bhāratadēsham, Inḍiyā	Nyūḍhillī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
684	486	IND	urd	INDIA	ہندوستان، بھارت	NEW DELHI	نئی دہلی، نئی دلی	1	1	Hindostān, Bhārat	Naī Dĕhlī, Naī Dillī	2000-01-01 00:00:00		2000-01-01 00:00:00		0	100
685	487	IDN	ind	INDONESIA	Indonesia	JAKARTA	Jakarta	1	1	Indonesia	Jakarta	2000-01-01 00:00:00		2000-01-01 00:00:00		0	101
686	434	IRQ	ara	IRAQ	العراق	BAGHDAD	بغداد	1	1	Al-'Iraq	Baghdad	2000-01-01 00:00:00		2000-01-01 00:00:00		0	103
687	488	IRL	gle	IRELAND	Éire	DUBLIN	Baile Átha Cliath	1	0	Éire	Baile Átha Cliath	2000-01-01 00:00:00		2000-01-01 00:00:00		0	104
688	436	IRL	eng	IRELAND	Ireland	DUBLIN	Dublin	1	1	Ireland	Dublin	2000-01-01 00:00:00		2000-01-01 00:00:00		0	104
689	489	ISR	heb	ISRAEL	ישראל	JERUSALEM	ירושלים	1	1	Yisra'el	Yerushaláyim	2000-01-01 00:00:00		2000-01-01 00:00:00		0	105
690	434	ISR	ara	ISRAEL	اسرائيل	JERUSALEM	اورشليم	1	0	Isra'il	Ūršalīm	2000-01-01 00:00:00		2000-01-01 00:00:00		0	105
691	490	ITA	ita	ITALY	Italia	ROME	Roma	1	1	Italia	Roma	2000-01-01 00:00:00		2000-01-01 00:00:00		0	106
692	436	JAM	eng	JAMAICA	Jamaica	KINGSTON	Kingston	1	1	Jamaica	Kingston	2000-01-01 00:00:00		2000-01-01 00:00:00		0	107
693	491	JPN	jpn	JAPAN	日本	TOKYO	東京	1	1	Nippon or Nihon	Tōkyō	2000-01-01 00:00:00		2000-01-01 00:00:00		0	108
694	434	JOR	ara	JORDAN	الأردن	AMMAN	عمان	1	1	Al-'Urdun	Ammān	2000-01-01 00:00:00		2000-01-01 00:00:00		0	109
695	492	KAZ	kaz	KAZAKHSTAN	Қазақстан	ASTANA	Астана	1	1	Qazaqstan	Astana	2000-01-01 00:00:00		2000-01-01 00:00:00		0	110
696	446	KAZ	rus	KAZAKHSTAN	Казахстан	ASTANA	Астана	1	0	Kazakhstán	Astana	2000-01-01 00:00:00		2000-01-01 00:00:00		0	110
697	436	KEN	eng	KENYA	Kenya	NAIROBI	Nairobi	1	1	Kenya	Nairobi	2000-01-01 00:00:00		2000-01-01 00:00:00		0	111
698	494	KEN	swa	KENYA	Kenya	NAIROBI	Nairobi	1	0	Kenya	Nairobi	2000-01-01 00:00:00		2000-01-01 00:00:00		0	111
699	436	KIR	eng	KIRIBATI	Kiribati	SOUTH TARAWA	South Tarawa	1	1	Kiribati	South Tarawa	2000-01-01 00:00:00		2000-01-01 00:00:00		0	112
700	495	KIR	gil	KIRIBATI	Kiribati	SOUTH TARAWA	South Tarawa	1	0	Kiribati	South Tarawa	2000-01-01 00:00:00		2000-01-01 00:00:00		0	112
701	434	KWT	ara	KUWAIT	الكويت	KUWAIT CITY	الكويت	1	1	Al-Kuwayt	Al-Kuwait	2000-01-01 00:00:00		2000-01-01 00:00:00		0	115
702	496	KGZ	kir	KYRGYZSTAN	Кыргызстан	BISHKEK	Бишкек	1	1	Kyrgyzstan	Bishkek	2000-01-01 00:00:00		2000-01-01 00:00:00		0	116
703	446	KGZ	rus	KYRGYZSTAN	Киргизия	BISHKEK	Бишкек	1	0	Kirgizija	Bishkek	2000-01-01 00:00:00		2000-01-01 00:00:00		0	116
704	497	LVA	lav	LATVIA	Latvija	RIGA	Rīga	1	1	Latvija	Rīga	2000-01-01 00:00:00		2000-01-01 00:00:00		0	118
705	434	LBN	ara	LEBANON	لبنان	BEIRUT	بيروت	1	1	Lubnan	Bayrût	2000-01-01 00:00:00		2000-01-01 00:00:00		0	119
706	498	LSO		LESOTHO	Lesotho	MASERU	Maseru	1	0	Lesotho	Maseru	2000-01-01 00:00:00		2000-01-01 00:00:00		0	120
707	436	LSO	eng	LESOTHO	Lesotho	MASERU	Maseru	1	1	Lesotho	Maseru	2000-01-01 00:00:00		2000-01-01 00:00:00		0	120
708	436	LBR	eng	LIBERIA	Liberia	MONROVIA	Monrovia	1	1	Liberia	Monrovia	2000-01-01 00:00:00		2000-01-01 00:00:00		0	121
709	442	LIE	deu	LIECHTENSTEIN	Liechtenstein	VADUZ	Vaduz	1	1	Liechtenstein	Vaduz	2000-01-01 00:00:00		2000-01-01 00:00:00		0	123
710	499	LTU	lit	LITHUANIA	Lietuva	VILNIUS	Vilnius	1	1	Lietuva	Vilnius	2000-01-01 00:00:00		2000-01-01 00:00:00		0	124
711	500	LUX	ltz	LUXEMBOURG	Lëtzebuerg	LUXEMBOURG	Lëtzebuerg	1	0	Lëtzebuerg	Lëtzebuerg	2000-01-01 00:00:00		2000-01-01 00:00:00		0	125
712	442	LUX	deu	LUXEMBOURG	Luxemburg	LUXEMBOURG	Luxemburg	1	1	Luxemburg	Luxemburg	2000-01-01 00:00:00		2000-01-01 00:00:00		0	125
713	447	LUX	fra	LUXEMBOURG	Luxembourg	LUXEMBOURG	Luxembourg	1	0	Luxembourg	Luxembourg	2000-01-01 00:00:00		2000-01-01 00:00:00		0	125
714	501	MDG	mig	MADAGASCAR	Madagasikara	ANTANANARIVO	Antananarivo	1	0	Madagasikara	Antananarivo	2000-01-01 00:00:00		2000-01-01 00:00:00		0	128
715	447	MDG	fra	MADAGASCAR	Madagascar	ANTANANARIVO	Antananarivo/Tananarive	1	1	Madagascar	Antananarivo/Tananarive	2000-01-01 00:00:00		2000-01-01 00:00:00		0	128
716	436	MWI	eng	MALAWI	Malawi	LILONGWE	Lilongwe	1	1	Malawi	Lilongwe	2000-01-01 00:00:00		2000-01-01 00:00:00		0	129
717	502	MWI	nya	MALAWI	Malawi	LILONGWE	Lilongwe	1	0	Malawi	Lilongwe	2000-01-01 00:00:00		2000-01-01 00:00:00		0	129
718	503	MYS	msa	MALAYSIA	Malaysia	KUALA LUMPUR	Kuala Lumpur	1	1	Malaysia	Kuala Lumpur	2000-01-01 00:00:00		2000-01-01 00:00:00		0	130
719	504	MDV		MALDIVES	Dhivehi Raajje	MALÉ	Malé	1	1	Dhivehi Raajje	Malé	2000-01-01 00:00:00		2000-01-01 00:00:00		0	131
720	505	MDV		MALDIVES	ހިވެދި ގުޖޭއްރާ	MALÉ	މާލެ	1	0	ހިވެދި ގުޖޭއްރާ	މާލެ	2000-01-01 00:00:00		2000-01-01 00:00:00		0	131
721	447	MLI	fra	MALI	Mali	BAMAKO	Bamako	1	1	Mali	Bamako	2000-01-01 00:00:00		2000-01-01 00:00:00		0	132
722	506	MLT	mlt	MALTA	Malta	VALLETTA	Valletta or Il-Belt	1	1	Malta	Valletta or Il-Belt	2000-01-01 00:00:00		2000-01-01 00:00:00		0	133
723	436	MHL	eng	MARSHALL ISLANDS	Marshall Islands	MAJURO	Majuro	1	1	Marshall Islands	Majuro	2000-01-01 00:00:00		2000-01-01 00:00:00		0	134
724	507	MHL	mah	MARSHALL ISLANDS	Marshall Islands	MAJURO	Majuro	1	0	Marshall Islands	Majuro	2000-01-01 00:00:00		2000-01-01 00:00:00		0	134
725	447	MTQ	fra	MARTINIQUE	Martinique	FORT-DE-FRANCE	Fort-De-France	1	1	Martinique	Fort-De-France	2000-01-01 00:00:00		2000-01-01 00:00:00		0	135
726	447	MRT	fra	MAURITANIA	Mauritanie	NOUAKCHOTT	Nouakchott	1	1	Mauritanie	Nouakchott	2000-01-01 00:00:00		2000-01-01 00:00:00		0	136
884	572	MAC	\N	MACAO	Àomén	NONE	None	1	1	Àomén	None	2000-01-01 00:00:00		2000-01-01 00:00:00		0	126
727	434	MRT	ara	MAURITANIA	موريتانيا	NOUAKCHOTT	نواكشوط	1	0	Mūrītāniyā	Nouakchott	2000-01-01 00:00:00		2000-01-01 00:00:00		0	136
728	447	MUS	fra	MAURITIUS	Maurice	PORT LOUIS	Port Louis	1	1	Maurice	Port Louis	2000-01-01 00:00:00		2000-01-01 00:00:00		0	137
730	439	MEX	spa	MEXICO	México	MEXICO CITY	Ciudad de México	1	1	México	Ciudad de México	2000-01-01 00:00:00		2000-01-01 00:00:00		0	139
731	447	MCO	fra	MONACO	Munegu	MONACO	Munegu	1	1	Munegu	Munegu	2000-01-01 00:00:00		2000-01-01 00:00:00		0	142
732	508	MNG	mon	MONGOLIA	Монгол Улс	ULAANBAATAR	Улаанбатаар	1	1	Mongol Uls	Ulaanbaatar	2000-01-01 00:00:00		2000-01-01 00:00:00		0	143
733	436	MSR	eng	MONTSERRAT	Montserrat	BRADES ESTATE	Brades Estate	1	1	Montserrat	Brades Estate	2000-01-01 00:00:00		2000-01-01 00:00:00		0	144
734	434	MAR	ara	MOROCCO	المغرب	RABAT	رباط	1	1	Al-Maghrib	Rabat	2000-01-01 00:00:00		2000-01-01 00:00:00		0	145
735	438	MOZ	por	MOZAMBIQUE	Moçambique	MAPUTO	Maputo	1	1	Moçambique	Maputo	2000-01-01 00:00:00		2000-01-01 00:00:00		0	146
736	509	MMR	mya	MYANMAR	Myanma	NAYPYIDAW	Naypyidaw	1	1	Myanma	Naypyidaw	2000-01-01 00:00:00		2000-01-01 00:00:00		0	147
737	436	NAM	eng	NAMIBIA	Namibia	WINDHOEK	Windhoek	1	1	Namibia	Windhoek	2000-01-01 00:00:00		2000-01-01 00:00:00		0	148
738	436	NRU	eng	NAURU	Naoero	NO CAPITAL	No Capital	1	1	Naoero	No Capital	2000-01-01 00:00:00		2000-01-01 00:00:00		0	149
739	510	NRU	nau	NAURU	Nauruo	NO CAPITAL	No Capital	1	0	Nauruo	No Capital	2000-01-01 00:00:00		2000-01-01 00:00:00		0	149
740	479	NPL	nep	NEPAL	Nepal	KATHMANDU	Katmandu	1	1	Nepal	Katmandu	2000-01-01 00:00:00		2000-01-01 00:00:00		0	150
741	511	NPL		NEPAL	नेपाल	KATHMANDU	काठमांडौ	1	0	नेपाल	काठमांडौ	2000-01-01 00:00:00		2000-01-01 00:00:00		0	150
742	441	NLD	nld	NETHERLANDS	Nederland	AMSTERDAM	Amsterdam	1	1	Nederland	Amsterdam	2000-01-01 00:00:00		2000-01-01 00:00:00		0	151
743	441	ANT	nld	NETHERLANDS ANTILLES	Nederlandse Antillen	WILLEMSTAD	Willemstad	1	1	Nederlandse Antillen	Willemstad	2000-01-01 00:00:00		2000-01-01 00:00:00		0	152
744	447	NCL	fra	NEW CALEDONIA	Nouvelle-Calédonie	NOUMÉA	Nouméa	1	1	Nouvelle-Calédonie	Nouméa	2000-01-01 00:00:00		2000-01-01 00:00:00		0	153
745	436	NZL	eng	NEW ZEALAND	New Zealand	WELLINGTON	Wellington	1	1	New Zealand	Wellington	2000-01-01 00:00:00		2000-01-01 00:00:00		0	154
746	512	NZL	mri	NEW ZEALAND	Aotearoa	WELLINGTON	Te Whanganui-a-Tara	1	0	Aotearoa	Te Whanganui-a-Tara	2000-01-01 00:00:00		2000-01-01 00:00:00		0	154
747	439	NIC	spa	NICARAGUA	Nicaragua	MANAGUA	Managua	1	1	Nicaragua	Managua	2000-01-01 00:00:00		2000-01-01 00:00:00		0	155
748	447	NER	fra	NIGER	Niger	NIAMEY	Niamey	1	1	Niger	Niamey	2000-01-01 00:00:00		2000-01-01 00:00:00		0	156
749	436	NGA	eng	NIGERIA	Nigeria	ABUJA	Abuja	1	1	Nigeria	Abuja	2000-01-01 00:00:00		2000-01-01 00:00:00		0	157
750	513	NGA	ibo	NIGERIA	Nigeria	ABUJA	Abuja	1	0	Nigeria	Abuja	2000-01-01 00:00:00		2000-01-01 00:00:00		0	157
751	514	NGA	yor	NIGERIA	Nigeria	ABUJA	Abuja	1	0	Nigeria	Abuja	2000-01-01 00:00:00		2000-01-01 00:00:00		0	157
752	515	NGA		NIGERIA	Nigeria	ABUJA	Abuja	1	0	Nigeria	Abuja	2000-01-01 00:00:00		2000-01-01 00:00:00		0	157
753	516	NIU	niu	NIUE	Niue	ALOFI	Alofi	1	0	Niue	Alofi	2000-01-01 00:00:00		2000-01-01 00:00:00		0	158
754	436	NIU	eng	NIUE	Niue	ALOFI	Alofi	1	1	Niue	Alofi	2000-01-01 00:00:00		2000-01-01 00:00:00		0	158
755	436	NFK	eng	NORFOLK ISLAND	Norfolk Island	KINGSTON	Kingston	1	1	Norfolk Island	Kingston	2000-01-01 00:00:00		2000-01-01 00:00:00		0	159
756	436	MNP	eng	NORTHERN MARIANA ISLANDS	Northern Mariana Islands	SAIPAN	Saipan	1	1	Northern Mariana Islands	Saipan	2000-01-01 00:00:00		2000-01-01 00:00:00		0	160
757	517	NOR	nob	NORWAY	Norge	OSLO	Oslo	1	1	Norge	Oslo	2000-01-01 00:00:00		2000-01-01 00:00:00		0	161
758	518	NOR	nno	NORWAY	Noreg	OSLO	Oslo	1	0	Noreg	Oslo	2000-01-01 00:00:00		2000-01-01 00:00:00		0	161
759	434	OMN	ara	OMAN	عُمان	MUSCAT	مسقط	1	1	Uman	Masqat	2000-01-01 00:00:00		2000-01-01 00:00:00		0	162
760	486	PAK	urd	PAKISTAN	پاکستان	ISLAMABAD	اسلاماباد	1	1	Pakistan	Islamabad	2000-01-01 00:00:00		2000-01-01 00:00:00		0	163
761	436	PLW	eng	PALAU	Belau	MELEKEOK	Melekeok	1	1	Belau	Melekeok	2000-01-01 00:00:00		2000-01-01 00:00:00		0	164
762	519	PLW	pau	PALAU	Palau	MELEKEOK	Melekeok	1	0	Palau	Melekeok	2000-01-01 00:00:00		2000-01-01 00:00:00		0	164
763	439	PAN	spa	PANAMA	Panamá	PANAMA CITY	Panamá	1	1	Panamá	Panamá	2000-01-01 00:00:00		2000-01-01 00:00:00		0	166
764	436	PNG	eng	PAPUA NEW GUINEA	Papua New Guinea	PORT MORESBY	Port Moresby	1	0	Papua New Guinea	Port Moresby	2000-01-01 00:00:00		2000-01-01 00:00:00		0	167
765	520	PNG	tpi	PAPUA NEW GUINEA	Papua Niugini	PORT MORESBY	Pot Mosbi	1	1	Papua Niugini	Pot Mosbi	2000-01-01 00:00:00		2000-01-01 00:00:00		0	167
766	521	PNG	hmo	PAPUA NEW GUINEA	Papua Niugini	PORT MORESBY	Pot Mosbi	1	0	Papua Niugini	Pot Mosbi	2000-01-01 00:00:00		2000-01-01 00:00:00		0	167
767	439	PRY	spa	PARAGUAY	Paraguay	ASUNCION	Asunción	1	1	Paraguay	Asunción	2000-01-01 00:00:00		2000-01-01 00:00:00		0	168
768	522	PRY	grn	PARAGUAY	Paraguái	ASUNCION	Paraguay	1	0	Paraguái	Paraguay	2000-01-01 00:00:00		2000-01-01 00:00:00		0	168
769	439	PER	spa	PERU	Perú	LIMA	Lima	1	1	Perú	Lima	2000-01-01 00:00:00		2000-01-01 00:00:00		0	169
770	523	PHL	fil	PHILIPPINES	Pilipinas	MANILA	Maynila	1	1	Pilipinas	Maynila	2000-01-01 00:00:00		2000-01-01 00:00:00		0	170
771	436	PHL	eng	PHILIPPINES	Philippines	MANILA	Manila	1	0	Philippines	Manila	2000-01-01 00:00:00		2000-01-01 00:00:00		0	170
772	524	POL	pol	POLAND	Polska	WARSAW	Warszawa	1	1	Polska	Warszawa	2000-01-01 00:00:00		2000-01-01 00:00:00		0	172
773	438	PRT	por	PORTUGAL	Portugal	LISBON	Lisboa	1	1	Portugal	Lisboa	2000-01-01 00:00:00		2000-01-01 00:00:00		0	173
774	525	PRT	mwl	PORTUGAL	Pertual	LISBON	Lisbon	1	0	Pertual	Lisbon	2000-01-01 00:00:00		2000-01-01 00:00:00		0	173
775	439	PRI	spa	PUERTO RICO	Puerto Rico	SAN JUAN	San Juan	1	1	Puerto Rico	San Juan	2000-01-01 00:00:00		2000-01-01 00:00:00		0	174
776	436	PRI	eng	PUERTO RICO	Puerto Rico	SAN JUAN	San Juan	1	0	Puerto Rico	San Juan	2000-01-01 00:00:00		2000-01-01 00:00:00		0	174
777	434	QAT	ara	QATAR	قطر	DOHA	الدوحة	1	1	Qatar	Ad-Dawhah	2000-01-01 00:00:00		2000-01-01 00:00:00		0	175
778	526	ROU	ron	ROMANIA	România	BUCHAREST	Bucureşti	1	1	România	Bucureşti	2000-01-01 00:00:00		2000-01-01 00:00:00		0	177
779	447	RWA	fra	RWANDA	Rwanda	KIGALI	Kigali	1	1	Rwanda	Kigali	2000-01-01 00:00:00		2000-01-01 00:00:00		0	179
780	527	RWA	kin	RWANDA	Rwanda	KIGALI	Kigali	1	0	Rwanda	Kigali	2000-01-01 00:00:00		2000-01-01 00:00:00		0	179
781	436	RWA	eng	RWANDA	Rwanda	KIGALI	Kigali	1	0	Rwanda	Kigali	2000-01-01 00:00:00		2000-01-01 00:00:00		0	179
782	447	KNA	fra	SAINT KITTS AND NEVIS	Saint Kitts And Nevis	BASSETERRE	Basseterre	1	1	Saint Kitts And Nevis	Basseterre	2000-01-01 00:00:00		2000-01-01 00:00:00		0	180
783	436	LCA	eng	SAINT LUCIA	Saint Lucia	CASTRIES	Castries	1	1	Saint Lucia	Castries	2000-01-01 00:00:00		2000-01-01 00:00:00		0	181
784	436	VCT	eng	SAINT VINCENT AND THE GRENADINES	Saint Vincent And The Grenadines	KINGSTOWN	Kingstown	1	1	Saint Vincent And The Grenadines	Kingstown	2000-01-01 00:00:00		2000-01-01 00:00:00		0	182
785	436	WSM	eng	SAMOA	Samoa	APIA	Apia	1	1	Samoa	Apia	2000-01-01 00:00:00		2000-01-01 00:00:00		0	183
786	490	SMR	ita	SAN MARINO	San Marino	SAN MARINO	San Marino	1	1	San Marino	San Marino	2000-01-01 00:00:00		2000-01-01 00:00:00		0	184
787	434	SAU	ara	SAUDI ARABIA	العربية السعودية	RIYADH	الرياض	1	1	Al-Arabiyah as Sa'udiyah	Ar-Riyád	2000-01-01 00:00:00		2000-01-01 00:00:00		0	186
788	447	SEN	fra	SENEGAL	Sénégal	DAKAR	Dakar	1	1	Sénégal	Dakar	2000-01-01 00:00:00		2000-01-01 00:00:00		0	187
789	528	SYC		SEYCHELLES	Sesel	VICTORIA	Victoria	1	0	Sesel	Victoria	2000-01-01 00:00:00		2000-01-01 00:00:00		0	188
790	447	SYC	fra	SEYCHELLES	Seychelles	VICTORIA	Victoria	1	1	Seychelles	Victoria	2000-01-01 00:00:00		2000-01-01 00:00:00		0	188
791	436	SYC	eng	SEYCHELLES	Seychelles	VICTORIA	Victoria	1	0	Seychelles	Victoria	2000-01-01 00:00:00		2000-01-01 00:00:00		0	188
792	436	SLE	eng	SIERRA LEONE	Sierra Leone	FREETOWN	Freetown	1	1	Sierra Leone	Freetown	2000-01-01 00:00:00		2000-01-01 00:00:00		0	189
793	503	SGP	msa	SINGAPORE	Singapura	SINGAPORE	Singapura	1	0	Singapura	Singapura	2000-01-01 00:00:00		2000-01-01 00:00:00		0	190
794	436	SGP	eng	SINGAPORE	Singapore	SINGAPORE	Singapore	1	0	Singapore	Singapore	2000-01-01 00:00:00		2000-01-01 00:00:00		0	190
795	529	SGP	zho	SINGAPORE	新加坡	SINGAPORE	新加坡	1	1	Xīnjīapō	Xīnjīapō	2000-01-01 00:00:00		2000-01-01 00:00:00		0	190
796	484	SGP	tam	SINGAPORE	சிங்கப்பூர்	SINGAPORE	சிங்கப்பூர்	1	0	Singapur	Singapur	2000-01-01 00:00:00		2000-01-01 00:00:00		0	190
797	530	SVN	slv	SLOVENIA	Slovenija	LJUBLJANA	Ljubljana	1	1	Slovenija	Ljubljana	2000-01-01 00:00:00		2000-01-01 00:00:00		0	192
798	436	SLB	eng	SOLOMON ISLANDS	Solomon Islands	HONIARA	Honiara	1	1	Solomon Islands	Honiara	2000-01-01 00:00:00		2000-01-01 00:00:00		0	193
799	531	SOM	som	SOMALIA	Soomaaliya	MOGADISHU	Muqdisho	1	1	Soomaaliya	Muqdisho	2000-01-01 00:00:00		2000-01-01 00:00:00		0	194
800	436	ZAF	eng	SOUTH AFRICA	South Africa	PRETORIA	Pretoria, Cape Town	1	1	South Africa	Pretoria, Cape Town	2000-01-01 00:00:00		2000-01-01 00:00:00		0	195
801	532	ZAF	afr	SOUTH AFRICA	Suid-Afrika	PRETORIA	Pretoria, Kaapstad	1	0	Suid-Afrika	Pretoria, Kaapstad	2000-01-01 00:00:00		2000-01-01 00:00:00		0	195
802	533	ZAF	zul	SOUTH AFRICA	iNingizimu Afrika	PRETORIA	iPitoli	1	0	iNingizimu Afrika	iPitoli	2000-01-01 00:00:00		2000-01-01 00:00:00		0	195
803	534	ZAF	xho	SOUTH AFRICA	uMzantsi Afrika	PRETORIA	iPitoli	1	0	uMzantsi Afrika	iPitoli	2000-01-01 00:00:00		2000-01-01 00:00:00		0	195
804	535	ZAF	nso	SOUTH AFRICA	Afrika-Borwa	PRETORIA	Tshwane	1	0	Afrika-Borwa	Tshwane	2000-01-01 00:00:00		2000-01-01 00:00:00		0	195
805	536	ZAF	sot	SOUTH AFRICA	Afrika Borwa	PRETORIA	Tshwane	1	0	Afrika Borwa	Tshwane	2000-01-01 00:00:00		2000-01-01 00:00:00		0	195
806	537	ZAF	tsn	SOUTH AFRICA	Aforika Borwa	PRETORIA	Tshwane	1	0	Aforika Borwa	Tshwane	2000-01-01 00:00:00		2000-01-01 00:00:00		0	195
807	538	ZAF	ven	SOUTH AFRICA	Afurika Tshipembe	PRETORIA	Tswane	1	0	Afurika Tshipembe	Tswane	2000-01-01 00:00:00		2000-01-01 00:00:00		0	195
808	539	ZAF	tso	SOUTH AFRICA	Afrika Dzonga	PRETORIA	Pitori	1	0	Afrika Dzonga	Pitori	2000-01-01 00:00:00		2000-01-01 00:00:00		0	195
809	540	ZAF	ssw	SOUTH AFRICA	iNingizimu Afrika	PRETORIA	iPitoli	1	0	iNingizimu Afrika	iPitoli	2000-01-01 00:00:00		2000-01-01 00:00:00		0	195
810	541	ZAF	nde	SOUTH AFRICA	iSewula Afrika	PRETORIA	iPitori	1	0	iSewula Afrika	iPitori	2000-01-01 00:00:00		2000-01-01 00:00:00		0	195
811	439	ESP	spa	SPAIN	España	MADRID	Madrid	1	1	España	Madrid	2000-01-01 00:00:00		2000-01-01 00:00:00		0	197
812	437	ESP	cat	SPAIN	Espanya	MADRID	Madrid	1	0	Espanya	Madrid	2000-01-01 00:00:00		2000-01-01 00:00:00		0	197
813	543	ESP	eus	SPAIN	Ezpaina	MADRID	Madril	1	0	Ezpaina	Madril	2000-01-01 00:00:00		2000-01-01 00:00:00		0	197
814	544	LKA	sin	SRI LANKA	Sri Lankā	COLOMBO	Kola-amba-thota	1	0	Sri Lankā	Kola-amba-thota	2000-01-01 00:00:00		2000-01-01 00:00:00		0	198
815	484	LKA	tam	SRI LANKA	இலங்கை	COLOMBO	Colombo	1	1	Ilangai	colzhumbhu	2000-01-01 00:00:00		2000-01-01 00:00:00		0	198
816	434	SDN	ara	SUDAN	السودان	KHARTOUM	الخرطوم	1	1	As-Sudan	Al-Khartûm	2000-01-01 00:00:00		2000-01-01 00:00:00		0	201
817	441	SUR	nld	SURINAME	Suriname	PARAMARIBO	Paramaribo	1	1	Suriname	Paramaribo	2000-01-01 00:00:00		2000-01-01 00:00:00		0	202
818	436	SWZ	eng	SWAZILAND	Swaziland	MBABANE	Mbabane	1	1	Swaziland	Mbabane	2000-01-01 00:00:00		2000-01-01 00:00:00		0	204
819	465	SWE	swe	SWEDEN	Sverige	STOCKHOLM	Stockholm	1	1	Sverige	Stockholm	2000-01-01 00:00:00		2000-01-01 00:00:00		0	205
820	442	CHE	deu	SWITZERLAND	Schweiz	BERNE	Bern	1	1	Schweiz	Bern	2000-01-01 00:00:00		2000-01-01 00:00:00		0	206
821	447	CHE	fra	SWITZERLAND	Suisse	BERNE	Berne	1	1	Suisse	Berne	2000-01-01 00:00:00		2000-01-01 00:00:00		0	206
822	490	CHE	ita	SWITZERLAND	Svizzera	BERNE	Berna	1	1	Svizzera	Berna	2000-01-01 00:00:00		2000-01-01 00:00:00		0	206
823	545	CHE	roh	SWITZERLAND	Svizra	BERNE	Berna	0	0	Svizra	Berna	2000-01-01 00:00:00		2000-01-01 00:00:00		0	206
824	546	TJK	tgk	TAJIKISTAN	Тоҷикистон	DUSHANBE	Душанбе	1	1	Tojikistan	Dushanbe	2000-01-01 00:00:00		2000-01-01 00:00:00		0	209
874	568	VNM	\N	VIETNAM	Việt Nam	HANOI	Hà Nội	1	1	Việt Nam	Hà Nội	2000-01-01 00:00:00		2000-01-01 00:00:00		0	232
825	547	THA	tha	THAILAND	Mueang Thai, Prathet Thai, Ratcha-anachak Thai	BANGKOK	Krung Thep Maha Nakhon	1	1	Mueang Thai, Prathet Thai, Ratcha-anachak Thai	Krung Thep Maha Nakhon	2000-01-01 00:00:00		2000-01-01 00:00:00		0	211
826	447	TGO	fra	TOGO	Togo	LOMÉ	Lomé	1	1	Togo	Lomé	2000-01-01 00:00:00		2000-01-01 00:00:00		0	212
827	436	TKL	eng	TOKELAU	Tokelau	TOKELAU	Tokelau	1	1	Tokelau	Tokelau	2000-01-01 00:00:00		2000-01-01 00:00:00		0	213
828	436	TON	eng	TONGA	Tonga	NUKU'ALOFA	Nuku'alofa	1	1	Tonga	Nuku'alofa	2000-01-01 00:00:00		2000-01-01 00:00:00		0	214
829	436	TTO	eng	TRINIDAD AND TOBAGO	Trinidad And Tobago	PORT OF SPAIN	Port Of Spain	1	1	Trinidad And Tobago	Port Of Spain	2000-01-01 00:00:00		2000-01-01 00:00:00		0	215
830	434	TUN	ara	TUNISIA	تونس	TUNIS	تونس	1	1	Tunis	Tunis	2000-01-01 00:00:00		2000-01-01 00:00:00		0	216
831	454	TUR	tur	TURKEY	Türkiye	ANKARA	Ankara	1	1	Türkiye	Ankara	2000-01-01 00:00:00		2000-01-01 00:00:00		0	217
832	548	TKM	tuk	TURKMENISTAN	Türkmenistan	ASHGABAT	Aşgabat	1	1	Türkmenistan	Aşgabat	2000-01-01 00:00:00		2000-01-01 00:00:00		0	218
885	529	MAC	zho	MACAO	Àomén	NONE	None	1	0	澳門	None	2000-01-01 00:00:00		2000-01-01 00:00:00		0	126
833	436	TCA	eng	TURKS AND CAICOS ISLANDS	Turks And Caicos Islands	COCKBURN TOWN	Cockburn Town	1	1	Turks And Caicos Islands	Cockburn Town	2000-01-01 00:00:00		2000-01-01 00:00:00		0	219
834	436	TUV	eng	TUVALU	Tuvalu	FONGAFALE (IN FUNAFUTI)	Fongafale (In Funafuti)	1	1	Tuvalu	Fongafale (In Funafuti)	2000-01-01 00:00:00		2000-01-01 00:00:00		0	220
835	436	UGA	eng	UGANDA	Uganda	KAMPALA	Kampala	1	1	Uganda	Kampala	2000-01-01 00:00:00		2000-01-01 00:00:00		0	221
836	549	UKR	ukr	UKRAINE	Україна	KIEV	Київ	1	1	Ukraїna	Kyїv	2000-01-01 00:00:00		2000-01-01 00:00:00		0	222
837	434	ARE	ara	UNITED ARAB EMIRATES	الإمارات العربيّة المتّحدة	ABU DHABI	أبوظبي	1	1	Al-Imarat Al-Arabiyah Al-Muttahidah	Abu Zaby	2000-01-01 00:00:00		2000-01-01 00:00:00		0	223
838	436	GBR	eng	UNITED KINGDOM	United Kingdom	LONDON	London	1	1	United Kingdom	London	2000-01-01 00:00:00		2000-01-01 00:00:00		0	224
839	550	GBR	cym	UNITED KINGDOM	Y Deyrnas Unedig	LONDON	Llundain	1	0	Y Deyrnas Unedig	Llundain	2000-01-01 00:00:00		2000-01-01 00:00:00		0	224
840	551	GBR	sco	UNITED KINGDOM	Unitit Kinrick	LONDON	Lunnon	1	0	Unitit Kinrick	Lunnon	2000-01-01 00:00:00		2000-01-01 00:00:00		0	224
841	552	GBR	gla	UNITED KINGDOM	Rìoghachd Aonaichte	LONDON	Lunnainn	1	0	Rìoghachd Aonaichte	Lunnainn	2000-01-01 00:00:00		2000-01-01 00:00:00		0	224
842	488	GBR	gle	UNITED KINGDOM	Ríocht Aontaithe	LONDON	Londain	1	0	Ríocht Aontaithe	Londain	2000-01-01 00:00:00		2000-01-01 00:00:00		0	224
843	436	USA	eng	UNITED STATES	United States of America	WASHINGTON, D.C.	Washington	1	1	United States of America	Washington	2000-01-01 00:00:00		2000-01-01 00:00:00		0	225
844	439	USA	spa	UNITED STATES	Estados Unidos or América	WASHINGTON, D.C.	Washington	1	0	Estados Unidos or América	Washington	2000-01-01 00:00:00		2000-01-01 00:00:00		0	225
845	553	USA		UNITED STATES	États-Unis or Amérique	WASHINGTON, D.C.	Washington	1	0	États-Unis or Amérique	Washington	2000-01-01 00:00:00		2000-01-01 00:00:00		0	225
846	554	USA	haw	UNITED STATES	'Amelika-hui-pu-'ia or 'Amelika-hui	WASHINGTON, D.C.	Wakinekona or Wasinetona	1	0	'Amelika-hui-pu-'ia or 'Amelika-hui	Wakinekona or Wasinetona	2000-01-01 00:00:00		2000-01-01 00:00:00		0	225
847	439	URY	spa	URUGUAY	República Oriental del Uruguay	MONTEVIDEO	Montevideo	1	1	República Oriental del Uruguay	Montevideo	2000-01-01 00:00:00		2000-01-01 00:00:00		0	227
848	555	UZB	uzb	UZBEKISTAN	O'zbekiston	TASHKENT	Toshkent	1	1	O'zbekiston	Toshkent	2000-01-01 00:00:00		2000-01-01 00:00:00		0	228
850	439	VEN	spa	VENEZUELA	Venezuela	CARACAS	Caracas	1	1	Venezuela	Caracas	2000-01-01 00:00:00		2000-01-01 00:00:00		0	231
851	434	ESH	ara	WESTERN SAHARA	الصحراوية	LAAYOUNE (FRENCH TRANSLITERATION)	العيون	1	1	Al-Sahrāwīyâ	El- Aaiún	2000-01-01 00:00:00		2000-01-01 00:00:00		0	236
852	434	YEM	ara	YEMEN	اليمن	SANAÁ	‫ﺻﻨﻌﺎﺀ‬	1	1	Al-Yaman	Şan‘ā’	2000-01-01 00:00:00		2000-01-01 00:00:00		0	237
853	436	ZMB	eng	ZAMBIA	Zambia	LUSAKA	Lusaka	1	1	Zambia	Lusaka	2000-01-01 00:00:00		2000-01-01 00:00:00		0	239
854	529	CHN	zho	CHINA	中国	BEIJING	北京	1	1	Zhōngguó	Běijīng	2000-01-01 00:00:00		2000-01-01 00:00:00		0	44
855	447	REU	fra	REUNION	Réunion	SAINT-DENIS	Saint-Denis	1	1	Réunion	Saint-Denis	2000-01-01 00:00:00		2000-01-01 00:00:00		0	176
856	556	TWN	zho	TAIWAN	臺灣 or 台灣	TAIPEI	臺北	1	1	Táiwān	T'aipei	2000-01-01 00:00:00		2000-01-01 00:00:00		0	208
857	447	COG	fra	CONGO	Congo or Congo-Brazza	BRAZZAVILLE	Brazzaville	1	1	Congo or Congo-Brazza	Brazzaville	2000-01-01 00:00:00		2000-01-01 00:00:00		0	50
859	561	LAO	lao	LAOS	Lao	VIENTIANE	Vientiane or Vieng Chan	1	0	Lao	Vientiane or Vieng Chan	2000-01-01 00:00:00		2000-01-01 00:00:00		0	117
860	562	LAO	\N	LAOS	ລາວ	VIENTIANE	ວຽງຈັນ	1	1	ລາວ	ວຽງຈັນ	2000-01-01 00:00:00		2000-01-01 00:00:00		0	117
861	434	LBY	ara	LIBYA	ليبيا	TRIPOLI	طرابلس	1	1	Lībiyā	Tarabulus	2000-01-01 00:00:00		2000-01-01 00:00:00		0	122
862	563	MKD	mkd	MACEDONIA	Македонија	SKOPJE	Скопје / Скопље	1	1	Makedonija	Skopje	2000-01-01 00:00:00		2000-01-01 00:00:00		0	127
863	436	FSM	eng	MICRONESIA	Micronesia	PALIKIR	Palikir	1	1	Micronesia	Palikir	2000-01-01 00:00:00		2000-01-01 00:00:00		0	140
864	564	MDA	\N	MOLDOVA	Moldova	CHIŞINĂU	Chişinău	1	1	Moldova	Chişinău	2000-01-01 00:00:00		2000-01-01 00:00:00		0	141
865	565	PRK	\N	KOREA, NORTH	조선 / 朝鮮	P'YŎNGYANG	평양 / 平壌	1	1	Bukchosŏn	P'yŏngyang	2000-01-01 00:00:00		2000-01-01 00:00:00		0	113
866	434	PSE	ara	PALESTINIAN TERRITORY	فلسطين	RAMALLAH	رام الله	1	1	Filastīn	Ramallah	2000-01-01 00:00:00		2000-01-01 00:00:00		0	165
867	446	RUS	rus	RUSSIA	Россия1	MOSCOW	Москва	1	1	Rossiya or Rossiâ	Moskva	2000-01-01 00:00:00		2000-01-01 00:00:00		0	178
868	438	STP	por	SAO TOME AND PRINCIPE	São Tomé e Príncipe	SÃO TOMÉ	São Tomé	1	1	São Tomé e Príncipe	São Tomé	2000-01-01 00:00:00		2000-01-01 00:00:00		0	185
869	566	SVK	slk	SLOVAKIA	Slovensko	BRATISLAVA	Bratislava	1	1	Slovensko	Bratislava	2000-01-01 00:00:00		2000-01-01 00:00:00		0	191
870	565	KOR	\N	KOREA, SOUTH	남한 / 南韓	SEOUL	서울	1	1	Namhan	Seoul	2000-01-01 00:00:00		2000-01-01 00:00:00		0	114
871	434	SYR	ara	SYRIA	سورية	DAMASCUS	الشام / دمشق	1	1	Suriyah	Dimashq / Ash-Sham	2000-01-01 00:00:00		2000-01-01 00:00:00		0	207
872	436	TZA	eng	TANZANIA	Tanzania	DODOMA	Dodoma	1	1	Tanzania	Dodoma	2000-01-01 00:00:00		2000-01-01 00:00:00		0	210
873	567	VAT	lat	VATICAN CITY	Civitas Vaticana	VATICAN CITY	Civitas Vaticana	1	1	Civitas Vaticana	Civitas Vaticana	2000-01-01 00:00:00		2000-01-01 00:00:00		0	230
875	503	BRN	msa	BRUNEI	بروني	BANDAR SERI BEGAWAN	باندر سري بڬاون	1	1	Brunei	Bandar Seri Begawan	2000-01-01 00:00:00		2000-01-01 00:00:00		0	32
876	436	CCK	eng	COCOS ISLANDS	Cocos Islands	WEST ISLAND	West Island	1	1	Cocos Islands	West Island	2000-01-01 00:00:00		2000-01-01 00:00:00		0	46
877	447	CIV	fra	COTE D'IVOIRE	Côte d'Ivoire	YAMOUSSOUKRO	Yamoussoukro	1	1	Cote D'ivoire	Yamoussoukro	2000-01-01 00:00:00		2000-01-01 00:00:00		0	53
878	569	HRV	hrv	CROATIA	Hrvatska	ZAGREB	Zagreb	1	1	Hrvatska	Zagreb	2000-01-01 00:00:00		2000-01-01 00:00:00		0	54
879	570	BIH	\N	BOSNIA-HERZEGOVINA	Bosna i Hercegovina	SARAJEVO	Sarajevo	1	0	Bosna i Hercegovina	Sarajevo	2000-01-01 00:00:00		2000-01-01 00:00:00		0	27
880	571	BIH	srp	BOSNIA-HERZEGOVINA	Bosna i Hercegovina	SARAJEVO	Sarajevo	1	1	Bosna i Hercegovina	Sarajevo	2000-01-01 00:00:00		2000-01-01 00:00:00		0	27
881	569	BIH	hrv	BOSNIA-HERZEGOVINA	Босна и Херцеговина	SARAJEVO	Сарајево	1	1	Bosnia-Herzegovina	Sarajevo	2000-01-01 00:00:00		2000-01-01 00:00:00		0	27
882	447	COD	fra	CONGO (DRC)	Congo	KINSHASA	Kinshasa	1	1	Congo	Kinshasa	2000-01-01 00:00:00		2000-01-01 00:00:00		0	49
\.


--
-- Data for Name: languages; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.languages (lg_seq, lg_iso2, lg_iso3, lg_desc, lg_active, lg_iso3_alt, lg_endonym, lg_no_of_speakers, lg_cwhen, lg_cby, lg_mwhen, lg_mby, lg_mcount) FROM stdin;
433	sq	sqi	ALBANIAN	1	alb		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
434	ar	ara	ARABIC	1		العربية	206000000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
435	sm	smo	SAMOAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
436	en	eng	ENGLISH	1		English	309400000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
437	ca	cat	CATALAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
438	pt	por	PORTUGUESE	1		Português	177500000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
439	es	spa	SPANISH	1		Español	322300000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
440	hy	hye	ARMENIAN	1	arm		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
441	nl	nld	DUTCH	1	dut		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
442	de	deu	GERMAN	1	ger	Deutsch	95400000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
443	az	aze	AZERI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
444	bn	ben	BENGALI	1		বাংলা	171100000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
445	be	bel	BELARUSIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
446	ru	rus	RUSSIAN	1		Русский язык	145000000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
447	fr	fra	FRENCH	1	fre	Français	64900000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
448	dz	dzo	DZONGKHA	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
449	bg	bul	BULGARIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
450		\N	KIRUNDI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
451	\N	\N	CAMBODIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
452	\N	\N	SHIKOMOR	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
453	el	ell	GREEK	1	gre		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
454	tr	tur	TURKISH	1		Türkçe	0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
455	cs	ces	CZECH	1	cze		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
456	da	dan	DANISH	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
457		tet	TETUM	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
458	ti	tir	TIGRINYA	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
459	et	est	ESTONIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
460	am	amh	AMHARIC	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
461	fo	fao	FAROESE	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
462	fj	fij	FIJIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
463			HINDUSTANI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
464	fi	fin	FINNISH	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
465	sv	swe	SWEDISH	1		Svenska	0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
466	ka	kat	GEORGIAN	1	geo		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
467	kl	kal	GREENLANDIC	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
468		\N	CANTONESE	1		粵語 / 粤语	0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
469	hu	hun	HUNGARIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
470	is	isl	ICELANDIC	1	ice		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
471	as	asm	ASSAMESE	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
472	gu	guj	GUJARATI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
473	hi	hin	HINDI	1			180800000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
474	kn	kan	KANNADA	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
475	ks	kas	KASHMIRI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
476		\N	KONKANI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
477	ml	mal	MALAYALAM	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
478	mr	mar	MARATHI	1		मराठी	68000000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
479	ne	nep	NEPALI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
480	or	ori	ORIYA	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
481	pa	pan	PANJABI	1		ਪੰਜਾਬੀ / پنجابی	60800000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
482	sa	san	SANSKRIT	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
483	sd	snd	SINDHI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
484	ta	tam	TAMIL	1		தமிழ்	66000000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
485	te	tel	TELUGU	1		తెలుగు	69700000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
486	ur	urd	URDU	1			60500000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
487	id	ind	INDONESIAN	1		Bahasa Indonesia	75500000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
488	ga	gle	IRISH	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
489	he	heb	HEBREW	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
490	it	ita	ITALIAN	1		Italiano	61500000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
491	ja	jpn	JAPANESE	1		日本語	122400000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
492	kk	kaz	KAZAKH	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
493			RUSSIAN LANGUAGE	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
494	sw	swa	SWAHILI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
495		gil	GILBERTESE	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
496	ky	kir	KYRGYZ	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
497	lv	lav	LATVIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
498		\N	SESOTHO	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
499	lt	lit	LITHUANIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
500	lb	ltz	LUXEMBOURGISH	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
501	mg	mig	MALAGASY	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
502	ny	nya	CHICHEWA	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
503	ms	msa	MALAY	1	may		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
504	\N	\N	DHIVEHI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
505			THAANA SCRIPT	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
506	mt	mlt	MALTESE	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
507	mh	mah	MARSHALLESE	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
508	mn	mon	MONGOLIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
509	my	mya	BURMESE	1	bur		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
510	na	nau	NAURUAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
511	\N	\N	DEVANAGARI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
512	mi	mri	MAORI	1	mao		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
513	ig	ibo	IGBO	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
514	yo	yor	YORUBA	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
515			BROKEN ENGLISH	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
516		niu	NIUEAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
517	nb	nob	NORWEGIAN BOKMÅL	1		Norsk	0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
518	nn	nno	NORWEGIAN NYNORSK	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
519		pau	PALAUAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
520		tpi	TOK PISIN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
521	ho	hmo	HIRI MOTU	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
522	gn	grn	GUARANÍ	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
523		fil	FILIPINO	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
524	pl	pol	POLISH	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
525		mwl	MIRANDESE	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
526	ro	ron	ROMANIAN	1	rum		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
527	rw	kin	KINYARWANDA	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
528	\N	\N	SEYCHELLOIS CREOLE	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
529	zh	zho	MANDARIN CHINESE	1	chi	官話	0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
530	sl	slv	SLOVENIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
531	so	som	SOMALI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
532	af	afr	AFRIKAANS	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
533	zu	zul	ZULU	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
534	xh	xho	XHOSA	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
535		nso	PEDI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
536	st	sot	SOTHO	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
537	tn	tsn	TSWANA	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
538	ve	ven	VENDA	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
539	ts	tso	TSONGA	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
540	ss	ssw	SWAZI	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
541	nd	nde	NDEBELE	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
542	gl	glg	SPANISH/GALICIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
543	eu	eus	BASQUE	1	baq		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
544	si	sin	SINHALA	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
545	rm	roh	ROMANSH	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
546	tg	tgk	TAJIKI-PERSIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
547	th	tha	THAI	1		ภาษาไทย	0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
548	tk	tuk	TURKMEN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
549	uk	ukr	UKRAINIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
550	cy	cym	WELSH	1	wel	Cymraeg	0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
551		sco	SCOTS	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
552	gd	gla	SCOTS GAELIC	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
553		\N	CAJUN FRENCH	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
554		haw	HAWAIIAN	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
555	uz	uzb	UZBEK	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
556	zh	zho	CHINESE	1	chi	汉语 / 中文	1205000000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
557	\N	\N	DEVANAGARI SCRIPT	1	\N		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
558	\N	\N	DARI-PERSIAN	1	\N		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
559	ps	pus	PASHTU	1		پښتو	0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
560	fa	fas	PERSIAN	1	per		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
561	lo	lao	LAO	1			0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
562	\N	\N	LAO ALPHABET	1	\N		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
563	mk	mkd	MACEDONIAN	1	mac		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
564	\N	\N	MOLDOVAN (ROMANIAN)	1	\N		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
565	ko	kor	KOREAN	1		한국어, 조선말	67000000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
566	sk	slk	SLOVAK	1	slo		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
567	la	lat	LATIN	1	\N		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
568	vi	vie	VIETNAMESE	1		quốc ngữ	67400000	2000-01-01 00:00:00		2000-01-01 00:00:00		0
569	hr	hrv	CROATIAN	1	scr		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
570	\N	\N	BOSNIAN	1	\N		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
571	sr	srp	SERBIAN	1	scc	српски језик	0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
572	\N	\N	CANTONESE CHINESE	1	\N		0	2000-01-01 00:00:00		2000-01-01 00:00:00		0
\.


--
-- Data for Name: productclassifications; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.productclassifications (pcl_seq, pcl_prd_ref, pcl_type, pcl_code, pcl_subcode, pcl_cwhen, pcl_cby) FROM stdin;
\.


--
-- Data for Name: productinternaldata; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.productinternaldata (pid_prd_ref, pid_division, pid_plant, pid_busunit, pid_category, pid_costcentre, pid_project, pid_suppress_ecocost, pid_unit_price, pid_tax_band, pid_cwhen, pid_cby, pid_mwhen, pid_mby, pid_mcount, pid_cmp_ref) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.products (prd_seq, prd_cwhen, prd_cby, prd_mwhen, prd_mby, prd_unit_price, prd_tax_band, prd_mcount, prd_go_ref, prd_eo_ref, prd_supp_prodcode, prd_int_prodcode, prd_brand, prd_name, prd_desc, prd_size, prd_uos_code, prd_unit_divisor, prd_ecocost_uos_code, prd_discontinued, prd_service_unit, prd_barcode, prd_mfr_fback_service, prd_meta, prd_micro_prd_ref, prd_mass_factor) FROM stdin;
\.


--
-- Data for Name: sysasyncemails; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysasyncemails (ae_seq, ae_to, ae_subject, ae_message, ae_cc, ae_bcc, ae_priority, ae_encl, ae_html, ae_cwhen, ae_go_ref, ae_fail_count, ae_fail_dialogue, ae_fail_status, ae_from, ae_extraheaders, ae_sendercode) FROM stdin;
\.


--
-- Data for Name: sysfeedback; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysfeedback (sf_seq, sf_topic, sf_class, sf_class_vsn, sf_type, sf_from, sf_comment, sf_resp_type, sf_resp_due, sf_reply, sf_complete, sf_cwhen, sf_cby, sf_mwhen, sf_mby, sf_mcount) FROM stdin;
\.


--
-- Data for Name: syslogerrors; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.syslogerrors (sle_cwhen, sle_code, sle_subcode, sle_message, sle_vhost_ref, sle_server_ip, sle_server_port) FROM stdin;
\.


--
-- Data for Name: syslogevents; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.syslogevents (slv_cwhen, slv_code, slv_subcode, slv_message, slv_vhost_ref, slv_server_ip, slv_server_port) FROM stdin;
\.


--
-- Data for Name: sysreferenceglobal; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysreferenceglobal (rfg_seq, rfg_class, rfg_value, rfg_desc, rfg_order, rfg_active, rfg_char, rfg_int, rfg_number, rfg_date, rfg_bin, rfg_time, rfg_effective, rfg_expires, rfg_json, rfg_cwhen, rfg_cby, rfg_mwhen, rfg_mby, rfg_mcount, rfg_unique) FROM stdin;
54	INV_STATUS	SUBSTITUTE	Substitute returned items	40	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	2014-03-24 11:06:23	x	2014-03-24 11:06:23	x	0	INV_STATUSSUBSTITUTE
51	INV_STATUS	RETURN	Customer returns product	30	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	2014-03-24 11:04:13	x	2014-03-24 11:04:13	x	0	INV_STATUSRETURN
544	INV_STATUS	ORIGINAL	Original	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	2015-01-15 09:43:59	x	2015-01-15 09:43:59	x	0	INV_STATUSORIGINAL
53	INV_STATUS	DISCARD	Product discarded by customer	60	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	2014-03-24 11:05:11	x	2014-03-24 11:05:11	x	0	INV_STATUSDISCARD
572	FORMCOLOURS	FIELDCOLOURS	entry field attributes	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	{"unique": "rgb(200,255,255)", "disabled": "rgb(238,238,238)", "enterable": "rgb(255,255,255)", "mandatory": "kMagenta"}	2017-03-28 13:50:54	stevensg	2017-03-28 13:50:54	stevensg	0	FORMCOLOURSFIELDCOLOURS
574	GRAPH	ACTIVITY	activity over the past week	10	0	\N	\N	\N	\N	\N	\N	\N	\N	{"version": "1.0.2", "chartConfig": {"inverted": true}, "legendConfig": {"visible": true}, "seriesConfigs": [{"id": "emissions", "axis": "Y", "title": "kg CO2e", "capSize": 6, "capType": "curve", "property": "chartValue", "renderer": "bar", "fillColor": "seriesIndex"}], "groupAxisConfig": {"type": "string", "scale": "ordinal", "property": "chartLabel"}, "seriesAxisConfigs": [{"id": "Y", "min": 0, "title": "Kg CO2e", "gridLines": true, "axisLineColor": "#000080", "axisLineWidth": 2, "gridLineColor": "#000080"}]}	2018-04-24 11:33:54	stevensg	2018-04-24 14:53:41	stevensg	1	GRAPHACTIVITY
546	INV_STATUS	INVOICE	Invoice	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	2016-05-03 10:48:02	mostynrs	2016-05-03 10:48:39	mostynrs	1	INV_STATUSINVOICE
50	INV_STATUS	QUOTE	Quote	90	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	2014-03-24 11:03:27	x	2014-03-24 11:03:27	x	0	INV_STATUSQUOTE
545	FORMAT	DATE_JS	D/M/Y|D.M.Y|D-M-Y	0	1		0	0	\N	\N	\N	2000-01-01	2000-01-01	\N	2015-04-10 13:11:08	x	2015-04-10 13:11:08	x	0	FORMATDATE_JS2000-01-01
558	FORMCOLOURS	FIELDMANDATORY	mandatory field border colour	\N	1	kMagenta	\N	\N	\N	\N	\N	\N	\N	\N	2016-06-07 10:49:27	stevensg	2016-06-07 10:49:27	stevensg	0	FORMCOLOURSFIELDMANDATORY
559	FORMCOLOURS	FIELDDISABLED	disabled field colour	0	1	rgb(238,238,238)	\N	\N	\N	\N	\N	\N	\N	\N	2016-06-07 10:50:07	stevensg	2016-06-07 12:40:18	console	1	FORMCOLOURSFIELDDISABLED
560	FORMCOLOURS	FIELDUNIQUE	unique field(s) colour	0	1	rgb(200,255,255)	\N	\N	\N	\N	\N	\N	\N	\N	2016-06-07 10:50:40	stevensg	2016-06-07 12:40:18	console	1	FORMCOLOURSFIELDUNIQUE
561	FORMCOLOURS	FIELDENTERABLE	enterable field colour	0	1	rgb(255,255,255)	\N	\N	\N	\N	\N	\N	\N	\N	2016-06-07 10:51:12	stevensg	2016-06-07 12:40:18	console	1	FORMCOLOURSFIELDENTERABLE
547	FORMCOLOURS	RNAVLIST	visual attributes of the navigation list	\N	1	{\n"backcolor": "rgb(255,255,238)",\n"backalpha": "0"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "0", "backcolor": "rgb(255,255,238)"}	2016-05-31 12:30:44	stevensg	2016-05-31 14:56:50	stevensg	6	FORMCOLOURSRNAVLIST
548	FORMCOLOURS	RNAVAREA	visual attributes for the navigation area	\N	1	{\n"backcolor": "rgb(51,153,204)",\n"backalpha": 25\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": 25, "backcolor": "rgb(51,153,204)"}	2016-05-31 12:31:12	stevensg	2016-06-01 11:41:43	stevensg	10	FORMCOLOURSRNAVAREA
549	FORMCOLOURS	RNAVOBJECTS	visual attributes for the navigation objects	\N	1	{\n"backcolor": "rgb(255,255,255)",\n"backalpha": 200,\n"textcolor":"kColorDefault",\n"bordercolor":"kColorDefault",\n"color":"kRed"\n}	\N	\N	\N	\N	\N	\N	\N	{"color": "kRed", "backalpha": 200, "backcolor": "rgb(255,255,255)", "textcolor": "kColorDefault", "bordercolor": "kColorDefault"}	2016-05-31 12:32:14	stevensg	2016-06-01 10:42:15	stevensg	7	FORMCOLOURSRNAVOBJECTS
550	FORMCOLOURS	RNAVLABELS	visual attributes for the navigation object labels	0	1	{\n"backcolor": "rgb(238,255,238)",\n"backalpha": "0",\n"textcolor":"kColorDefault"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "0", "backcolor": "rgb(238,255,238)", "textcolor": "kColorDefault"}	2016-05-31 12:32:44	stevensg	2016-06-07 12:40:18	console	4	FORMCOLOURSRNAVLABELS
551	FORMCOLOURS	WORKAREA	visual attributes for the main screen area	\N	1	{\n"forecolor": "rgb(51,153,204)",\n"alpha": "25"\n}	\N	\N	\N	\N	\N	\N	\N	{"alpha": "25", "forecolor": "rgb(51,153,204)"}	2016-05-31 12:33:16	stevensg	2016-06-03 09:39:43	stevensg	11	FORMCOLOURSWORKAREA
552	FORMCOLOURS	WORKHEADING	visual attributes for the work area heading	\N	1	{\n"backcolor": "rgb(238,238,238)",\n"backalpha": "0",\n"textcolor":"rgb(51,153,204)"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "0", "backcolor": "rgb(238,238,238)", "textcolor": "rgb(51,153,204)"}	2016-05-31 12:33:47	stevensg	2016-05-31 14:41:40	stevensg	4	FORMCOLOURSWORKHEADING
571	EMAIL	SMTP_ADDR	sending email address	3	1	omnisapp@mydomain.net	0	\N	\N	\N	\N	\N	\N	\N	2016-08-31 16:52:11	stevensg	2018-12-07 14:51:01	CONSOLE	352	EMAILSMTP_ADDR
570	EMAIL	SMTP_SRVR	sending email server address	0	1	smtp.mydomain.com	\N	\N	\N	\N	\N	\N	\N	\N	2016-08-31 16:52:11	stevensg	2018-12-05 16:08:32	CONSOLE	353	EMAILSMTP_SRVR
569	EMAIL	SMTP_NAME	Email Sender (include DEV if not a production site)	2	1	Omnis App	0	\N	\N	\N	\N	\N	\N	\N	2016-08-31 16:52:11	stevensg	2018-12-07 14:51:01	CONSOLE	352	EMAILSMTP_NAME
573	EM_SRVR_FROM	DEFAULT	Default server values	0	1	\N	0	0	\N	\N	00:00:00	\N	\N	{"server": "smtp.mydomain.com", "emailCC": [], "emailTO": ["omnisdev@mydomain.net"], "emailBCC": [], "loginName": "", "senderName": "INFO", "secureValue": "NotSecure", "loginPassword": "", "senderAddress": "helloworld@mydomain.net", "authentication": "None"}	2017-07-17 14:27:43	CONSOLE	2018-12-11 15:52:36	console	2	EM_SRVR_FROMDEFAULT
553	FORMCOLOURS	WORKMESSAGE	visual attributes for the work area message box	\N	1	{\n"backcolor": "rgb(238,238,238)",\n"backalpha": "0",\n"textcolor":"rgb(51,153,204)"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "0", "backcolor": "rgb(238,238,238)", "textcolor": "rgb(51,153,204)"}	2016-05-31 12:34:23	stevensg	2016-06-01 11:37:39	stevensg	4	FORMCOLOURSWORKMESSAGE
554	FORMCOLOURS	ANAVAREA	visual attributes for the application navigation area	0	1	{\n"backcolor": "rgb(255,255,238)",\n"backalpha": 0\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": 0, "backcolor": "rgb(255,255,238)"}	2016-05-31 12:35:04	stevensg	2016-06-07 12:40:18	console	8	FORMCOLOURSANAVAREA
555	FORMCOLOURS	ANAVLIST	visual attributes for the application navigation area	0	1	{\n"backcolor": "rgb(255,255,255)",\n"backalpha": "200",\n"textcolor":"kColorDefault"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "200", "backcolor": "rgb(255,255,255)", "textcolor": "kColorDefault"}	2016-05-31 12:35:32	stevensg	2016-06-07 12:40:18	console	15	FORMCOLOURSANAVLIST
557	FORMCOLOURS	WORKOBJECTS	property info for main objects in work area	\N	1	{\n"backcolor": "rgb(238,238,238)",\n"backalpha": "0",\n"textcolor":"rgb(51,153,204)"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "0", "backcolor": "rgb(238,238,238)", "textcolor": "rgb(51,153,204)"}	2016-06-06 16:15:05	mostynrs	2016-06-06 16:15:05	mostynrs	0	FORMCOLOURSWORKOBJECTS
556	FORMCOLOURS	ANAVLABELS	visual attributes for the application navigation area labels	0	1	{\r"backcolor": "rgb(255,255,238)",\r"backalpha": "0",\r"textcolor":"kColorDefault"\r}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "0", "backcolor": "rgb(255,255,238)", "textcolor": "kColorDefault"}	2016-05-31 12:36:06	stevensg	2016-07-19 13:19:44	mostynrs	13	FORMCOLOURSANAVLABELS
575	.RESOURCE	LOGO_LICOR	logo of licencor - publishers of the software	0	1		0	0	\N	\\x	00:00:00	\N	\N	\N	2018-06-19 11:06:15	CONSOLE	2018-06-19 11:06:15	CONSOLE	0	.RESOURCELOGO_LICOR
\.


--
-- Data for Name: sysreferencelocal; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysreferencelocal (rfl_seq, rfl_class, rfl_value, rfl_desc, rfl_order, rfl_active, rfl_char, rfl_int, rfl_number, rfl_date, rfl_bin, rfl_time, rfl_effective, rfl_expires, rfl_json, rfl_cwhen, rfl_cby, rfl_mwhen, rfl_mby, rfl_mcount, rfl_inherit, rfl_unique) FROM stdin;
95	VAT_RATE	A	main VAT rate	\N	1	\N	\N	20	\N	\N	\N	\N	\N	\N	2015-01-12 16:09:36	mostynrs	2015-04-10 13:15:08	x	0	1	VAT_RATEA
100	ADDRESS	ORDER	BUILDING,STREET,LOCALITY,TOWN,STATE,POSTCODE,COUNTRY	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	2015-01-13 11:46:47	mostynrs	2015-04-10 13:12:51	x	0	1	ADDRESSORDER
18	EMAIL	SMTP_AUTH	IDPASSWORD or SECUREPASSWORD or POP3FIRST	4	0	NONE	\N	\N	\N	\N	\N	\N	\N	\N	2014-03-05 15:57:02	stevensg	2015-04-10 13:13:54	x	0	1	EMAILSMTP_AUTH
22	EMAIL	POP3_LOGIN	login	12	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	2014-03-05 15:59:20	stevensg	2015-04-10 13:13:54	x	0	1	EMAILPOP3_LOGIN
122	DISPLAY_OPTIONS	DATE_RANGE_FOH	default date range selection in financial invoices	\N	1	THIS_MONTH	\N	\N	\N	\N	\N	\N	\N	\N	2016-05-03 12:41:34	mostynrs	2016-05-03 12:41:34	mostynrs	0	1	DISPLAY_OPTIONSDATE_RANGE_FOH
109	FORMAT	DATE_JS	D/M/Y|D.M.Y|D-M-Y	0	1		0	0	\N	\N	\N	2000-01-01	2000-01-01	\N	2015-04-10 13:13:54	x	2015-04-10 13:13:54	x	0	1	FORMATDATE_JS2000-01-01
97	VAT_RATE	C	VAT rate for special items, such as energy	\N	1	\N	\N	5	\N	\N	\N	\N	\N	\N	2015-01-12 16:10:24	mostynrs	2018-02-15 09:41:49	mostynrs	1	1	VAT_RATEC
96	VAT_RATE	B	old VAT rate for special items	\N	1	\N	\N	17.5	\N	\N	\N	\N	\N	\N	2015-01-12 16:10:10	mostynrs	2018-02-15 09:42:19	mostynrs	1	1	VAT_RATEB
98	VAT_RATE	D	zero rated VAT rate	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	2015-01-12 16:10:44	mostynrs	2018-02-15 09:42:49	mostynrs	1	1	VAT_RATED
108	SERVER	TIMEOUT	minutes before remote task times out - see integer value	\N	1	\N	60	\N	\N	\N	\N	\N	\N	\N	2015-01-21 16:11:59	mostynrs	2018-04-19 16:12:28	stevensg	1	1	SERVERTIMEOUT
126	VAT_RATE	E	German rate for 2018	\N	1	\N	\N	19	\N	\N	\N	\N	\N	\N	2018-08-11 07:29:55	mostynrs	2018-08-11 07:29:55	mostynrs	0	1	VAT_RATEE
123	POSITION_WIN	WTASKCONTROL	record of last moved window position for wTaskControl	0	1	\N	\N	\N	\N	\N	\N	\N	\N	{"top": 1, "left": 1, "width": 1165, "height": 196, "speakName": 0, "autorefresh": 1, "timerSeconds": 5}	2016-08-25 11:23:26	x	2018-12-04 15:35:00	CONSOLE	81	1	POSITION_WINWTASKCONTROL
11	EMAIL	SMTP_SRVR	SMTP	1	1	smtp.mydomain.com	34532	45.1122330000000034	\N	\N	\N	\N	\N	\N	2014-03-05 15:33:36	stevensg	2018-12-07 14:55:51	CONSOLE	1	1	EMAILSMTP_SRVR
12	EMAIL	SMTP_NAME	SMTP name	2	1	My Server	\N	\N	\N	\N	\N	\N	\N	\N	2014-03-05 15:42:13	stevensg	2018-12-07 14:55:51	CONSOLE	1	1	EMAILSMTP_NAME
17	EMAIL	SMTP_ADDR	send address	3	1		\N	\N	\N	\N	\N	\N	\N	\N	2014-03-05 15:56:06	stevensg	2018-12-07 14:55:51	CONSOLE	1	1	EMAILSMTP_ADDR
19	EMAIL	SMTP_ID	ID	5	1		\N	\N	\N	\N	\N	\N	\N	\N	2014-03-05 15:57:31	stevensg	2018-12-07 14:55:51	CONSOLE	1	1	EMAILSMTP_ID
20	EMAIL	SMTP_PSSWD	password	6	1		\N	\N	\N	\N	\N	\N	\N	\N	2014-03-05 15:58:08	stevensg	2018-12-07 14:55:51	CONSOLE	1	1	EMAILSMTP_PSSWD
21	EMAIL	POP3_SRVR	POP server	11	0		\N	\N	\N	\N	\N	\N	\N	\N	2014-03-05 15:58:57	stevensg	2018-12-07 14:55:51	CONSOLE	1	1	EMAILPOP3_SRVR
23	EMAIL	POP3_ID	id	13	0		\N	\N	\N	\N	\N	\N	\N	\N	2014-03-05 15:59:51	stevensg	2018-12-07 14:55:51	CONSOLE	1	1	EMAILPOP3_ID
24	EMAIL	POP3_PSSWD	password	14	0		\N	\N	\N	\N	\N	\N	\N	\N	2014-03-05 16:00:29	stevensg	2018-12-07 14:55:51	CONSOLE	1	1	EMAILPOP3_PSSWD
28	FEEDBACK	EMAILTO	CSV list of email addresses to receive feedback	\N	1	enter.email@address.here	\N	\N	\N	\N	\N	\N	\N	\N	2014-03-20 12:06:00	stevensg	2018-12-07 14:57:53	CONSOLE	1	1	FEEDBACKEMAILTO
\.


--
-- Data for Name: sysreferenceorg; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysreferenceorg (rfo_seq, rfo_class, rfo_value, rfo_desc, rfo_order, rfo_active, rfo_char, rfo_int, rfo_number, rfo_date, rfo_bin, rfo_time, rfo_effective, rfo_expires, rfo_json, rfo_go_ref, rfo_cwhen, rfo_cby, rfo_mwhen, rfo_mby, rfo_mcount, rfo_inherit, rfo_unique) FROM stdin;
207	EM_SRVR_FROM	DEFAULT	Default server values	0	1		0	0	\N	\\x	00:00:00	\N	\N	{"server": "smtp.mydomain.com", "emailCC": [], "emailTO": ["info@mydomain.net"], "emailBCC": [], "senderName": "OmnisApp", "secureValue": "NotSecure", "senderAddress": "omnisapp@mydomain.net", "authentication": "None"}	20	2017-06-21 12:54:07	CONSOLE	2018-12-11 15:49:02	console	1	1	20:EM_SRVR_FROM:DEFAULT:
46	FORMAT	DATE_JS	D/M/Y|D.M.Y|D-M-Y	0	1		0	0	\N	\\x	\N	2000-01-01	2000-01-01	\N	20	2000-01-01 16:10:14	x	2015-04-07 16:35:58	x	0	1	20:FORMAT:DATE_JS:2000-01-01
217	FORMCOLOURS	WORKTAB	Colour of tabs within the work area.	\N	1	The attributes below rely on the tab control having $tabbackstyle set to kJSTabsBackStyleColor	\N	\N	\N	\N	\N	\N	\N	{"alpha": "255", "backalpha": "0", "backcolor": "rgb(207,228,240)", "textcolor": "rgb(0,114,250)", "tabbackalpha": "255", "tabbackcolor": "rgb(242,242,242)", "tabborderwidth": "1", "currenttabextra": "5", "currenttabbackcolor": "rgb(0,114,250)", "currenttabtextcolor": "kWhite"}	20	2018-04-19 11:52:31	stevensg	2018-04-20 15:19:03	stevensg	8	1	20:FORMCOLOURS:WORKTAB:
218	FORMCOLOURS	ANAVTAB	Colouring of the tabs in a container form.	\N	1	The attributes below rely on the tab control having $tabbackstyle set to kJSTabsBackStyleColor	\N	\N	\N	\N	\N	\N	\N	{"alpha": "255", "backalpha": "0", "backcolor": "rgb(207,228,240)", "textcolor": "rgb(0,114,250)", "tabbackalpha": "255", "tabbackcolor": "rgb(242,242,242)", "tabborderwidth": "2", "currenttabextra": "3", "currenttabbackcolor": "rgb(0,114,250)", "currenttabtextcolor": "kWhite"}	20	2018-04-19 11:51:46	stevensg	2018-04-20 15:18:51	stevensg	7	1	20:FORMCOLOURS:ANAVTAB:
120	IMAGES	LOGO_TOP_LEFT	logo in top left corner - GIF format	\N	1	\N	\N	\N	\N	\\x89504e470d0a1a0a0000000d4948445200000345000000aa0806000000627de47f0000000467414d410000b18f0bfc6105000000206348524d00007a26000080840000fa00000080e8000075300000ea6000003a98000017709cba513c000001d569545874584d4c3a636f6d2e61646f62652e786d7000000000003c783a786d706d65746120786d6c6e733a783d2261646f62653a6e733a6d6574612f2220783a786d70746b3d22584d5020436f726520352e342e30223e0a2020203c7264663a52444620786d6c6e733a7264663d22687474703a2f2f7777772e77332e6f72672f313939392f30322f32322d7264662d73796e7461782d6e7323223e0a2020202020203c7264663a4465736372697074696f6e207264663a61626f75743d22220a202020202020202020202020786d6c6e733a746966663d22687474703a2f2f6e732e61646f62652e636f6d2f746966662f312e302f223e0a2020202020202020203c746966663a436f6d7072657373696f6e3e313c2f746966663a436f6d7072657373696f6e3e0a2020202020202020203c746966663a4f7269656e746174696f6e3e313c2f746966663a4f7269656e746174696f6e3e0a2020202020202020203c746966663a50686f746f6d6574726963496e746572707265746174696f6e3e323c2f746966663a50686f746f6d6574726963496e746572707265746174696f6e3e0a2020202020203c2f7264663a4465736372697074696f6e3e0a2020203c2f7264663a5244463e0a3c2f783a786d706d6574613e0a02d8800500004000494441547801ed9d077c1cc5f5c79f2dc9926559c5922d5beebdcb36eec61830bd05082594908400091020402085f22738a124d4241092402004426809bd06e38e6db9dbb8f72e775bb22c5996edffbc75d6394977a79db7f56e7ff3f9dce7ee7677da77f6e6f6cdbcd2e8a84a8404022000022000022000022000022000022125d038a4fd46b741000440000440000440000440000440c02000a1083702088000088000088000088000088040a80940280af5f0a3f3200002200002200002200002200002108a700f800008800008800008800008800008849a0084a2500f3f3a0f022000022000022000022000022000a108f700088000088000088000088000088040a80940280af5f0a3f3200002200002200002200002200002108a700f800008800008800008800008800008849a0084a2500f3f3a0f022000022000022000022000022000a108f700088000088000088000088000088040a80940280af5f0a3f3200002200002200002200002200002108a700f800008800008800008800008800008849a0084a2500f3f3a0f022000022000022000022000022000a108f700088000088000088000088000088040a80940280af5f0a3f3200002200002200002200002200002108a700f800008800008800008800008800008849a0084a2500f3f3a0f022000022000022000022000022000a108f700088000088000088000088000088040a80940280af5f0a3f3200002200002200002200002200002108a700f800008800008800008800008800008849a0084a2500f3f3a0f022000022000022000022000022000a108f700088000088000088000088000088040a80940280af5f0a3f3200002200002200002200002200002108a700f800008800008800008800008800008849a0084a2500f3f3a0f022000022000022000022000022000a108f700088000088000088000088000088040a80940280af5f0a3f3200002200002200002200002200002108a700f800008800008800008800008800008849a0084a2500f3f3a0f022000022000022000022000022000a108f700088000088000088000088000088040a809a42642efab0f1ea1ab067da6ddd401a30ae8fe17866ae74306108845e097d796d0d73377c53a1df3f81b0bcfa694d44631cf4b4e04a92d92f6230f08800008800008b84100ff8fce51fdc9c55369fdf272ad029b66a5d22b256768e509c2c509211431a8ea8387b579d51c3aa29d071940201e01bea724f762bc32a5e782d416691f900f044000044000049c2680ff47e788d654eb3ff7a4a639bb08ec5c6fe29704f5b9f87c7016044000044000044000044000044020c90940284af20146f7400004400004400004400004400004e2138050149f0fce8200088000088000088000088000082439010845493ec0e81e0880000880000880000880000880407c02108ae2f3c159100001100001100001100001100081242700a128c90718dd030110000110000110000110000110884f0042517c3e380b022000022000022000022000022090e404201425f900a37b200002200002200002200002200002f10940288acf0767410004400004400004400004400004929c0084a2241f60740f0440000440000440000440000440203e010845f1f9e02c0880000880000880000880000880409213805094e4038cee810008800008800008800008800008c42700a1283e1f9c050110000110000110000110000110487202108a927c80d13d100001100001100001100001100081f8042014c5e783b3200002200002200002200002200002494e004251920f30ba070220000220000220000220000220109f0084a2f87c7016044000044000044000044000044020c90940284af20146f7400004400004400004400004400004e2138050149f0fce8200088000088000088000088000082439010845493ec0e81e0880000880000880000880000880407c02108ae2f3c159100001100001100001100001100081242700a128c90718dd030110000110000110000110000110884f0042517c3e380b022000022000022000022000022090e404201425f900a37b200002200002200002200002200002f10940288acf0767410004400004400004400004400004929c0084a2241f60740f0440000440000440000440000440203e010845f1f9e02c088000088000088000088000088040921380506473802bf7d7d0d1a3360b0951f6c3354789992181805d0295158789ef272410000110f09200e61e2f69a32e1d02d5078fd0c1cac33a59706d0481d488cff81883c0967515b468c62eda555a453bb756d20ef5dab9457d2ead346ebec68d1b51768b2694939f4eb9f9c7de8b3a35a3c127b7a21e0373a951a3180527e16166b56cee1edab3e320eddd79ec15f9b97cef2125441ea5d4b4c6d43cb70965e7a551f33c7e3ff62a68d394fa0fcf37b8a5a486085c12de0b76bac40b0d7c1fad5d5aa6eea52a752f551fbf9fccfbea60d5b1899fefa3dc02f5db335efffbdca25506158fcca796454ded340579410004424400734f88063b41bbcacf9f8b66ee54cfa0c79e49776dad52cfa5c73e97efad367a9592d288329ba751b3e6a9c67b564e1a75ecd99cba17e71aafb69d9b2568efdd6d3684a2187cf9c16bf2075b68d2fb9b69e5c2bd31ae3a76f8c891a3c71fd8d6475cf9fa1f5618c2120b4743c716d2e0312da96956722137ff404ac66fa3995f94d2a6d5fb2308c4fe5873e888f1b0cb0fbcd152d366a9d467680b1a30aac07875ee9d1ded321c4b2202bcfa3a7fea0e751f6da3d913b751d9ee63937b435de43f017e6d5c551ef5d24e3db369d8e98534ecb442e3cf204c8b145181e0200880402d02987b6ae1c097001228df7388a67e7cec9974e99c3dc6e272bc661e3e7cd4f85f348524be76e1f49dc7b3b0c0d473402e8d3ebf88469fd326e99e4d8f7754f343723da16b76beeee5bced384ddd7413dfdb4c0bbfda497c53d94dfc6037e19d4dc68b57b4afbcad079d7375474ae45d909aea233467927a781d5f4ab3bedc4efb761db48ba95efeca8a1a9a3371bbf1e293796a17e0e21bbad2b9d774a226e9d0faac072c410fecdf77c8587c60a17ad18c9d7448dd5b4ea775cbcb885f6f3ebbd2b88f869c5a4823ce6cad162a5a395d15ca0b1881bf3eb4c4d8e5d76dd6096a01eb3b77f7d2cde6f8f57fbc6f11ad58107f51ceac34bf3083ee7f61a8f9d5b7f7c76f9f677971cc6c24ff1ffee68d5194dac4bbb91d730f19f3eddd974c3387c1f27bcf41b974d3b8fe96af8f7721ef7a6c5eb79fb66faaa46d1b0fd0b64dc75e35878e92b1dba11692f35b6750eb0ecde8948bda52abb6e1d9f96735b819ff29558bf35b68de941d4a5ddcb9ffc703e587689e5a84e4d75f7ef9b5f19f78da25eda9582d4437f6ee6718efd6f0e51c84a2ff629ff6c9567af1e125b4634ba56b03c112fb5fc67d4d1fbfba8eaefd459f847c28634e7f7b74a93171b9062a4ac17bd4cedd8b8f2ca1775e584397dddc8dcebea283a77fa0519a84433608b02d10ff0efef9fb95b47f9fb51d211bd51dcfcaf7d17fdeda60bc588de0fafbfa52efc179c7cfe34372116015ca354bf66977aaea408def4211ef5e8cfff7263a74d09a7d00f79377eadb75cdd2eeaf531978c16cfa675bb51737f8b7e8954084b9e77fa3cd9a1e92df478e3217b09358209df2e116fae2ed8d0d6ae244d6d3be5b566884a289ef6e369e79586bc9edc4aae8ac15c52f36fdf8d62ddde9e40bdb8552380abd50b461e57e7a5e092a0bd4ce905769d39afdf4ab1b4ae88431ade8eedf0da266d9695e552dae67cde2327afe578b69f1ac5de2329cc8c8ea767f79f06b7ae7f9d574f9cddde98ccbdb5363a53b8b943804664dd84e2fa90508fe1df899582df667974fa393ce2ba2effdbc376c8ffc1c0c97eaee3f225f5432db46eedb55adec44ed3dfc892aff6f265625b52a1099f54cffbc942ebba99bf9d5f3f7b5cbcab405226e64f1c8024fda8ab9c713cc512b39a23639e64cda4e5ffe6b13957cb94dfbde8e5a68121edcbca682fe78ff224373c28feef1dcf7d45df3e98d6757d115b776a73117b4f5a319bed5195aa1e840798d5aa55e411ffe7d9da35b923a233977f276bae7cae9f4e0cbc30d23719dbc5e5dbb573d18bcfaf8326345876da782927847efd9fb16d264b5da74cf73831342b00c0a3bbfdab1614539b13a136fd707294df9688b61c774d1755de852f54099919912a4e6a12d360874e99b43596ad1697fd921ed52d8d1c7f0330ab5f33995816deb74d30c9f85a2e5f3ada9fad5ed975478ad5b4eacef987b6291f1e638abd9bff4a85a08b36873ec4dab82550b9b6fb08a372ff8baa146aedbdb2d6bf7d39377cea3379f594965ff75dea05b46225e1f4acd41feb3b9e9f409f4de8b6b7c1388cc9b8557d67e76f9574a1dcd3db53db32eddf70ffeb6966e1cfb257dfee6060a924014d90fb643b9eb9bd368ebfa039187f1396004fef1d472faf1f9930327109998aa958ad29b7f5c493f1c3b8196cf933dd89965e13d38045837beef30d96ed1d2b9bb7deb08afaacf9ea02f14ad5ab4cff092ea57c357088422f644da67480bd79a8cb9c735b40d16cc9a38f75e3dc3d08c8140141b173b4eb8e5ec49865014048128b2a5acd161d5e951643e56cd4cc4142aa188078927c8876f9c4d6c5b1094b4757d05fd5ca9f16c5ce5af3a51248fe7c72d36d4e50e24404ca1cd6a45e3ee4ba6d2d2d97b22bb80cf0120c00f777ff8f9427a43ad3639e1b8c4ed2eb17ae67dd74ca7b99383b59be576bf93b97c76cb2e49bc53e4575a3a673795edd1b7b5e37007921d26a7fab962813eb36efd725cd99dc5dce3d4a8ea97734439a97aebb95574c73726fba606a6df6a7f72b0e9c6ff7d7706956ea8f0a701a8b51681d00845154a5d6edcf525c6c319ff71042dedda5665086bbc85ea676223d427ee98471fbcbcd6cf6668d7cd0f10f77d6786e139503b3332b8428057bc1ebd79b6e1d4c0950a5c2a943dfefcfa07b368b2f2f88394f804fa0bed5578d7853d60f9914a04aa73663b5985ce8fc42e83d91e4137f51fe1bc3d11e61edd5170ee7ade11bafbd269f48a52bb0fdaae8773bd74a6a4d9cabe76dcf5b3106cd5199c8e94120aa168fdf272baf3c229c7dd3b3b42ce854278c7832712bf5275d511e361903d90246262a3e4a77e325fa99d6c4fc4e627559bd966ef81efce34dc892662c7388ed6134a9f9a6d0e91129b402715b090836beb2656a95cfdb5bee73add7aa25d3f53b9a897a6af4b765185c0864a5a9f99afa1787ee67575dffb0b77f2ea96637ec7dc6392f0fe9d9f1deebc68aa964739ef5b198c1aa77f564a0fdf341b0e2782311cc75b91f442d1d48fb61aab16aca2960889ed7896ccf65e979d5d64b2da107b8749e4c4bb804fdf3ddf57bdfa44e6e744dbd985e82f9403117e384be4c4f7127b3a7cede91589dc0db45d11e83f5cb61be1875d11afb4b391b334b140cf5ed6bc4ecb05aa73692a2e519fc1ced91361eef17ad48fd5c7aed8d9631a6b99b03b7ba4f804267fb0857e7bdb5cb513edaf6650fc5686f36c527b9f5baa74c283e6e9aaa1db8c1d1afceea70be8f71f8da1f4a6de78c1e23f92fbaf9941eb957730a712075bedad8c6773d53bafd2725c839c16e9d4b4598ae1098a0df7f6a917abbded56aa835f97ec260e26e644e2321ffbf15c7af8b59170d7ed04508d3238b6ca2fae984ebcebe9566adcb891713fe5b6cca06a155f81ed80dcb47d7bfd0f2b888dc12fff917fae8edd62199672d9ae68da27faea90865dd175de5272c2268855e84eb9d05b57ba12270b1c9fa84986336bb3987bbcbd4fcdda766f3f480ffd701676874c200dbcb3273ef6ea1654e7550d343fe94f27b55094a82b16bcabf5af3fafa6ab6eefe1c90dc86a424e08443d06e4d1d0535bd1e0535a51b7fe395a6d67c34c1662e74cdc6eac72ae5f5ea695bfeec5bcdbf68fa756d03577f5ac7b0adf5d24c031bf9c14883232538d7b6ac499ada96d972c6ad18a85ecf47a41e558f573f7f62adaa3fea079878a830c4b8212c642c3eefb079d5440fc1087947804a47170fc70b650624375ce1c997953548c23b57acf3b315e25893b6e275d7163eef16aa4ff57cf9a2565cab3dc2ca599113cefb9ff6b65703e71ecb3dfff7c812b0211ffd6f3d44221ff47e6a9a0d5fcdeb459aab1605859514395ca69162f1ef2f3258734418a4e20a985a2e85db67eb453cf6cea569c43addb3753af4c2aeca05eea3d35b591b1c3c13738ef4af08318ef4871dc2136d276227df6fa06237096db8149df7d610d2d98662f702dbb53bdf6177da8e740f90323f7b3efd016c6eb3b77f7a2af3edd4a2f3db254b92a97bbda7efb4faba8dff016ea61b6a5134382321a20c03ad21ca1dc6ee29da093ce2fa2d1e716d1a0312da9497ac30f76bcdadc5afd3ef9d57b481e5d767337e5cde780211c7df1d646db82dae19a236a756f3efdeec3318ead6cdbe584fcd609b4edd24c3d24641882b3f55c645cbf6de30163ded7c927bd96e3c22d9fa7efc1ad6e7dfc10c482d1b0d3bc89b3b4553958d8bf4fdf5b9e534e1630f7d4bd03dcff3ef33fdb0cbbcb445d7c769f50fd1a9ebd77a10a0aed9ce7e3fcd64dd5ff641b3af19c36d4eb84bcfa15c638c2bbaa1b5795d38695e5b45869e9cc52eeff256eb763149fd0872114d519beac9c2674f2378ae88ccb3a5097bed975cefeef6b564e1a15756a76fcc0d9577520f61c374fb9f2e5f84776ed29582588d528469ed5fa781d4e7fe0559e579e903b7628ea9c45dffb692fe2557ca7d3a8b3dbd0d0b185c4421b07343ba8d4a47413db84fcfe670be8f9896329d5c31553dd7626c3f5ac42f1cc3d0b6d77a54b9f1cbae5e162ed9dc66815b38074c90fbbd285dfef426f2bf7b06f3db7d2963724de01fbebc38be9a671fda35587630127c0bb12122732bc83cd8b615e248e4de4945acd8cff947a26142d5fa01fdbab497a0af51e6cfd412e167fcc3db1c8b8779c9d6a3ca23c8b3a75afbad7d2e0943cfe5f9b1c733c74ca85ede89cab3b8a7f3f6cc6d06340aef13afdd2f66a1c89380cc04c35677cf569296ddf2c5f8c0e0e71594b1a5e8295959b70b978c5eaaea74fa097679c4e3ffc65bfb80251accef18a3647407f48d9b27cf7eede861d42ac6bad1cfff49febad5c26ba86d58d1ebf7daef8219157f1d9eec90d81c8ec106f07f38aff2fff36dcd806368febbcb3abf309ef25a6373d9d7efa7dedd377cda7721b51afd97eeefb6ab7f1c977473b221045f2484d6b4457dcd65dddaf27ab9d4859cc1ab3bc4ffeb13ef05e2ccdb6e2bd3681e25132670bcb546045af12afbe3b95d876811f76bc48127ba21e4ab3c009f53ecc3d5e8c70ed3af62bef867e08448d1ad56e47a27cdbb9a5ca88fb68b7bdacb134eeef23e8ce27078a05a2686d30825c2b4d9defdfd3879e9f3496eefdd350726a17375a7d413e16fa9d22deedb8fede3e3444d9c23895f8877bc98d5d69c0890574dfb7a78b8dc0e74fdda9d4c72aa9b05d53a79a76bc9c171e5a4cd208d357dcd683aefab137f64edc6056abfbe54bc3e9c1efcf14b17ce7f9d56ae7affdf1bee383b304de7f692dcd9f260f769a939f6e38c568df2dcbd986d5298d55a81e797d247160623b71b878f7f1994f4fa1e67969756ac0d72013e8374c2610f34e91178917aaecfc8eeab691d574962adbcabec39cf3ee56b70ef3fbf2f9fa8c9cb027c2dc638e4062bdf3225861bb4cca6f9d41054a058cdff9c51a38ec918dede10e29cd1b76afbe51796364352f7e5e6994a052d1d33f9d6fcb91548a322fb8e07b9de9db77f6725d7d9b11f3e23ebfd62d2ba30ffeb68e26bcbb29349ef2422b14b101dae53fea6ea8d6f04ab21b899d0dfce8a162c3139aa47c56ff1aaf6c349c76b8c06a799fbeb65ebb49ec81ebce2706d1e8f3da68e7b59b81d52c1efcdb08bae7aaafb477b77832e555d3a1639d137cedf62759f2b32dc1cb8fc95530b3b2d368dccbc3c96d812892f70dffd797d8e6426affb447796bfc8b7228f193a70645168bcf0127d0a66326b56a9ba9ad1ab2614599ba5f0e1b9e33ddec2247b677ca26d56c27abd0b92d14f103ecdaa5fa8e718a9576869d84b9c70e3deff3f25c3fecf4d686fdcba0d105a15169e758770ba7cbedb6d9c6f60ef5dc35e68222cf07ad53af6cbaf5d1625ab5682fad5502924e4a50f99542a93e77ea45ede84fe34f35ec0ddc1288cc9b870dc6cfbeaaa3f955fbddae6d52dd0a3942fb732a9e80245da776d4fc1088ccb6f61c94ab76e0ba995fb5defffd97d55ad7e3626b04de5771b53868ae24f1c204ab4676ee1ddb764f52ae953cb73c3240fd39cbff64a67eb485766eadb25215ae09100176cdad9b0e2bcf98929d10dd7a589fdfe9e4469975dbc8b6a9baf156d233526c39e6e13660eea93b12c1fb9ea6ecc6d866e581bf0ea3bf979c49b73f36c0589c0c8b8d2fc76f7a4bd944db4937ffbabf2f02919d362772de500945bc5271ef9f872aa97ba0725d98eed9b85da7f43433b3649b726b16ef23b561e4589afcc1666d0f4c5c394f6ce75dd3c9b176480bbafca66ed456a93ceaa6c5b376d10a8131b06e3d61ba9e5d7c4e786793a8cbac0671cf9f8618869ea2026c66621deabb9e1e4452952a7e5096ecb6da6c36b2db242076cdedb25d11cff1b3be74ce9ec8c454aa3ce7497671ccfc56de570854e7d853969d0763cc3dfa9a1e56c6d2c96b7841f8b9ff9c42b7fd668011a6c3ed056827dbee54596ccfcc9a05d274ddbd7de9cc6f759066473e0181d008451c5fe4a90fc6d0f0d3bd71511a3916ac3fcb8e092489fdca6f5ee35c204cd6c1d64dcceea65f05c3e316ff91de38ae9f6e178ceb3f7c799d281f32452730fedf9b44365e5cdaa917b7a30142c3f7e8add13f9aa25cebdfa83cc9a5a4caa6c1cfded840bc1288943804a442f0d2b9bb5ded242fd8d879788ad7b8e92a90ab9b49b2d864d7881b734f70e71e16781ffbd768bafb7727287555e7eda1ddbc979d2efbbdbfae111779d1755d94794767717e649411903d0dc8eaf22dd7f9dfe94cbf79f344571c1658edd4696aa7459ad8fda513e9eb99bbb4035af20323db4e38e125c8893e7019fc30ddb14773ede216cd90ebf56a5716820c1f295d6949e25dd3ef2a57ee41481dba67d1b9cab5a924b121fbd48fb74ab2228f4f040a8a32889debe826f6aee6e48e7dddfa75d4dcd81daf4e9ae9b250e447d056cc3dc19b7b3866ce4f7f3f987efbd689b6552375eeefa05e3b77d20ec34184a47d2d8b9a1a4e15247991c71e81a4168ad866e167cf0ca61f3cd057b9c776c7998255fcec28808d7c2569d5a27d926cf5f24876894ebba45dad784cf50af5e9c01997eb6f29b37b6ef6e687649f000786e4b83d9274d9cddd3d555f6da88decc8243baf494397453dffd12beba21ec7c1e0122856f18a745345f9215abfa25c379be5eb4bc65b579dbb54a91077e86e7d51880da43900ad1b890398976ea8d02a3a2333d596da2ce69e63b88334f7f0eed053ef9fe4abcdb1d64de8c1c5effc556ec77cfd7d7d5df732e7018284ac22a985a25e83f20c4f27411919564393a495caf387dd54bae100e9fcf1727d1c5cef4ae57e3b88e9940bdb8ae240b18b5a24fb04a4aa881cf09883a906293553b68657dfd153d42436c0776ad142d40064d2261034bb22f6a2c62e87ad24dee5e2dd4dddf870331c8c7f14d94e8916436ff500cdaaabd284b9e718b9a0cc3d63bfd99e1efec748cacd972d2c49ef8320e7633bbe05d3649a298346b7a49167b50e72f792ba6d492d14056de43af5b2beba17d9f65da5f6bd5c715c16dd606be77ebba3113b20b22d41f99cdda2090d5493876e5a02a1481759bdeb59c09e3d717bbde3560eb02746bf776da3b593d55b796759923e7e759d241bf2f844a0df7059dc1eb7ec8a4a54b800ab69848a1dc269e4997a0f4d335c52a113d913093c009a7c30f798248ebdfb39f7b0ab680eb8cd1ee5ec38cda8dda3e4f8f6aed09688c39efce00199cd747290f3bf17108a3c1c03a9ebe10a15c0cc4ee2d8175fbcb551bb88a07b3de9a922a2eba6a573b053a4cbaceef5bce3c831b474137b9c1b6dc30db66e7d3ad737496f4cc34e9339619935c1fa43ad4e9b70ad3b04720bd24536894b5df24037f30beb8e10469c714c18eada2f87d8eec06a5aa61c45b0aa9bd349e2aadc8e9305cc3db547d0afb987ed42effbcb50bae8fa60edfad7a6e3cf3776be334d686b3ae49456c441c691fc2300a1c843f61c084b92d8fda8e019f47855cbe7ed3582551e3f60e103bbbd6ed755df20d942d18e5d225147dcb0723feddf77c8b13684b120c9831073e238536ce81ed474e239b2a0c4ec708157b091128780e4c19c6d67f63a2c5894ef3d4456557af35a66a8df50de71c83a2a74ec42bec40597df2b35c31cf0c3747715d45c9a30f7d426e7d7dcd373601e0d3915c1d06b8fc6b16f2b9463ac6a61ecbe9395590092bf04201479c83fbf50f640c8abf2ec9a5b9a242a63c3ffaba621add38b7c12a188592e9dbbc78be6256d1dcb84fca46ee9bd023958add249e389491fd6bcea1beaa94d4012c4954b58e6f04ef31ca586ca028b95c473726494786d15bacfacef485969cfe6b515b4bf4c6f81a9f7e016d438456e4f84b9a7fec860eea9cfc4cf238b4b64da2899cdd3c4da0a7ef637d9ea8650e4e188b271293b2f90a403cafb91344954c64c350d699d5ee46b9e9b46addbeb7bf4dba2fecc916404f6ec38483bb6e87bf03354e7ce95edc4c85aaa9f8bddce0f1d2b53a16397cd488943a0efb07c629b08dde4f482cacc2fac7b9dab3b27f7199a4f6c5b69352df86a27551d386cf5f206af93046ded2ff0fc673604738f49a2f63be69eda3cfcfec6a14f248917398214fa44d28764c803a1c8e3516caad40724496a577444c596d45d494a53825ba49a86a4bd5ee529d0d0ab37db54a1b9ba69e6c3bb5a2917ee1275e9934d2d843ba55e721f7aaa4c285a360fbb8f5e8e93ddba78414562e32959608ad556b63d983bd99a3d1aaf22d7f59ad758fd7bebd8c1b14acf9c49d6ea8bd5e6c8e392f84475fb10595e439f31f7442784b9273a173f8e1e51bbbed2f180ea9c1f2356bf4e0845f599b87a44eae14afa20bf4ec5a8d055bd2bea98594b4dc35520360b97c497814d911cba74c2efd853664f276fa92c67c79e320f91ec82f5907ac8454a1c02925d8bd58bcb88851927d2c219bb2cdb7ab2017634af8d23cfd2db7d75d20b9daee7b92ce5fabe4b5fb93d11e69ee8771de69ee85cfc38ba7af13ecbbfe9c8f6a567a4d45bf4883c8fcfde118050e41d6ba326a9cd42cd21d91fb164655312f1dd638cc7abd3511f313341283249e8bf2f17ee88706c9544486dbb64a9182afad322ff3e577fed4c90e544e0940c6d94ec5a1c52bb2dab1c1a672daf73315c700f3cb140cb95bc61c35463cd8629de18571f3c42fc30ae93fa0c51f644fa3fade35560ee398ea2d607cc3db570f8fa456a4fd4a147735bbf0d5f3b9d6495db98a2928c8447dd91ee14499b2771b2d0b673e2b88494ec144977dda463902cf90eab872969a0d28e6ad24f84c4abf16dd44ea92449d48924f5208f3304f8213d4560f42f55e3aadbea92f1d654d9589d79f0c9d13d7db10d42ac7375ebe3efec186191daa1b29bd6a815f1c3357a0b75fd6cd81361ee893f62987be2f3f1eaecd725b2df964495d7ab3e85ad1e08451e8fb874a748da4c496c8d42e5bca0e6d0d18478b14a866ed2f598a45b7eb25ebf71f57eb1ab515e094b94d4b1874cd58f1f149112874066f354ead65f3fd6d912073cd0f1aee2ae526b0e4b068ce2dda0d80e7a745c73f3e838a142a7ab3ac7f5168f28e03751c2dc131f1be69ef87cbc3abb64b6ccb6541aaec5ab7e85a91e99d57f980839dc57a9a30549332a2b0ed3ceadd6fe7823cb7ff6de85c4af644dd829928d6c9930460b2f04e8049a94b5ceb95c1d7a64d1b44ff4cb2bdbe37c704cfd5620870e01b62bd27544c371dfec263daf73f19d7fb0bd11ef1859b5699ba9822fdf38ae9fad2ee8326b9edb843a2b672bd284b9273e39cc3df1f97871b6baea888a8128fb0fc04e91172364ad0eec1459e3e4d8555eaacf497fa08e7536a005c1a6483630fbcb64137ebbae89b34bc464da7793b517f795ecbef23357b1da85d14d7b7654d90ed66b552862b7e1c34f6f1db789bce3a5631fc53b54929d9ec846e8ba81ee3bb4852de73d987b22e9d7ff8cb9a73e13af8f94ef95fd3f723bb153e4f568c5ae0f42516c36ae9cf1527d8ea3a523d527809da2fa4cac1ca9289305109638c3b0d21eb7ae91d8a9715b705fb93522ee95dbfb843c516c103b7645db37572a2705d6542d7ba9f6e5e4371c8bc84b15babd3b0fd2b64d07b40645e2e92fb202cc3d9134ea7fc6dc539f89d747a482695ecb0c6aa61636908241004291c7e3909e195b37dce9a6487fa44eb72368e51dac722e8061d0fae6667ba4f7533c7b0837db2b2d5bda5e3c984889fb972fbd690af51890a7dd003b7645254a7dcd6ab22aec0c3fbd502b18add59daa68ed5cb9d09a401799b7ff48fd1db9c8fc987b2269d4ff8cb9a73e13af8f48ef5108445e8f54fcfa2014c5e7e3f8d946fa41d4c56d80fa9c181d324621209df49b6626d62a9854c5150e3ca2dc340970a8ffc87ced562e9b2333a8e68a4abed0108ace88af3a67363cb7209d7857c96adab8aa9c3629c72992a46b4fc43bc59d84f1bfccf661ee3149447fc7dc139d8b9747a5ea735eda997bc92351eb825094a82367a1ddd23f120b45e392101290ae4626daa49f2114e2d8d09de3b72025168101825d8c0d2bcba972bfbe3a6945790d5975dbdb49053c6eddc1ba7b78ed40aeff29150d94ae3d51bf61fa4267dd8661eea94ba4f677cc3db579f8f14d2a987a6952e1079744ab134251a28d98467b6153a4010b973648403ae96778a832da60272c5c20559fe3a2a50f6f169a854b5c22d063602e7144799d74e4c851e5b54edf0bdddc49db55a8036b82f388b3aced1299ed66153a9d34e373eb3b5666b94755dcd7150bf5fa6dd79e88ebc6dc638e40ec77cc3db1d9787166bfd0863bd1160dbd60e9671d108afca4ef72ddd829721970c88a97de4f527534bff0da69af94915f7d45bd64385ae835d8baea99c94c6257a4654f645175ce6c0fef2a75ee9d637e6df07da5126e766fab6af0bac80b36afd94f07caf51cf8f4b7119fc8ac5bfabbb2f35b36ebf6f2dd4e7ba58cbcec5f32d7255d84ceccd28fb598cc1cfdee1b8422bf47c0c5fa3149ba083784454b5722edfcd1fb81b9714a234a4bd7db3930db296564e6c7bb3f0424814575ed8a0ed71ca5d913b65bea6061bb4cea2288eb33f24cebbb4b47d5b68faec305ddddb13c65ebd4a17b96a53ec7bb48fabbc2dc138f2ace3949a05c18a3c88e668293ed4759c70840284ae23b4177452f8951a06b0e10387c58e9ce0812c75a49b4d45838334a19251a9f646baf4e9c1fb3efac4676c49a269c916571c96eaab0b8cb62d5eb9cd916f35d57e56efa677a76452b16e83998e8eb803d11f74dfabbc2dc63de1978779b805470670f9848c12190586ea182c32d215a225d251b75761b6ad7c5feea5e424042232d1368962d9b2e2a0fe81ba45b6e940b17b2ddc4c14a99dbf666d950857061485c2fb25bff1ce2f9b2b2c2fabdca8b4e1b5694590ebc3873bc75016484a6ea9c0988bdbcb5eed04c0597ad300fc57d67a70fecfcc1aa5b605d270b4ed813710730f7c41d46e324e69e8619b979456a9a6c25adba4a6365c5cd0ea06c8380ec2907f012824056aeec016de8d8423aed927609d14734d23b02cd9acbee279d074def7a13bba62a8d07e3baa5640919d52d07dfbd259092da88fa0c6d4173265a536f335bb754b9e6b61a8ddeaa2b6e7661dd7b480bb30aed7756a17be785d596f2b1d387595f6ea3532e6cdbe0f5bc50b06e797983d7455e20d9818bcc6f7ec6dc639288fd8eb927361b2fce48efd1aa4aeb0b315ef423ec75c844dbb0534b90fe37cf6938127ab4ae48b781a3958563c943202b472814095c17fb49cd8e10275dd1f6b3bfa8fb1801895d110b4556120b13db361db072290d3b8d03b15aba34ea452335bdd6cdf8dcda0ed69ac56574b8c6faaa767e6106b5edd22c6a1b750f62ee699818e69e8619b97985d4b5f6c10332ad0437fb12e6b26d4cbd61c696187d97ee14c14143628cafd7ad143f985424d6a45f29fc934a510e1ae05ed5ebbbd2b9fa8a25415ce7eeb6d480991a3181469ed9c65299b12eea39288ff25a66c43a5deff8bc293b88e3dc3494966bda13f51b6e3f3e91d926cc3d2689e8ef987ba273f1f2a874ee97aa6a7bd9b730d505a1288947bbb9507d0e425112df1436ba26d559b7b3f362a3b9e2ac92a09c5c592654e7c4cc8390b1739f1ccad2b4092bdd7880f6ee3cd860f3adbae2e6c0c103471734585ebc0b1a29bf26c3cfb01eb3887f9ff3a7ee8c57a4714ed79ec849a108734ffce1c1dc139f8f1767e5ea7389b568e8054b3feb8050e4277d97ebce12aacf412872796012b478dd0746b39b5221c3cceff5bb5488933eb879dd3fd4179d00abac491ee41b52a1db555a45ab16ed8b5e699da3278c6969c44daa7358fbab8e6b6e2edc8a0addf2f9d65405cdc6168f7070a748535835db80b9c7248177b70948d5e7aa849a096ef727ace543284ae29117ef1495e905e74b6284e85a0401e9437ff9deea885282ff51ba282055f1093e91f0b450e22d6de99cf82a74b3bedc4e1c13c84a92bae2ae5b36074cd559b99e35615b5cf7e2bbb71fa41d5b2aeb5613f37bcba2a6d4a69333f6445c09e69e98a88d13987be2f3f1e26c667399dfb244fb7ff482a59f754028f293becb754b1d2decd4f8f373b90b283e4004a47fbc1b56ed0f502f1a6ecaa635b2f6c2d0b961b641bf42e22d6dd9dcf83b28565d71b34b5ff6fce9444a4d6b44434e6d65b92856018c27dcad54319974523f87e213997562ee3149447fc7dc139d8b9747a542d176e58085033b2305830084a2608c832bad903a5ad8b0b29c124dedc0158028b41681ec3c9937438ee7b2734b55adb282fc65c30a3db7c3665fb2b2657cccfc78f79f404715e727273f5dab21ab9794c5745450a99c8c2c9cbecb5279fd956302abf182ac14e8a4173a5d7ba2fe02a715f1fa84b9271e1d52b670987be21372ffacd4ae8b03135bf54ce97e2f500384a224be0732325328b740ef0f9e711c39729496cfd75b194c628ce8da7f09f003a33440dd7a15e43251d27acd582c66bfda7743c063934522bfb370a2930e1d3c4cab1646b7199a3f55797653e7ad24a754e7ccba4e18d38a9aa4a7985f1b7c9ff9c5b698d7acd0f43cc7ea7b4e26cc3df16962ee89cfc78bb3d942c756dcb62d6bad055bf6a21f61af03425192df017d8441009734a0279fe4d8d0bd2804d29a34a6cebdb3a39c69f8906ed0c7864b74e78a236ad56ef35a99fa5ccf81b9ee340aa57a4a40645714c335773c4123b2538d94cbb8e1a73ba33a6796cb8b62834e6a697e6df0bd744305ad5d5a7ff182cda174d4e70adb655261bba60dd6a77301e69ef8b430f7c4e7e3c5d9162a2e97744773cb3a08455e8c91953a201459a194c0d74875bb97590c4a98c068d07401819e03f304b988a42a69a2ca6c64daac56ecacc46c8956450f219b6865e1987f048a47e9ef7244b32b3aa242ffcc560e0caca4eec5b9c40f554e27dddda71951e2296d543681073402304b3cf859e937e69ed89430f7c466e3e5992ecaadbf2461a74842cd9d3c108adce11a9852fb0c6d216a0bab4bf09f3a12084412e83948b61b126d053ab2dca07c5e2fb4272a529eb6a4de1e83d277b4e31881b69d9b51bea680b27c5e7d670becb8a06c8f35cf8bba2eb4ad8ed530e5b881037b5a4d333eaf2fc4e9abcee9a91f5a6d1be69ee8a430f744e7e2c7d12e7d659a14ab174757bff5a30f61af13425192df01aceea4e39ad5c4c12b830bbf6a38a09f793ddec34140ba5abb6e79993226b5eed2d72f9a73276f17552de522aa0c995c27a06b13b347796fdb5a4705a6248e8d4edd0ee8eee8d4cd1feb7bf3bc34eaabe1096eedd27df57ea7ba4e168a1db62732fb26fd8d61ee3109e2dd6d02d29d22564f2ddf8b50286e8f8f95f2211459a194c0d77074f35e83652a4feffe754d02f71c4d778340eb0e9994dd42e6e968ea475bdc68926365d61c3a4a333e2b1595d77390ec3726aa0c995c2720f19eb6b48e6bee995f58bb97da75cda2b65d9c8be953178eaec035b38e0a9d8ed31ddeb52828725e0d90fb84b9a7eec81efb8eb9273a173f8e76ed27539f63e756ec9405c97f02108afc1f03d75bd06fa84c9d8157cd37ac94199dbbde2954e01b819e036402c0d48f832d14f19fd27e61e062183afb763bba52b1ae073a6e44a45dd1a6d5fbc9aaf1f4c833dbb8d207b3d011a7b7363f5a7a9f1eb1305075e0b0b207acef7c2156417d85ff35b1caab7b1c734f5d2244987bea33f1eb082f0a6464ca82b8ce9d0ca1c8af718bac174251248d24fddc7798ccae8871bcff22768b92f4b610774bba32b9faeb7df5548cc48d7021e314e14e567a460a75ea25d32577a11b28d20102bc2bd1aa6da65649913b4556bdce710523ce74d6eb5cdd46f3ce0d3b72b09a96294f7a65bb8fd942b1ad03c751b19a243b6c56cbe6eb30f7d4a685b9a7360fbfbfb1664e973eb2ff82b99364aadb7ef739d9ea8750946c231aa53fddfae78aec8ab8a889ef6da67dbbac190b47a91a879290806e50c84804533fde1af935309f6baa8f90ce836c64c37b0f6e4129a9d68dd923f3e2737009148fd2db61dfa8825e5794d7181db2aa3a97dfbaa996c022a5a5a342c742d0ccf1c71c2ee8db13e931d3ed0fe69edac430f7d4e611846f52bb22b64b5c5cb23b085d08751b20148560f853d31ad139577714f5b45a051e7ce5f165a2bcc8949c043850a0ae21ba49e2e37faca7eaaae0b9359cf8fe663a502e33743dfbaa0e66f7f09e4404741d061841af9517babdeae1c6aa30e1746ca258f8479ca1a74237f3f363f650cbe7d7f7aa17ab8ea2ce59aeb8158fac0f734f240d22cc3db57904e1db0963acc706abdbdeb7ffb4aaee217cf7980084228f81fb55dd37aeed4c691ad1cd23dbf9f99b1b68f2fbc1b607896c2f3ebb4fe0dc6fcb84ec5da59514b489bfb24209fe8fc9047f5ee9d77de0747f745083130424f176d8ae68d684ed2a9c813595333b3b1f3a7d6461821d3a584d0b94e751b627d271b2503cc2dd5d22b3ed987b8e91c0dc63de11c17a67a128273f5dd4a8394a856ecd12eb367ca24a90292e01084571f124cfc9dc82743aed9bedc41d7af6be85c4812d13357100c25bce9e44ef3c0f1b2927c690e3aab46825f332f5cef3ab69e7962a279ae148196f3cb38258754192ceb9aa2335d6880323a90379fc2150d0268378f743272d55f638565d7167e5342169706d9d3699d7ea3874385875983e7f6303f12286d5241122ad961d791de69e633430f744de15c1f9ccff0763ce2f1237e8ede782b55bf489d2eed8b4263c0eb72014896fddc4cb78f1f55da8716399ed4365450dfdf696397448d95e245ae23ff73b2f9aa23ce995d3d1a3d6567013ad8f5eb79727feb3ae94a98df103d74bbf59e27593a3d6c7b1653ef8dbdaa8e71a3a98d6a4319d79858c414365e37c3008148fd4dbfd583e6faf65d7ba434f6de5a92d9aeeaed45b9a0f67baaca4238cb98708738ff4eef126dfa917cb17a0bffa742b0521d879a58a55f9d86d73e9b9ff5b247aee4bd4472d0845defc4602514b1be52e72e45972f7af6b9795d1533f994f6c949e08898385deff9d19f4cc3d0be960e5e144687242b5f1ac6f75500f75b22964ca875b68ee247f5d90f2a4fde707178b267c1ea813cf29a2dc7c59cca6841ae8103756d7aea8ea400db1d06f25e9383fb0525e43d774eb9f43056d9a3674d9f1f3fb7659df3d65d53cd646f02a61eec1dce3d5bd26a9877f6bedbae8ed329bf5b0eaed2337cfa10a617808b31c3befacc277c7855348ea91d54edd7ee7953dd1f8dd6ad42f2670c90fbb8af372468e3573efb76704da231ddb88bcfae472bae5ac89b460da4e5bfd45e6d8045a1466901d43f147d5cee38a057b6357e0f299e7ee5f441c8b4b9acebba693342bf22508817ec3e5e10ce275915d29db31c88e5776bc736ed9bfe90a8ff1da68e51ce69e4e5630e11a1f09d8d92d2add50418fdf3e4f69b678df818f5f5d4f775f3acd729c35ef5be86e8d108adce51bb8d2790563e08972ef28dca1a57376d34f2e9e4aeb979707aa7f35878ed2a7af6da01bc77e496f3ebbd2f28a6da03a91608d61215baa92c9abea0f7ebfc49700c12f3dba943efde77a316d8efbd27390f5d82fe28a90d15702bcfbd1b14773c7db3070744b4a6f9ae278b90d15e8d6ee94dbf189a2f50b734f342a38161402275fd8961a71e0226162a70baf3eb15c985b3f1b3b57e1dda13f3da0d4e594d7e1b0260845211cf95b1f2da6e6b9f6d47eb66f3e403fbb7c9ada39f23fee0cbb787effa5b574c3295fd21fef5f28369a0fe1ad60bbcb2c1c5c7c837cf7b17c6f353df0dd19c4aa8e5ea5379f5da51c6eac1657c72a83378deb2fce8f8c8945a0786481e30d766bc7a6a186f65381bcedcefd75ebe007bffec3f56cafea9621f98eb947420d79bc22d0aa6d5362bb413be9ade756d21377cc23b6ef712bb1aadc03df9b49f75f338338c07ad81384a210de012d8b9ad24f9e1a245ee137911d503fd4dfde3ac7d8359a3351ae866496a7fbbe75fd01fabb72a57cdd98f1f4c2af176b794ad2ad0bd7c72670f5ed3da84377f96afaae6d5574a75aa19af0cea6d8953870a66c77b5f107f3ea9332f7db6613aebcad07f18e2b523808f477d8d5748a725232ecb4425fe0b193023b2aafd11adda17b1665b7b0b7c816ad5c2bc730f758a1846bfc2270ddbd7d0ca71876ea9fa462e8dd76de64a5a1633d669895fa58d3e7c93be7d31ddf9842f3a6f86bdf6ba5bd5e5d03a1c82bd201ab87f5d9afb8b58723ad5ab9702f3d785d09fd54e9a1f216ac9b898d0f7992b84fd935dd78da0423e68d8e41b09b6d0b6bd9a9ca0bdbed8f0d143b5d606ebc63f4d45df3e997d796d08e2dceef1a4d7c7733dd7ce644e3deb1334e1c41fed29bbad9290279138c40df61f9b6179022bbdc7b88daadc94b8b3ce4e967a755e8a4819c9de834e61e2728a20cb708b073ab0bbfdfc576f1db361da07baefccaf88f9c3f75a78a83262b924393fcf3f72be847674da25bcf9d4413dfdb048fbc7550a6d6f98eaf2122f0ad5bbbabe07c7b8875579d48cb543477de826ddd3e930628bba5012716d000a57a62e70180ed84d629af77dcc6b99377a848f17be8f0611fac0f9d0094c465f0cec9654a5878fd0f2b6cf5921d1f703c290e367cd2f96dd50e94cc830f3782bd24ce552b601fbebc8ee64fb3bf129699954a773e31503d20dbea2232271881e6b969d4b97736ad5eec8c6a09c7d9f133b13d534666aa0aceea8c4a8ed33b69ba6c30f7e812c3f55e12b8fc47dd0d2d08d688b093f8b987b529f895a76c1d4fbaa02d0d1a5d40f9ad338c988191bbb5876b8e12d7b7736ba5111390e30c4dff6c2bad5f112c3b703b3cdcca0ba1c82db209502edb00b21added174c21b611722a956e3c40a5afafa7cfd48bf5cdbbf4cda6de27b4305cb666e73551aa166964bcabcf4dd58326ebcbb22ade81f21aaa283f449c9fb776d72f2f3302c6d61c122e8b38d521946389c0b76ee94e25e3b7a988dcf61e1e3926d61bcfac345eac9637fadc221a75766b6aab5c9ca6a4c6375ce57b69e18c5d344dd9ba958c2f35ee2b4b8db770d10df7f7a34225f023858f00db1539251439bd53a33b1a4dd21b1b9eef381e8addc44e56bc0ada1aafad987be2d1c1393f096464a6d0b53fef438fdf31d7b16670b0f1f75f5a63bccc4253d31a535ecb74e285e4bdea3c62329a64f4de2114e9f14abaabb372d2e8177f1cac9c267c45d52e781ce11f261befc1802fe96e9d7a1d6281e5f6c7071a6a944ead4273c0ddd77eb7dc78b180cdab612dd4c49fd72ac3f803a8563161766f3f487b765419ef4ed55bb773a3ce6e43a75d2a0fc857b73c7c4f2c02bc1bf2ce0b72e71c666fbbf6cd21b6e9f43b7120572784a28e3db395e306ff54014d8e987b4c12780f228131df28a24f5e5b4f8b67ed72ad79bc78ec86eab96b0d0e68c1108a023a305e36ab6bbf1c7af89f23e9919b661b5bae5ed68dba928b40a79ecd69dccbc30d57dbbcebe76462019bedc7f8c58184bd4a034615d08f7f3bd0abea504f0009f4517640ec20c1aeeaaedfbb4426da21a71612af2cdbdd85f75b75ceec0fbf63ee89a481cf412370f3affbd3cf2e9b46fb7d0cca2a6192a66c8679ae600d8e302468c78761942df4b1c7805c7af2bd93a8d7a03c0b57e31210884da0d70979f4d06b237df34815bb65fa674e3ca7881e787138356de67d4c19fdd622875b04329ba72a8f83f6e352f9e58abb2e9766aa3f4e08344e9451b76d76be63eeb1430f79dd24d0be5b16ddffc2305fe29349fbc571da7efdca48c34e5cb70c36cf48c404a1281147cda536b33eeac3ea61f6f4cbdabb54038a0d0b812e7db2e9d1d747517e6146c276f9dcab3bd14fff70825a254bd0d93d61c907b3e176e315b5e9d88c3aaa9dd4a0a49167b6b1d514de390b823d51dd4e60eea94b04df8342a0f7e03c65ae30c4d879094a9b62b5a373ef1c7af29d93a8f790702d9443288a754784f438bb38bdedd101f48307fad972b11c527ce8760481765db3e8d137465161bbc4734e70e58f7bd08de3fa294721111dc2c75013e83fd25e80d2a0ec12998338fc8c42c3118ef95df7bd93f2c8c73b4e414c987b82382a681313e07028773e693f4ea49b344ffe465b7aeced13a9a028711735a57c201449c92579bef3bfd3c9b00d098251b013a839faf98f1e2aa673d4ea3f927704d85b1b0b469d9441762224f6a675d3b8fec4015a91402092406fa516cafaf5d214147b22b3fdac19c0ea66d2543ca2409ad5937c987b3cc18c4a0404469fdb86d8c62868896d8778419cbd1237c990cf7541eb974e7b82b9cca3d3035ceb1a01d617fff3976369fcbf36d2dbcfad220e20964829b3791a9da2563ccebab28311672491da9e4c6de5380a4f7f70127df8f775f4ba0a1c175443530e4279fd7d7d70af24d3cde7605fd29ba6508f0179220f521c57c48e00e260376a15c5319396ced95deb98d52ffdd4ff43d013e69ea08f5078db77e6b73a280faa19f4c7fb1606c2c155c71ecd0d87421cf72bcc0942519847df42dfd99ee2ac2b3ad019cace68c23b9be9ade756d29675151672fa7309ebb9f3c3edc917b6a593ce2b0aed6a873ff463d7da588d0b07643df5a276f4ca13cbe8f33736a8a8dcc108c25bd4398baefd596f62752224108847a07854be48281a767aeb40aa620e3fbd905e7c6449bc2e473d9792da98fa0d6d11f55cd00e62ee09da88a03d2681a1635bd1b39f9d422f3ebc843e7f738379d8d377defdbef886ae74c5ad3d603fabc84328f2f4f64bdccaf88f85e3b49cfacd7634e5c3cdf4e6b3ab68e3aa604447e6f835bc0a3be682223a5105facccd6f92b8a093bce5cdf3d20cb58173aeee48cf8f5b4c5f97b817b7a1219459394dd41f41773aef9a4e0d06856da82c9c0f07015619fbe7ef56687776444005ee369d9a19aaadeb54a06c9dc4ce0c38f0762225cc3d89345ae1692b7bb6bce591623a493dbf3cf38b859e69e4f002323fcfb1aa78b298493871d724d6ace6448f51862d028d959a291be18db9a02d2d99bd9b164ddf450b67eca4e5f3f7d2211782bfc66a6c7a460a75576ec4879cd28a4e3abf083fea58a0027abcb332d2e6d85833bfd8a684ec2d3467e276723aae51acae77ee95ad76855ad305dfeb1c88c093b1da89e3c123d073602ef1dc7350050db69a3295f0c0b1ae829a46a840aeba42915d4f7c7eb2c0dce3277dd41d8b00cf11cf7c7a32fdebcfabe9cb7f6fa2ed9bdd315760953d5e403efbaa8ed4b673b358cd09edf1462a2062307458423b04c9d1f1ea834768d99c3d8680b468c62e5ab970afedc0809164f887ccee2c7b0f6e417d948bc82e7d72b0ba1f0928c13f1fae394a8b4b76d3ccf1a5346bfc362adde8dc1f425a7a0a152bfb87a1630b69987a85d1a34e82df1e683e08b84600738f6b6851b00d024b67efa149ef6fa6a99f6ca1b2ddd5364a22e285999167b531cc0a78418317b791a2138050149d0b8eda2470b0f230ad5d5a46657baaa97ccf212adf5b6d7c36beef55dff9b83a56515e63448a6fa2565f9ba437a634f5cace6da21e5c9b52abb6fcca54411373a87587c473eb6c1361a8b36f58514eb3bedc6ed8afeddd7990f6ee522fe3bd3ae68e6433e5588383cdf12b47a950728c24fe031838ba20a102e6857ae0d17910f09900e61e9f0700d5d72270e4f0519a376507cd9ab09d766caea49da555ca3143655c418955c33b74cf32e2a2b18df5b0d30a8de7ab5a05e34b5402108aa262c141100081a01260419a05a47d4a506aa2768172f359106a421c630b0904400004dc2280b9c72db2285797c0a1ea23b44b0948bbb75719f1c6d8c6af69660ab1d7dde6b969bac5e1faff128050845b01044000044000044000044000044020d404b0b41aeae147e74100044000044000044000044000042014e11e0001100001100001100001100001100835010845a11e7e741e0440000440000440000440000440004211ee011000011000011000011000011000815013805014eae147e74100044000044000044000044000042014e11e0001100001100001100001100001100835010845a11e7e741e0440000440000440000440000440004211ee011000011000011000011000011000815013805014eae147e7417466b3ce000001174944415400044000044000044000044000042014e11e0001100001100001100001100001100835010845a11e7e741e0440000440000440000440000440004211ee011000011000011000011000011000815013805014eae147e74100044000044000044000044000042014e11e0001100001100001100001100001100835010845a11e7e741e0440000440000440000440000440004211ee011000011000011000011000011000815013805014eae147e74100044000044000044000044000042014e11e0001100001100001100001100001100835010845a11e7e741e0440000440000440000440000440004211ee0110000110000110000110000110000110000110000110000110000110000110000110082b81ff07413779af5e13a5610000000049454e44ae426082	\N	\N	\N	\N	20	2016-05-03 17:25:55	mostynrs	2016-07-19 12:19:02	mostynrs	3	1	20:IMAGES:LOGO_TOP_LEFT:
76	IMAGES	LOGO_GO	Company name logo	0	1		0	0	\N	\\x	00:00:00	2000-01-01	2000-01-01	\N	20	2015-04-24 10:51:39	x	2015-04-24 10:51:39	x	0	1	20:IMAGES:LOGO_GO:2000-01-01
123	URL	EXIT	web address to cancel/exit to	0	1	http://www.onlineapps.uk.com	0	0	2000-01-01	\\x	00:00:00	2000-01-01	2000-01-01	\N	20	2016-06-28 15:22:42	x	2016-06-28 15:40:15	stevensg	3	1	20:URL:EXIT:2000-01-01
121	IMAGES	LOGO_TOP_BANNER	image that spreads across top of form - e.g. myEcoCost wave	\N	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	20	2016-05-03 17:26:47	mostynrs	2016-05-03 17:26:47	mostynrs	0	1	20:IMAGES:LOGO_TOP_BANNER:
179	SERVER	TIMEOUT_SESS	Minutes until the task times out	0	1		4	0	\N	\\x	00:00:00	2000-01-01	2000-01-01	\N	20	2016-09-16 12:54:42	x	2016-09-16 12:54:42	x	0	1	20:SERVER:TIMEOUT_SESS:2000-01-01
157	FORMCOLOURS	ANAVLIST	application navigation list	\N	0	{\n"backcolor": "rgb(153,204,0)",\n"backalpha": "150",\n"textcolor":"kColorDefault"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "150", "backcolor": "rgb(153,204,0)", "textcolor": "kColorDefault"}	20	2016-06-07 11:34:20	mostynrs	2016-07-18 16:02:26	stevensg	5	1	20:FORMCOLOURS:ANAVLIST:
164	FORMCOLOURS	ANAVAREA	visual attributes for the application navigation area	\N	1	{\n"backcolor": "rgb(255,255,238)",\n"backalpha": "255"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "255", "backcolor": "rgb(255,255,238)"}	20	2016-07-18 15:45:48	stevensg	2016-07-18 15:52:35	stevensg	1	1	20:FORMCOLOURS:ANAVAREA:
154	FORMCOLOURS	RNAVAREA	record navigation area	\N	0	{\n"backcolor": "rgb(255,255,204)",\n"backalpha": 200\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": 200, "backcolor": "rgb(255,255,204)"}	20	2016-06-07 11:32:37	mostynrs	2016-07-18 16:04:04	stevensg	4	1	20:FORMCOLOURS:RNAVAREA:
159	FORMCOLOURS	RNAVLABELS	record navigation labels	\N	0	{\n"backcolor": "rgb(255,255,204)",\n"backalpha": "200",\n"textcolor":"kColorDefault"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "200", "backcolor": "rgb(255,255,204)", "textcolor": "kColorDefault"}	20	2016-06-07 11:35:21	mostynrs	2016-07-18 16:04:04	stevensg	3	1	20:FORMCOLOURS:RNAVLABELS:
158	FORMCOLOURS	RNAVLIST	record navigation list	\N	0	{\n"backcolor": "rgb(255,255,204)",\n"backalpha": "200"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "200", "backcolor": "rgb(255,255,204)"}	20	2016-06-07 11:34:42	mostynrs	2016-07-18 16:04:11	stevensg	4	1	20:FORMCOLOURS:RNAVLIST:
155	FORMCOLOURS	RNAVOBJECTS	record navigation objects	\N	0	{\n"backcolor": "rgb(255,255,204)",\n"backalpha": 200,\n"textcolor":"kColorDefault",\n"bordercolor":"kColorDefault",\n"color":"kRed"\n}	\N	\N	\N	\N	\N	\N	\N	{"color": "kRed", "backalpha": 200, "backcolor": "rgb(255,255,204)", "textcolor": "kColorDefault", "bordercolor": "kColorDefault"}	20	2016-06-07 11:32:54	mostynrs	2016-07-18 16:04:11	stevensg	3	1	20:FORMCOLOURS:RNAVOBJECTS:
160	FORMCOLOURS	WORKAREA	work area	\N	0	{\n"forecolor": "rgb(255,255,204)",\n"alpha": "150"\n}	\N	\N	\N	\N	\N	\N	\N	{"alpha": "150", "forecolor": "rgb(255,255,204)"}	20	2016-06-07 11:36:11	mostynrs	2016-07-18 16:04:18	stevensg	4	1	20:FORMCOLOURS:WORKAREA:
162	FORMCOLOURS	WORKHEADING	work area heading	\N	0	{\n"backcolor": "rgb(255,255,204)",\n"backalpha": "0",\n"textcolor":"rgb(51,153,204)"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "0", "backcolor": "rgb(255,255,204)", "textcolor": "rgb(51,153,204)"}	20	2016-06-07 11:36:59	mostynrs	2016-07-18 16:04:18	stevensg	5	1	20:FORMCOLOURS:WORKHEADING:
163	FORMCOLOURS	WORKMESSAGE	work area messages	\N	0	{\n"backcolor": "rgb(255,255,204)",\n"backalpha": "0",\n"textcolor":"rgb(51,153,204)"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "0", "backcolor": "rgb(255,255,204)", "textcolor": "rgb(51,153,204)"}	20	2016-06-07 11:37:15	mostynrs	2016-07-18 16:04:25	stevensg	5	1	20:FORMCOLOURS:WORKMESSAGE:
161	FORMCOLOURS	WORKOBJECTS	objects within work area	\N	1	{\n"backcolor": "rgb(255,255,204)",\n"backalpha": "150",\n"textcolor":"rgb(51,153,204)"\n}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "150", "backcolor": "rgb(255,255,204)", "textcolor": "rgb(51,153,204)"}	20	2016-06-07 11:36:27	mostynrs	2016-07-18 16:42:32	stevensg	5	1	20:FORMCOLOURS:WORKOBJECTS:
156	FORMCOLOURS	ANAVLABELS	application navigation labels	\N	0	{\r"backcolor": "rgb(153,204,0)",\r"backalpha": "0",\r"textcolor":"kBlue"\r}	\N	\N	\N	\N	\N	\N	\N	{"backalpha": "0", "backcolor": "rgb(153,204,0)", "textcolor": "kBlue"}	20	2016-06-07 11:33:38	mostynrs	2016-07-19 13:18:14	mostynrs	5	1	20:FORMCOLOURS:ANAVLABELS:
264	EM_SRVR_FROM	GENERIC_MSG	General email messages	\N	1	\N	\N	\N	\N	\N	\N	\N	\N	{"name": "Administration", "server": "mail.mydomain.org", "emailCC": [], "emailTO": [], "debuglog": "yes", "emailBCC": [], "loginName": "me@mydomain.org", "OW3options": {"verifyPeer": 0, "requireSecure": 1}, "secureValue": "STARTTLS", "loginPassword": "xxxxxxxxxxxx", "senderAddress": "info@mydomain.org", "authentication": "LOGIN", "verifyCertificate": "no"}	20	2018-11-02 14:15:10	stevensg	2018-12-11 15:50:13	console	1	0	20:EM_SRVR_FROM:GENERIC_MSG:
\.


--
-- Data for Name: sysreferenceuser; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysreferenceuser (rfu_seq, rfu_class, rfu_value, rfu_desc, rfu_order, rfu_active, rfu_char, rfu_int, rfu_number, rfu_date, rfu_bin, rfu_time, rfu_effective, rfu_expires, rfu_json, rfu_go_ref, rfu_usr_ref, rfu_cwhen, rfu_cby, rfu_mwhen, rfu_mby, rfu_mcount, rfu_unique) FROM stdin;
\.


--
-- Data for Name: syssemaphores; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.syssemaphores (smh_table_prfx, smh_pkey_i, smh_pkey_c, smh_owner, smh_cwhen) FROM stdin;
\.


--
-- Data for Name: systaskstats; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.systaskstats (sts_seq, sts_start, sts_count_start, sts_end, sts_count_end, sts_last_response, sts_go_ref, sts_bytes_reqcursent, sts_bytes_reqcurrecd, sts_bytes_reqmaxsent, sts_bytes_reqmaxrecd, sts_bytes_reqtotsent, sts_bytes_reqtotrecd, sts_tot_events, sts_ula_ref, sts_ip4, sts_type, sts_db_requests, sts_fetches, sts_inserts, sts_updates, sts_deletes, sts_device_size, sts_init_class, sts_gl_ref, sts_browser, sts_ws_name, sts_table_name, sts_table_method, sts_params, sts_table_list) FROM stdin;
\.


--
-- Data for Name: sysunitofmeasure; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysunitofmeasure (uom_seq, uom_cwhen, uom_cby, uom_mwhen, uom_mby, uom_mcount, uom_code, uom_desc_en, uom_group, uom_active) FROM stdin;
2	2014-03-21 15:42:40	mostynrs	2014-03-21 15:42:40	mostynrs	0	d	Day	TIME	1
4	2014-03-21 15:47:52	mostynrs	2014-03-21 15:47:52	mostynrs	0	m2	Square metre	AREA	1
6	2014-03-21 15:49:22	mostynrs	2014-03-21 15:49:22	mostynrs	0	kg	Kilogram	MASS	1
7	2014-03-21 15:49:53	mostynrs	2014-03-21 15:49:53	mostynrs	0	m	Metre	LENGTH	1
9	2014-03-21 15:51:03	mostynrs	2014-03-21 15:51:03	mostynrs	0	MJ	Megajoule	ENERGY	1
14	2014-03-21 15:56:12	mostynrs	2014-03-21 15:56:12	mostynrs	0	Item(s)	Number of items	ITEMS	1
5	2014-03-21 15:48:49	mostynrs	2014-03-21 15:48:49	mostynrs	0	kBq	Kilo-Bequerel, 1000 events per second	RADIOACTIVITY	1
11	2014-03-21 15:52:36	mostynrs	2014-03-21 15:52:36	mostynrs	0	m2*a	Square metre times year	AREA*TIME	1
12	2014-03-21 15:53:14	mostynrs	2014-03-21 15:53:14	mostynrs	0	m3	Cubic metre	VOLUME	1
13	2014-03-21 15:54:05	mostynrs	2014-03-21 15:54:05	mostynrs	0	m*a	Metre times year	LENGTH*TIME	1
15	2014-03-21 15:58:21	mostynrs	2014-03-21 15:58:21	mostynrs	0	p*km	Person kilometer	PERSON TRANSPOR	1
16	2014-03-21 15:59:04	mostynrs	2014-03-21 15:59:04	mostynrs	0	v*km	Vehicle kilometer	VEHICLE TRANSPO	1
17	2014-03-21 15:59:40	mostynrs	2014-03-21 15:59:40	mostynrs	0	t*km	Metric ton kilometer	MASS*DISTANCE	1
18	2014-03-21 16:02:57	mostynrs	2014-03-21 16:02:57	mostynrs	0	m3*a	Cubic meter times year	VOLUME*TIME	1
\.


--
-- Data for Name: sysunitsynonyms; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysunitsynonyms (uos_seq, uos_cwhen, uos_cby, uos_mwhen, uos_mby, uos_mcount, uos_uom_ref, uos_code, uos_factor, uos_filter, uos_active) FROM stdin;
1	2014-03-21 15:42:40	mostynrs	2014-03-21 15:42:40	mostynrs	0	2	d	1	\N	1
2	2014-03-21 15:47:52	mostynrs	2014-03-21 15:47:52	mostynrs	0	4	m2	1	\N	1
3	2014-03-21 15:48:49	mostynrs	2014-03-21 15:48:49	mostynrs	0	5	kBq	1	\N	1
4	2014-03-21 15:49:22	mostynrs	2014-03-21 15:49:22	mostynrs	0	6	kg	1	\N	1
5	2014-03-21 15:49:53	mostynrs	2014-03-21 15:49:53	mostynrs	0	7	m	1	\N	1
6	2014-03-21 15:51:03	mostynrs	2014-03-21 15:51:03	mostynrs	0	9	MJ	1	\N	1
7	2014-03-21 15:52:36	mostynrs	2014-03-21 15:52:36	mostynrs	0	11	m2*a	1	\N	1
8	2014-03-21 15:53:14	mostynrs	2014-03-21 15:53:14	mostynrs	0	12	m3	1	\N	1
9	2014-03-21 15:54:05	mostynrs	2014-03-21 15:54:05	mostynrs	0	13	m*a	1	\N	1
10	2014-03-21 15:56:12	mostynrs	2014-03-21 15:56:12	mostynrs	0	14	Item(s)	1	\N	1
11	2014-03-21 15:58:21	mostynrs	2014-03-21 15:58:21	mostynrs	0	15	p*km	1	\N	1
12	2014-03-21 15:59:04	mostynrs	2014-03-21 15:59:04	mostynrs	0	16	v*km	1	\N	1
13	2014-03-21 15:59:40	mostynrs	2014-03-21 15:59:40	mostynrs	0	17	t*km	1	\N	1
14	2014-03-21 16:02:57	mostynrs	2014-03-21 16:02:57	mostynrs	0	18	m3*a	1	\N	1
16	2014-03-21 15:47:10	mostynrs	2014-03-21 15:47:10	mostynrs	0	4	ha	10000	\N	1
17	2014-03-21 15:50:20	mostynrs	2014-03-21 15:50:20	mostynrs	0	7	km	1000	\N	1
19	2014-03-21 15:47:52	mostynrs	2014-03-21 15:47:52	mostynrs	0	4	S	1	\N	1
20	2014-03-21 15:52:36	mostynrs	2014-03-21 15:52:36	mostynrs	0	11	m2a	1	\N	1
21	2014-03-21 15:53:14	mostynrs	2014-03-21 15:53:14	mostynrs	0	12	Nm3	1	\N	1
22	2014-03-21 15:54:05	mostynrs	2014-03-21 15:54:05	mostynrs	0	13	ma	1	\N	1
23	2014-03-21 15:58:21	mostynrs	2014-03-21 15:58:21	mostynrs	0	15	pkm	1	\N	1
24	2014-03-21 15:59:04	mostynrs	2014-03-21 15:59:04	mostynrs	0	16	vkm	1	\N	1
25	2014-03-21 15:59:40	mostynrs	2014-03-21 15:59:40	mostynrs	0	17	tkm	1	\N	1
26	2014-03-21 16:02:57	mostynrs	2014-03-21 16:02:57	mostynrs	0	18	m3a	1	\N	1
27	2014-03-21 15:49:22	mostynrs	2014-03-21 15:49:22	mostynrs	0	6	Kg	1	\N	1
28	2014-03-21 15:49:22	mostynrs	2014-03-21 15:49:22	mostynrs	0	6	SWU	1	\N	1
29	2014-03-21 15:56:12	mostynrs	2014-03-21 15:56:12	mostynrs	0	14	Unit	1	\N	1
30	2014-03-21 15:56:12	mostynrs	2014-03-21 15:56:12	mostynrs	0	14	LU	1	\N	1
31	2014-03-21 15:56:12	mostynrs	2014-03-21 15:56:12	mostynrs	0	14	pig place	1	\N	1
15	2014-03-21 15:38:19	mostynrs	2014-03-21 15:38:19	mostynrs	0	2	h	0.0416666600000000012	\N	1
35	2014-06-13 10:58:24	mostynrs	2014-06-13 10:58:24	mostynrs	0	12	l	0.00100000000000000002	\N	1
18	2014-03-21 15:51:41	mostynrs	2014-03-21 15:51:41	mostynrs	0	9	kWh	3.60000000000000009	\N	1
\.


--
-- Data for Name: uagrouporglinks; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.uagrouporglinks (ugo_seq, ugo_go_ref, ugo_usr_ref, ugo_cwhen, ugo_cby) FROM stdin;
91	20	1	2014-12-15 16:58:00	mostynrs
\.


--
-- Data for Name: ualogaccess; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.ualogaccess (ula_seq, ula_usr_ref, ula_login, ula_logout, ula_forms_visited, ula_ip_address, ula_go_name, ula_connect_time, ula_bytes_connect, ula_bytes_total_sent, ula_bytes_total_recd, ula_bytes_max_sent, ula_bytes_max_recd, ula_requests, ula_comment, ula_last_hit, ula_dg_ref) FROM stdin;
\.


--
-- Data for Name: uapermissions; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.uapermissions (per_seq, per_label, per_desc_en, per_cwhen, per_cby, per_mwhen, per_mby, per_mcount, per_su) FROM stdin;
117	ur_allUsers	view all role users	2014-05-12 16:14:49	stevensg	2014-05-12 16:14:49	stevensg	0	0
39	ur_insert	assign roles to users	2000-01-01 21:23:25	unknown	2000-01-01 21:23:25	unknown	0	0
40	ur_delete	remove roles from users	2000-01-01 21:23:45	unknown	2000-01-01 21:23:45	unknown	0	0
41	rp_insert	assign permissions to roles	2000-01-01 21:24:02	unknown	2000-01-01 21:24:02	unknown	0	0
42	rp_delete	remove permissions from roles	2000-01-01 21:24:13	unknown	2000-01-01 21:24:13	unknown	0	0
50	go_update	modify group org records	2000-01-01 15:15:44	unknown	2000-01-01 15:15:44	unknown	0	0
51	go_delete	remove group organisations	2000-01-01 15:15:51	unknown	2000-01-01 15:15:51	unknown	0	0
52	go_select	view group organisations	2000-01-01 15:15:58	unknown	2000-01-01 15:15:58	unknown	0	0
53	go_insert	create group organisations	2000-01-01 15:16:31	unknown	2000-01-01 15:16:31	unknown	0	0
59	rfl_insert	create local lookup records	2014-03-03 15:34:50	stevensg	2014-03-03 15:34:50	stevensg	0	0
61	rfl_update	modify local lookup records	2014-03-03 15:35:19	stevensg	2014-03-03 15:35:19	stevensg	0	0
63	rfl_delete	remove local lookup records	2014-03-05 12:01:25	stevensg	2014-03-05 12:01:25	stevensg	0	0
64	eo_select	view external organisations	2014-03-05 16:41:38	stevensg	2014-03-05 16:41:38	stevensg	0	0
66	eo_update	modify external organisations	2014-03-05 16:41:49	stevensg	2014-03-05 16:41:49	stevensg	0	0
67	eo_delete	remove external organisations	2014-03-05 16:41:54	stevensg	2014-03-05 16:41:54	stevensg	0	0
68	prd_select	view product definitions	2014-03-07 12:02:32	stevensg	2014-03-07 12:02:32	stevensg	0	0
69	prd_update	modify product definitions	2014-03-07 12:02:47	stevensg	2014-03-07 12:02:47	stevensg	0	0
70	prd_delete	remove product definitions	2014-03-07 12:02:52	stevensg	2014-03-07 12:02:52	stevensg	0	0
71	prd_insert	create product definitions	2014-03-07 12:04:36	stevensg	2014-03-07 12:04:36	stevensg	0	0
76	eo_allOrgs	view all ext. organisations	2014-03-18 09:59:41	mostynrs	2014-03-18 09:59:41	mostynrs	0	0
78	prd_allOrgs	view all products	2014-03-18 12:09:07	mostynrs	2014-03-18 12:09:07	mostynrs	0	0
84	foh_select	view financial invoices	2014-03-20 13:09:43	stevensg	2014-03-20 13:09:43	stevensg	0	0
85	foh_update	modify financial invoices	2014-03-20 13:09:53	stevensg	2014-03-20 13:09:53	stevensg	0	0
86	foh_delete	remove financial invoices	2014-03-20 13:10:02	stevensg	2014-03-20 13:10:02	stevensg	0	0
87	foh_insert	create financial invoices	2014-03-20 13:10:29	stevensg	2014-03-20 13:10:29	stevensg	0	0
96	rfg_select	view global lookup values	2014-03-21 10:01:49	mostynrs	2014-03-21 10:01:49	mostynrs	0	0
97	rfg_delete	remove global lookup values	2014-03-21 10:09:50	mostynrs	2014-03-21 10:09:50	mostynrs	0	0
98	rfg_insert	create global lookup values	2014-03-21 10:11:24	mostynrs	2014-03-21 10:11:24	mostynrs	0	0
99	rfg_update	modify global lookup values	2014-03-21 10:12:12	mostynrs	2014-03-21 10:12:12	mostynrs	0	0
104	rfo_select	view organisation lookups	2014-03-23 17:17:55	mostynrs	2014-03-23 17:17:55	mostynrs	0	0
105	rfo_insert	create organisation lookups	2014-03-23 17:18:02	mostynrs	2014-03-23 17:18:02	mostynrs	0	0
106	rfo_update	modify organisation lookups	2014-03-23 17:18:07	mostynrs	2014-03-23 17:18:07	mostynrs	0	0
62	rfl_select	view local lookup records	2014-03-03 15:35:32	stevensg	2014-03-03 15:35:32	stevensg	0	0
65	eo_insert	create external organisations	2014-03-05 16:41:44	stevensg	2014-03-05 16:41:44	stevensg	0	0
56	ugo_insert	assign users to organisations	2014-02-18 12:55:25	stevensg	2014-02-18 12:55:25	stevensg	0	0
57	ugo_delete	remove organisation users	2014-02-18 12:55:31	stevensg	2014-02-18 12:55:31	stevensg	0	0
107	rfo_delete	remove organisation lookups	2014-03-23 17:18:13	mostynrs	2014-03-23 17:18:13	mostynrs	0	0
6	rol_insert	create new roles	2000-01-01 21:23:25	unknown	2000-01-01 21:23:25	unknown	0	0
5	rol_select	view roles	2000-01-01 21:23:25	unknown	2000-01-01 21:23:25	unknown	0	0
7	rol_update	modify roles	2000-01-01 21:23:25	unknown	2000-01-01 21:23:25	unknown	0	0
8	rol_delete	delete roles	2000-01-01 21:23:25	unknown	2000-01-01 21:23:25	unknown	0	0
9	per_select	view permissions	2000-01-01 21:23:25	unknown	2000-01-01 21:23:25	unknown	0	0
11	per_update	modify permissions	2000-01-01 21:23:25	unknown	2014-05-22 15:27:30	stevensg	0	0
12	per_delete	delete permissions	2000-01-01 21:23:25	unknown	2000-01-01 21:23:25	unknown	0	0
10	per_insert	create new permissions	2000-01-01 21:23:25	unknown	2000-01-01 21:23:25	unknown	0	0
171	rp_select	reports - can run	2014-12-18 14:00:18	mostynrs	2014-12-18 14:00:18	mostynrs	0	0
173	foh_idLink_add	invoice - delegate link - add	2015-01-12 13:41:49	mostynrs	2015-01-12 13:41:49	mostynrs	0	0
177	foh_print_inv	print invoice	2015-01-13 11:18:39	mostynrs	2015-01-13 11:18:39	mostynrs	0	0
175	foh_idLink_del	delegate/invoice link delete	2015-01-12 14:38:04	mostynrs	2015-01-15 10:25:28	mostynrs	0	0
202	report_select	can access reports	2017-05-05 13:21:56	mostynrs	2017-05-05 13:21:56	mostynrs	0	0
4	usr_delete	delete users	2000-01-01 21:23:25	unknown	2000-01-01 21:23:25	unknown	0	0
2	usr_insert	create new users	2000-01-01 21:23:25	unknown	2000-01-01 21:23:25	unknown	0	0
1	usr_select	view users	2000-01-01 21:23:25	unknown	2000-01-01 21:23:25	unknown	0	0
3	usr_update	modify user records	2000-01-01 21:23:25	unknown	2000-01-01 21:23:25	unknown	0	0
79	usr_allUsers	view all users	2014-03-19 01:47:58	mostynrs	2014-03-19 01:47:58	mostynrs	0	0
203	ugo_insert_r	User GroupOrg add (r)	2018-02-14 10:22:53	mostynrs	2018-02-14 10:24:04	mostynrs	1	1
204	ur_insert_r	User Role - add (r)	2018-02-14 10:16:52	mostynrs	2018-02-14 10:25:08	mostynrs	1	1
205	hw_view	can view "hello world"	2018-12-11 16:10:26	console	2018-12-11 16:10:26	console	0	0
\.


--
-- Data for Name: uarolepermissions; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.uarolepermissions (rp_seq, rp_rol_ref, rp_per_ref, rp_cwhen, rp_cby) FROM stdin;
1	1	1	\N	\N
857	20	205	2018-12-11 16:10:56	console
768	3	104	2014-12-15 11:58:30	mostynrs
13	3	1	\N	\N
25	2	1	\N	\N
795	24	173	2015-01-12 14:10:07	mostynrs
796	24	86	2015-01-12 14:10:21	mostynrs
798	24	175	2015-01-12 14:38:57	mostynrs
53	1	53	2000-01-01 15:17:17	\N
58	1	50	2000-01-01 12:09:47	mostynrs
59	1	51	2000-01-01 12:28:42	mostynrs
799	24	177	2015-01-13 11:19:05	mostynrs
70	3	62	2014-03-03 15:35:52	stevensg
71	3	61	2014-03-03 15:36:02	stevensg
72	3	59	2014-03-03 15:36:09	stevensg
75	6	52	2014-03-03 20:39:37	mostynrs
78	6	64	2014-03-05 16:42:35	stevensg
79	1	65	2014-03-05 16:42:40	stevensg
80	1	66	2014-03-05 16:42:47	stevensg
81	1	67	2014-03-05 16:42:53	stevensg
98	1	76	2014-03-18 10:00:06	mostynrs
99	3	76	2014-03-18 10:00:16	mostynrs
104	1	78	2014-03-18 12:09:16	mostynrs
107	7	69	2014-03-18 12:32:38	mostynrs
110	8	64	2014-03-18 12:51:19	mostynrs
111	8	65	2014-03-18 12:51:23	mostynrs
112	8	66	2014-03-18 12:51:26	mostynrs
113	8	67	2014-03-18 12:51:28	mostynrs
116	1	84	2014-03-20 13:10:54	stevensg
117	2	84	2014-03-20 13:11:05	stevensg
118	6	84	2014-03-20 13:11:15	stevensg
119	1	85	2014-03-20 13:11:22	stevensg
120	2	85	2014-03-20 13:11:25	stevensg
121	1	87	2014-03-20 13:11:32	stevensg
122	2	87	2014-03-20 13:11:34	stevensg
762	7	70	2014-12-15 11:55:00	mostynrs
763	7	71	2014-12-15 11:55:07	mostynrs
764	7	68	2014-12-15 11:55:13	mostynrs
157	3	105	2014-03-23 17:20:52	mostynrs
159	3	107	2014-03-23 17:21:10	mostynrs
161	3	106	2014-03-23 17:21:54	mostynrs
165	3	63	2014-03-23 17:24:04	mostynrs
197	1	117	2014-05-12 16:15:24	mostynrs
598	12	67	2014-05-30 15:52:59	mostynrs
599	12	65	2014-05-30 15:52:59	mostynrs
600	12	64	2014-05-30 15:52:59	mostynrs
601	12	66	2014-05-30 15:52:59	mostynrs
605	12	87	2014-05-30 15:54:38	demo_user
606	12	85	2014-05-30 15:54:48	demo_user
629	16	4	2014-06-13 14:03:38	mostynrs
630	16	2	2014-06-13 14:03:41	mostynrs
631	16	1	2014-06-13 14:03:44	mostynrs
632	16	3	2014-06-13 14:03:49	mostynrs
635	17	12	2014-06-13 14:05:28	mostynrs
636	17	10	2014-06-13 14:05:31	mostynrs
637	17	9	2014-06-13 14:05:34	mostynrs
638	17	11	2014-06-13 14:05:37	mostynrs
639	17	8	2014-06-13 14:05:52	mostynrs
640	17	6	2014-06-13 14:06:04	mostynrs
641	17	5	2014-06-13 14:06:25	mostynrs
642	17	7	2014-06-13 14:06:40	mostynrs
643	17	42	2014-06-13 14:07:35	mostynrs
644	17	41	2014-06-13 14:08:12	mostynrs
645	16	39	2014-06-13 14:09:01	mostynrs
646	16	40	2014-06-13 14:09:08	mostynrs
670	20	64	2014-06-13 14:33:40	mostynrs
672	20	84	2014-06-13 14:34:08	mostynrs
673	20	52	2014-06-13 14:34:20	mostynrs
679	21	76	2014-06-13 14:39:51	mostynrs
681	21	117	2014-06-13 14:40:52	mostynrs
682	21	79	2014-06-13 14:41:02	mostynrs
683	16	56	2014-06-13 14:48:01	mostynrs
684	16	57	2014-06-13 14:48:18	mostynrs
685	22	51	2014-06-13 14:50:57	mostynrs
686	22	53	2014-06-13 14:51:00	mostynrs
687	22	50	2014-06-13 14:51:08	mostynrs
695	24	87	2014-06-13 14:54:31	mostynrs
696	24	85	2014-06-13 14:54:38	mostynrs
714	25	87	2014-08-28 08:08:07	stevensg
715	21	84	2014-08-28 08:08:11	stevensg
716	25	85	2014-08-28 08:08:15	stevensg
729	25	65	2014-09-15 12:01:19	stevensg
809	33	107	2015-07-22 16:03:36	mostynrs
810	33	105	2015-07-22 16:03:45	mostynrs
811	33	106	2015-07-22 16:03:56	mostynrs
812	34	63	2015-07-22 16:04:21	mostynrs
813	34	59	2015-07-22 16:04:21	mostynrs
814	34	61	2015-07-22 16:04:35	mostynrs
815	35	97	2015-07-22 16:05:18	mostynrs
816	35	98	2015-07-22 16:05:18	mostynrs
817	35	99	2015-07-22 16:05:27	mostynrs
\.


--
-- Data for Name: uaroles; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.uaroles (rol_seq, rol_cwhen, rol_cby, rol_mwhen, rol_mby, rol_mcount, rol_name, rol_revoke, rol_rol_ref, rol_active, rol_su) FROM stdin;
1	\N	\N	\N	\N	1	console	\N	\N	1	0
2	\N	\N	\N	\N	1	admin	\N	\N	1	0
3	\N	\N	\N	\N	1	sys_admin	\N	\N	1	0
6	2014-03-03 20:38:45	mostynrs	2014-03-03 20:38:45	mostynrs	0	regular_user	\N	\N	1	0
7	2014-03-18 12:32:12	mostynrs	2014-03-18 12:32:12	mostynrs	0	product_admin	\N	\N	1	0
8	2014-03-18 12:51:00	mostynrs	2014-03-18 12:51:00	mostynrs	0	extorg_admin	\N	\N	1	0
12	2014-05-30 12:51:47	demo_user	2014-05-30 12:51:47	demo_user	0	demo_user	\N	\N	1	0
16	2014-06-13 14:03:20	mostynrs	2014-06-13 14:03:20	mostynrs	0	user_admin	\N	\N	1	0
17	2014-06-13 14:05:14	mostynrs	2014-06-13 14:05:14	mostynrs	0	role_perm_admin	\N	\N	1	0
20	2014-06-13 14:32:51	mostynrs	2014-06-13 14:32:51	mostynrs	0	business_view	\N	\N	1	0
21	2014-06-13 14:39:39	mostynrs	2014-06-13 14:39:39	mostynrs	0	super_user	\N	\N	1	0
22	2014-06-13 14:50:31	mostynrs	2014-06-13 14:50:31	mostynrs	0	company_setup	\N	\N	1	0
24	2014-06-13 14:54:13	mostynrs	2014-06-13 14:54:13	mostynrs	0	financial_admin	\N	\N	1	0
25	2014-08-28 08:04:09	stevensg	2014-08-28 08:04:09	stevensg	0	integration	\N	\N	1	0
33	2015-07-22 16:02:49	mostynrs	2015-07-22 16:02:49	mostynrs	0	config_org	\N	\N	1	0
34	2015-07-22 16:03:05	mostynrs	2015-07-22 16:03:05	mostynrs	0	config_local	\N	\N	1	0
35	2015-07-22 16:05:06	mostynrs	2015-07-22 16:05:06	mostynrs	0	config_global	\N	\N	1	0
\.


--
-- Data for Name: uauserroles; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.uauserroles (ur_seq, ur_usr_ref, ur_rol_ref, ur_active, ur_default, ur_cwhen, ur_cby) FROM stdin;
95	1	7	1	1	2014-06-13 14:38:27	mostynrs
96	1	8	1	1	2014-06-13 14:38:34	mostynrs
99	1	16	1	1	2014-06-13 14:39:04	mostynrs
100	1	17	1	1	2014-06-13 14:39:10	mostynrs
101	1	21	1	1	2014-06-13 14:41:36	mostynrs
102	1	22	1	1	2014-06-13 14:51:26	mostynrs
105	1	24	1	1	2014-06-13 14:54:48	mostynrs
110	1	20	1	1	2014-07-14 12:55:11	mostynrs
225	1	35	1	1	2015-07-22 16:05:37	mostynrs
229	1	34	1	1	2015-07-22 16:06:09	mostynrs
231	1	33	1	1	2015-07-22 16:06:34	mostynrs
260	1	3	\N	1	2018-12-11 16:07:24	console
\.


--
-- Data for Name: uausers; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.uausers (usr_seq, usr_cwhen, usr_cby, usr_mwhen, usr_mby, usr_mcount, usr_usr_ref, usr_name, usr_real_name, usr_salt, usr_hashpass, usr_extn, usr_mobile, usr_email, usr_pw_expires, usr_ac_expires, usr_initials, usr_job_title, usr_team, usr_startdate, usr_active, usr_su) FROM stdin;
1	\N	\N	2018-11-30 15:41:12	stevensg	1	\N	console	CONSOLE	***	d7c15107fba0445bfdb30af819179c17	\N	\N	\N	\N	\N	\N	\N	\N	\N	1	0
\.


--
-- Name: accountingperiod_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.accountingperiod_seq', 35, true);


--
-- Name: accountingperiodlinks_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.accountingperiodlinks_seq', 70, true);


--
-- Name: autosave_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.autosave_seq', 380, true);


--
-- Name: countries_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.countries_seq', 240, false);


--
-- Name: entextorganisations_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.entextorganisations_seq', 185, true);


--
-- Name: entgrouporganisations_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.entgrouporganisations_seq', 21, true);


--
-- Name: entgrouporgnames_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.entgrouporgnames_seq', 4, true);


--
-- Name: entgrouporgstructure_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.entgrouporgstructure_seq', 1, false);


--
-- Name: entorglinks_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.entorglinks_seq', 171, true);


--
-- Name: fininvoiceoutchain_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.fininvoiceoutchain_seq', 5, true);


--
-- Name: fininvoiceoutd_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.fininvoiceoutd_seq', 590, true);


--
-- Name: fininvoiceouth_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.fininvoiceouth_seq', 285, true);


--
-- Name: generictranslations_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.generictranslations_seq', 1, false);


--
-- Name: importtemplate_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.importtemplate_seq', 1, false);


--
-- Name: langcountry_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.langcountry_seq', 885, false);


--
-- Name: languages_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.languages_seq', 572, false);


--
-- Name: productclassifications_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.productclassifications_seq', 1, false);


--
-- Name: products_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.products_seq', 204, true);


--
-- Name: sysasyncemails_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysasyncemails_seq', 1879, true);


--
-- Name: sysfeedback_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysfeedback_seq', 40, true);


--
-- Name: sysreferenceglobal_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysreferenceglobal_seq', 577, true);


--
-- Name: sysreferencelocal_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysreferencelocal_seq', 127, true);


--
-- Name: sysreferenceorg_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysreferenceorg_seq', 266, true);


--
-- Name: sysreferenceuser_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysreferenceuser_seq', 1, true);


--
-- Name: systaskstats_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.systaskstats_seq', 11465, true);


--
-- Name: sysunitofmeasure_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysunitofmeasure_seq', 1, false);


--
-- Name: sysunitsynonyms_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysunitsynonyms_seq', 1, false);


--
-- Name: uagrouporglinks_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.uagrouporglinks_seq', 100, true);


--
-- Name: ualogaccess_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.ualogaccess_seq', 10286, true);


--
-- Name: uapermissions_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.uapermissions_seq', 205, true);


--
-- Name: uarolepermissions_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.uarolepermissions_seq', 857, true);


--
-- Name: uaroles_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.uaroles_seq', 36, true);


--
-- Name: uauserroles_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.uauserroles_seq', 260, true);


--
-- Name: uausers_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.uausers_seq', 61, true);


--
-- Name: accountingperiod accountingperiod_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.accountingperiod
    ADD CONSTRAINT accountingperiod_pkey PRIMARY KEY (acp_seq);


--
-- Name: accountingperiodlinks accountingperiodlinks_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.accountingperiodlinks
    ADD CONSTRAINT accountingperiodlinks_pkey PRIMARY KEY (acl_seq);


--
-- Name: accountingperiodlinks acl_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.accountingperiodlinks
    ADD CONSTRAINT acl_ukey UNIQUE (acl_acp_ref, acl_go_ref);


--
-- Name: accountingperiod acp_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.accountingperiod
    ADD CONSTRAINT acp_ukey UNIQUE (acp_span, acp_from);


--
-- Name: autosave autosave_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.autosave
    ADD CONSTRAINT autosave_pkey PRIMARY KEY (as_seq);


--
-- Name: countries co_iso22; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.countries
    ADD CONSTRAINT co_iso22 UNIQUE (co_iso2);


--
-- Name: countries co_iso32; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.countries
    ADD CONSTRAINT co_iso32 UNIQUE (co_iso3);


--
-- Name: countries co_seq2; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.countries
    ADD CONSTRAINT co_seq2 PRIMARY KEY (co_seq);


--
-- Name: entextorganisations entextorganisations_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entextorganisations
    ADD CONSTRAINT entextorganisations_pkey PRIMARY KEY (eo_seq);


--
-- Name: entgrouporganisations entgrouporganisations_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporganisations
    ADD CONSTRAINT entgrouporganisations_pkey PRIMARY KEY (go_seq);


--
-- Name: entgrouporgnames entgrouporgnames_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporgnames
    ADD CONSTRAINT entgrouporgnames_pkey PRIMARY KEY (gon_seq);


--
-- Name: entorglinks entorglinks_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entorglinks
    ADD CONSTRAINT entorglinks_pkey PRIMARY KEY (eol_seq);


--
-- Name: entorglinks eol_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entorglinks
    ADD CONSTRAINT eol_ukey UNIQUE (eol_go_ref, eol_eo_ref);


--
-- Name: fininvoiceoutchain fininvoiceoutchain_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.fininvoiceoutchain
    ADD CONSTRAINT fininvoiceoutchain_pkey PRIMARY KEY (foc_seq);


--
-- Name: fininvoiceoutd fininvoiceoutd_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.fininvoiceoutd
    ADD CONSTRAINT fininvoiceoutd_pkey PRIMARY KEY (fod_seq);


--
-- Name: fininvoiceouth fininvoiceouth_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.fininvoiceouth
    ADD CONSTRAINT fininvoiceouth_pkey PRIMARY KEY (foh_seq);


--
-- Name: generictranslations generictranslations_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.generictranslations
    ADD CONSTRAINT generictranslations_pkey PRIMARY KEY (gt_seq);


--
-- Name: entgrouporganisations go_mec_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporganisations
    ADD CONSTRAINT go_mec_ukey UNIQUE (go_mec_id);


--
-- Name: entgrouporganisations go_name_short_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporganisations
    ADD CONSTRAINT go_name_short_ukey UNIQUE (go_name_short);


--
-- Name: entgrouporgnames gon_name_full_uk; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporgnames
    ADD CONSTRAINT gon_name_full_uk UNIQUE (gon_name_full);


--
-- Name: entgrouporgnames gon_ukey2; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporgnames
    ADD CONSTRAINT gon_ukey2 UNIQUE (gon_type, gon_name_full);


--
-- Name: entgrouporgstructure gs_seq; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporgstructure
    ADD CONSTRAINT gs_seq PRIMARY KEY (gs_seq);


--
-- Name: importtemplate imt_seq; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.importtemplate
    ADD CONSTRAINT imt_seq PRIMARY KEY (imt_seq);


--
-- Name: langcountry lc_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.langcountry
    ADD CONSTRAINT lc_pkey PRIMARY KEY (lc_seq);


--
-- Name: languages lg_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.languages
    ADD CONSTRAINT lg_pkey PRIMARY KEY (lg_seq);


--
-- Name: productclassifications pcl_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.productclassifications
    ADD CONSTRAINT pcl_ukey UNIQUE (pcl_prd_ref, pcl_type, pcl_code);


--
-- Name: uapermissions per_seq; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uapermissions
    ADD CONSTRAINT per_seq PRIMARY KEY (per_seq);


--
-- Name: uapermissions per_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uapermissions
    ADD CONSTRAINT per_ukey UNIQUE (per_label);


--
-- Name: productclassifications productclassifications_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.productclassifications
    ADD CONSTRAINT productclassifications_pkey PRIMARY KEY (pcl_seq);


--
-- Name: productinternaldata productinternaldata_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.productinternaldata
    ADD CONSTRAINT productinternaldata_pkey PRIMARY KEY (pid_prd_ref);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (prd_seq);


--
-- Name: sysreferenceglobal rfg_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceglobal
    ADD CONSTRAINT rfg_ukey UNIQUE (rfg_unique);


--
-- Name: sysreferencelocal rfl_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferencelocal
    ADD CONSTRAINT rfl_ukey UNIQUE (rfl_unique);


--
-- Name: sysreferenceorg rfo_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceorg
    ADD CONSTRAINT rfo_ukey UNIQUE (rfo_unique);


--
-- Name: sysreferenceuser rfu_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceuser
    ADD CONSTRAINT rfu_ukey UNIQUE (rfu_unique);


--
-- Name: uaroles rol_seq; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uaroles
    ADD CONSTRAINT rol_seq PRIMARY KEY (rol_seq);


--
-- Name: uaroles rol_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uaroles
    ADD CONSTRAINT rol_ukey UNIQUE (rol_name);


--
-- Name: uarolepermissions rp_seq; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uarolepermissions
    ADD CONSTRAINT rp_seq PRIMARY KEY (rp_seq);


--
-- Name: uarolepermissions rp_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uarolepermissions
    ADD CONSTRAINT rp_ukey UNIQUE (rp_rol_ref, rp_per_ref);


--
-- Name: uarolepermissions rp_unique; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uarolepermissions
    ADD CONSTRAINT rp_unique UNIQUE (rp_rol_ref, rp_per_ref);


--
-- Name: syssemaphores smh_unique; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.syssemaphores
    ADD CONSTRAINT smh_unique UNIQUE (smh_table_prfx, smh_pkey_i, smh_pkey_c);


--
-- Name: sysasyncemails sysasyncemails_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysasyncemails
    ADD CONSTRAINT sysasyncemails_pkey PRIMARY KEY (ae_seq);


--
-- Name: sysfeedback sysfeedback_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysfeedback
    ADD CONSTRAINT sysfeedback_pkey PRIMARY KEY (sf_seq);


--
-- Name: sysreferenceglobal sysreferenceglobal_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceglobal
    ADD CONSTRAINT sysreferenceglobal_pkey PRIMARY KEY (rfg_seq);


--
-- Name: sysreferencelocal sysreferencelocal_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferencelocal
    ADD CONSTRAINT sysreferencelocal_pkey PRIMARY KEY (rfl_seq);


--
-- Name: sysreferenceorg sysreferenceorg_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceorg
    ADD CONSTRAINT sysreferenceorg_pkey PRIMARY KEY (rfo_seq);


--
-- Name: sysreferenceuser sysreferenceuser_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceuser
    ADD CONSTRAINT sysreferenceuser_pkey PRIMARY KEY (rfu_seq);


--
-- Name: systaskstats systaskstats_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.systaskstats
    ADD CONSTRAINT systaskstats_pkey PRIMARY KEY (sts_seq);


--
-- Name: sysunitofmeasure sysunitofmeasure_uom_code_key; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysunitofmeasure
    ADD CONSTRAINT sysunitofmeasure_uom_code_key UNIQUE (uom_code);


--
-- Name: sysunitofmeasure sysunitofmeasure_uom_group_key; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysunitofmeasure
    ADD CONSTRAINT sysunitofmeasure_uom_group_key UNIQUE (uom_group);


--
-- Name: sysunitsynonyms sysunitsynonyms_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysunitsynonyms
    ADD CONSTRAINT sysunitsynonyms_pkey PRIMARY KEY (uos_seq);


--
-- Name: sysunitsynonyms sysunitsynonyms_uos_code_key; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysunitsynonyms
    ADD CONSTRAINT sysunitsynonyms_uos_code_key UNIQUE (uos_code);


--
-- Name: uagrouporglinks uagrouporglinks_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uagrouporglinks
    ADD CONSTRAINT uagrouporglinks_pkey PRIMARY KEY (ugo_seq);


--
-- Name: uagrouporglinks ugo_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uagrouporglinks
    ADD CONSTRAINT ugo_ukey UNIQUE (ugo_go_ref, ugo_usr_ref);


--
-- Name: ualogaccess ula_seq; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.ualogaccess
    ADD CONSTRAINT ula_seq PRIMARY KEY (ula_seq);


--
-- Name: sysunitofmeasure uom_seq; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysunitofmeasure
    ADD CONSTRAINT uom_seq PRIMARY KEY (uom_seq);


--
-- Name: uauserroles ur_seq; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uauserroles
    ADD CONSTRAINT ur_seq PRIMARY KEY (ur_seq);


--
-- Name: uauserroles ur_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uauserroles
    ADD CONSTRAINT ur_ukey UNIQUE (ur_usr_ref, ur_rol_ref);


--
-- Name: uauserroles ur_unique; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uauserroles
    ADD CONSTRAINT ur_unique UNIQUE (ur_usr_ref, ur_rol_ref);


--
-- Name: uausers usr_seq; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uausers
    ADD CONSTRAINT usr_seq PRIMARY KEY (usr_seq);


--
-- Name: fki_lc_co; Type: INDEX; Schema: infra; Owner: _developer
--

CREATE INDEX fki_lc_co ON infra.langcountry USING btree (lc_co_ref_iso3);


--
-- Name: fki_lc_co_ref; Type: INDEX; Schema: infra; Owner: _developer
--

CREATE INDEX fki_lc_co_ref ON infra.langcountry USING btree (lc_co_ref);


--
-- Name: fki_lc_lg; Type: INDEX; Schema: infra; Owner: _developer
--

CREATE INDEX fki_lc_lg ON infra.langcountry USING btree (lc_lg_ref);


--
-- Name: gs_desc_unique; Type: INDEX; Schema: infra; Owner: _developer
--

CREATE UNIQUE INDEX gs_desc_unique ON infra.entgrouporgstructure USING btree (gs_go_ref, gs_desc_short);


--
-- Name: gs_order_unique; Type: INDEX; Schema: infra; Owner: _developer
--

CREATE UNIQUE INDEX gs_order_unique ON infra.entgrouporgstructure USING btree (gs_go_ref, infra.null_to_zero(gs_superior_gs_ref), gs_order);


--
-- Name: gs_superior_gs_ref; Type: INDEX; Schema: infra; Owner: _developer
--

CREATE INDEX gs_superior_gs_ref ON infra.entgrouporgstructure USING btree (gs_superior_gs_ref);


--
-- Name: imt_ukey; Type: INDEX; Schema: infra; Owner: _developer
--

CREATE UNIQUE INDEX imt_ukey ON infra.importtemplate USING btree (imt_go_ref, imt_name, imt_schema, imt_col_count);


--
-- Name: lg_iso2; Type: INDEX; Schema: infra; Owner: _developer
--

CREATE INDEX lg_iso2 ON infra.languages USING btree (lg_iso2);


--
-- Name: lg_iso3; Type: INDEX; Schema: infra; Owner: _developer
--

CREATE INDEX lg_iso3 ON infra.languages USING btree (lg_iso3);


--
-- Name: prd_ukey1; Type: INDEX; Schema: infra; Owner: _developer
--

CREATE UNIQUE INDEX prd_ukey1 ON infra.products USING btree (prd_eo_ref, prd_supp_prodcode);


--
-- Name: prd_ukey2; Type: INDEX; Schema: infra; Owner: _developer
--

CREATE UNIQUE INDEX prd_ukey2 ON infra.products USING btree (prd_go_ref, prd_int_prodcode);


--
-- Name: prd_ukey3; Type: INDEX; Schema: infra; Owner: _developer
--

CREATE UNIQUE INDEX prd_ukey3 ON infra.products USING btree (prd_go_ref, prd_brand, prd_name, prd_desc);


--
-- Name: sysreferenceglobal rfg_ins_upd; Type: TRIGGER; Schema: infra; Owner: _developer
--

CREATE TRIGGER rfg_ins_upd BEFORE INSERT OR UPDATE ON infra.sysreferenceglobal FOR EACH ROW EXECUTE PROCEDURE infra.rfg_before_ins_upd();


--
-- Name: sysreferencelocal rfl_ins_upd; Type: TRIGGER; Schema: infra; Owner: _developer
--

CREATE TRIGGER rfl_ins_upd BEFORE INSERT OR UPDATE ON infra.sysreferencelocal FOR EACH ROW EXECUTE PROCEDURE infra.rfl_before_ins_upd();


--
-- Name: sysreferenceorg rfo_ins_upd; Type: TRIGGER; Schema: infra; Owner: _developer
--

CREATE TRIGGER rfo_ins_upd BEFORE INSERT OR UPDATE ON infra.sysreferenceorg FOR EACH ROW EXECUTE PROCEDURE infra.rfo_before_ins_upd();


--
-- Name: sysreferenceuser rfu_ins_upd; Type: TRIGGER; Schema: infra; Owner: _developer
--

CREATE TRIGGER rfu_ins_upd BEFORE INSERT OR UPDATE ON infra.sysreferenceuser FOR EACH ROW EXECUTE PROCEDURE infra.rfu_before_ins_upd();


--
-- Name: accountingperiodlinks acl_acp_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.accountingperiodlinks
    ADD CONSTRAINT acl_acp_ref FOREIGN KEY (acl_acp_ref) REFERENCES infra.accountingperiod(acp_seq);


--
-- Name: accountingperiodlinks acl_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.accountingperiodlinks
    ADD CONSTRAINT acl_go_ref FOREIGN KEY (acl_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: sysasyncemails ae_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysasyncemails
    ADD CONSTRAINT ae_go_ref FOREIGN KEY (ae_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: entextorganisations eo_co_iso3_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entextorganisations
    ADD CONSTRAINT eo_co_iso3_ref FOREIGN KEY (eo_co_iso3_ref) REFERENCES infra.countries(co_iso3);


--
-- Name: entorglinks eol_eo_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entorglinks
    ADD CONSTRAINT eol_eo_ref FOREIGN KEY (eol_eo_ref) REFERENCES infra.entextorganisations(eo_seq);


--
-- Name: entorglinks eol_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entorglinks
    ADD CONSTRAINT eol_go_ref FOREIGN KEY (eol_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: langcountry fk_lc_lg; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.langcountry
    ADD CONSTRAINT fk_lc_lg FOREIGN KEY (lc_lg_ref) REFERENCES infra.languages(lg_seq);


--
-- Name: fininvoiceoutd fod_foh_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.fininvoiceoutd
    ADD CONSTRAINT fod_foh_ref FOREIGN KEY (fod_foh_ref) REFERENCES infra.fininvoiceouth(foh_seq);


--
-- Name: fininvoiceoutd fod_prd_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.fininvoiceoutd
    ADD CONSTRAINT fod_prd_ref FOREIGN KEY (fod_prd_ref) REFERENCES infra.products(prd_seq);


--
-- Name: fininvoiceouth foh_eo_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.fininvoiceouth
    ADD CONSTRAINT foh_eo_ref FOREIGN KEY (foh_eo_ref) REFERENCES infra.entextorganisations(eo_seq);


--
-- Name: fininvoiceouth foh_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.fininvoiceouth
    ADD CONSTRAINT foh_go_ref FOREIGN KEY (foh_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: entgrouporganisations go_report_to_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporganisations
    ADD CONSTRAINT go_report_to_go_ref FOREIGN KEY (go_report_to_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: entgrouporgnames gon_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporgnames
    ADD CONSTRAINT gon_go_ref FOREIGN KEY (gon_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: entgrouporgstructure gs_go_ref_fkey; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporgstructure
    ADD CONSTRAINT gs_go_ref_fkey FOREIGN KEY (gs_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: entgrouporgstructure gs_superior_gs_ref_fkey; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporgstructure
    ADD CONSTRAINT gs_superior_gs_ref_fkey FOREIGN KEY (gs_superior_gs_ref) REFERENCES infra.entgrouporgstructure(gs_seq);


--
-- Name: importtemplate imt_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.importtemplate
    ADD CONSTRAINT imt_go_ref FOREIGN KEY (imt_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: importtemplate imt_usr_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.importtemplate
    ADD CONSTRAINT imt_usr_ref FOREIGN KEY (imt_usr_ref) REFERENCES infra.uausers(usr_seq);


--
-- Name: langcountry lc_co_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.langcountry
    ADD CONSTRAINT lc_co_ref FOREIGN KEY (lc_co_ref) REFERENCES infra.countries(co_seq);


--
-- Name: productclassifications pcl_prd_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.productclassifications
    ADD CONSTRAINT pcl_prd_ref FOREIGN KEY (pcl_prd_ref) REFERENCES infra.products(prd_seq);


--
-- Name: productinternaldata pid_prd_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.productinternaldata
    ADD CONSTRAINT pid_prd_ref FOREIGN KEY (pid_prd_ref) REFERENCES infra.products(prd_seq) ON DELETE CASCADE;


--
-- Name: products prd_ecocost_uos_code; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.products
    ADD CONSTRAINT prd_ecocost_uos_code FOREIGN KEY (prd_ecocost_uos_code) REFERENCES infra.sysunitsynonyms(uos_code);


--
-- Name: products prd_eo_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.products
    ADD CONSTRAINT prd_eo_ref FOREIGN KEY (prd_eo_ref) REFERENCES infra.entextorganisations(eo_seq);


--
-- Name: products prd_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.products
    ADD CONSTRAINT prd_go_ref FOREIGN KEY (prd_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: products prd_micro_prd_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.products
    ADD CONSTRAINT prd_micro_prd_ref FOREIGN KEY (prd_micro_prd_ref) REFERENCES infra.products(prd_seq);


--
-- Name: products prd_uos_code; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.products
    ADD CONSTRAINT prd_uos_code FOREIGN KEY (prd_uos_code) REFERENCES infra.sysunitsynonyms(uos_code);


--
-- Name: sysreferenceorg rfo_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceorg
    ADD CONSTRAINT rfo_go_ref FOREIGN KEY (rfo_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: sysreferenceuser rfu_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceuser
    ADD CONSTRAINT rfu_go_ref FOREIGN KEY (rfu_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: sysreferenceuser rfu_usr_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceuser
    ADD CONSTRAINT rfu_usr_ref FOREIGN KEY (rfu_usr_ref) REFERENCES infra.uausers(usr_seq);


--
-- Name: uaroles rol_rol_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uaroles
    ADD CONSTRAINT rol_rol_ref FOREIGN KEY (rol_rol_ref) REFERENCES infra.uaroles(rol_seq);


--
-- Name: uarolepermissions rp_per_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uarolepermissions
    ADD CONSTRAINT rp_per_ref FOREIGN KEY (rp_per_ref) REFERENCES infra.uapermissions(per_seq);


--
-- Name: uarolepermissions rp_rol_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uarolepermissions
    ADD CONSTRAINT rp_rol_ref FOREIGN KEY (rp_rol_ref) REFERENCES infra.uaroles(rol_seq);


--
-- Name: systaskstats sts_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.systaskstats
    ADD CONSTRAINT sts_go_ref FOREIGN KEY (sts_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: systaskstats sts_ula_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.systaskstats
    ADD CONSTRAINT sts_ula_ref FOREIGN KEY (sts_ula_ref) REFERENCES infra.ualogaccess(ula_seq);


--
-- Name: uagrouporglinks ugo_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uagrouporglinks
    ADD CONSTRAINT ugo_go_ref FOREIGN KEY (ugo_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: uagrouporglinks ugo_usr_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uagrouporglinks
    ADD CONSTRAINT ugo_usr_ref FOREIGN KEY (ugo_usr_ref) REFERENCES infra.uausers(usr_seq);


--
-- Name: ualogaccess ula_usr_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.ualogaccess
    ADD CONSTRAINT ula_usr_ref FOREIGN KEY (ula_usr_ref) REFERENCES infra.uausers(usr_seq);


--
-- Name: sysunitsynonyms uos_uom_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysunitsynonyms
    ADD CONSTRAINT uos_uom_ref FOREIGN KEY (uos_uom_ref) REFERENCES infra.sysunitofmeasure(uom_seq);


--
-- Name: uauserroles ur_rol_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uauserroles
    ADD CONSTRAINT ur_rol_ref FOREIGN KEY (ur_rol_ref) REFERENCES infra.uaroles(rol_seq);


--
-- Name: uauserroles ur_usr_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uauserroles
    ADD CONSTRAINT ur_usr_ref FOREIGN KEY (ur_usr_ref) REFERENCES infra.uausers(usr_seq);


--
-- Name: uausers usr_usr_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uausers
    ADD CONSTRAINT usr_usr_ref FOREIGN KEY (usr_usr_ref) REFERENCES infra.uausers(usr_seq);


--
-- Name: SCHEMA infra; Type: ACL; Schema: -; Owner: _developer
--

GRANT USAGE ON SCHEMA infra TO regular;


--
-- Name: SEQUENCE sysreferenceorg_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysreferenceorg_seq TO regular;


--
-- Name: TABLE sysreferenceorg; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.sysreferenceorg TO regular;


--
-- Name: FUNCTION initinherited(pclass text, pvalue text, pgoref integer); Type: ACL; Schema: infra; Owner: _developer
--

REVOKE ALL ON FUNCTION infra.initinherited(pclass text, pvalue text, pgoref integer) FROM PUBLIC;
GRANT ALL ON FUNCTION infra.initinherited(pclass text, pvalue text, pgoref integer) TO regular;


--
-- Name: FUNCTION nextseqno(pclass character, pcommit boolean); Type: ACL; Schema: infra; Owner: _developer
--

REVOKE ALL ON FUNCTION infra.nextseqno(pclass character, pcommit boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION infra.nextseqno(pclass character, pcommit boolean) TO regular;


--
-- Name: FUNCTION report_year(pclass text, pdate date, pgoref integer); Type: ACL; Schema: infra; Owner: _developer
--

REVOKE ALL ON FUNCTION infra.report_year(pclass text, pdate date, pgoref integer) FROM PUBLIC;
GRANT ALL ON FUNCTION infra.report_year(pclass text, pdate date, pgoref integer) TO regular;


--
-- Name: FUNCTION checkproductsource(pprodcode text, pstartchar smallint, pstringlength smallint, plabel text); Type: ACL; Schema: public; Owner: _developer
--

REVOKE ALL ON FUNCTION public.checkproductsource(pprodcode text, pstartchar smallint, pstringlength smallint, plabel text) FROM PUBLIC;
GRANT ALL ON FUNCTION public.checkproductsource(pprodcode text, pstartchar smallint, pstringlength smallint, plabel text) TO regular;


--
-- Name: FUNCTION checkproductsource(pprodcode text, ptokenno smallint, pdelimiter text, plabel text); Type: ACL; Schema: public; Owner: _developer
--

REVOKE ALL ON FUNCTION public.checkproductsource(pprodcode text, ptokenno smallint, pdelimiter text, plabel text) FROM PUBLIC;
GRANT ALL ON FUNCTION public.checkproductsource(pprodcode text, ptokenno smallint, pdelimiter text, plabel text) TO regular;


--
-- Name: FUNCTION clone_processmodel(INOUT pnprmref bigint, pcuser character); Type: ACL; Schema: public; Owner: _developer
--

REVOKE ALL ON FUNCTION public.clone_processmodel(INOUT pnprmref bigint, pcuser character) FROM PUBLIC;
GRANT ALL ON FUNCTION public.clone_processmodel(INOUT pnprmref bigint, pcuser character) TO regular;


--
-- Name: FUNCTION fix_sequences(); Type: ACL; Schema: public; Owner: _developer
--

REVOKE ALL ON FUNCTION public.fix_sequences() FROM PUBLIC;


--
-- Name: FUNCTION floor_time(ptimestamp timestamp without time zone, pminutes integer); Type: ACL; Schema: public; Owner: _developer
--

REVOKE ALL ON FUNCTION public.floor_time(ptimestamp timestamp without time zone, pminutes integer) FROM PUBLIC;
GRANT ALL ON FUNCTION public.floor_time(ptimestamp timestamp without time zone, pminutes integer) TO regular;


--
-- Name: FUNCTION nextseqno(pclass character, pcommit boolean); Type: ACL; Schema: public; Owner: _developer
--

REVOKE ALL ON FUNCTION public.nextseqno(pclass character, pcommit boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION public.nextseqno(pclass character, pcommit boolean) TO regular;


--
-- Name: SEQUENCE accountingperiod_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.accountingperiod_seq TO regular;


--
-- Name: TABLE accountingperiod; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.accountingperiod TO regular;


--
-- Name: SEQUENCE accountingperiodlinks_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.accountingperiodlinks_seq TO regular;


--
-- Name: TABLE accountingperiodlinks; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.accountingperiodlinks TO regular;


--
-- Name: SEQUENCE autosave_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.autosave_seq TO regular;


--
-- Name: TABLE autosave; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.autosave TO regular;


--
-- Name: SEQUENCE countries_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.countries_seq TO regular;


--
-- Name: TABLE countries; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.countries TO regular;


--
-- Name: SEQUENCE entextorganisations_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.entextorganisations_seq TO regular;


--
-- Name: TABLE entextorganisations; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.entextorganisations TO regular;


--
-- Name: SEQUENCE entgrouporganisations_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.entgrouporganisations_seq TO regular;


--
-- Name: TABLE entgrouporganisations; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.entgrouporganisations TO regular;


--
-- Name: SEQUENCE entgrouporgnames_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.entgrouporgnames_seq TO regular;


--
-- Name: TABLE entgrouporgnames; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.entgrouporgnames TO regular;


--
-- Name: SEQUENCE entgrouporgstructure_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.entgrouporgstructure_seq TO regular;


--
-- Name: TABLE entgrouporgstructure; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.entgrouporgstructure TO regular;


--
-- Name: SEQUENCE entorglinks_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.entorglinks_seq TO regular;


--
-- Name: TABLE entorglinks; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.entorglinks TO regular;


--
-- Name: SEQUENCE fininvoiceoutchain_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.fininvoiceoutchain_seq TO regular;


--
-- Name: TABLE fininvoiceoutchain; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.fininvoiceoutchain TO regular;


--
-- Name: SEQUENCE fininvoiceoutd_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.fininvoiceoutd_seq TO regular;


--
-- Name: TABLE fininvoiceoutd; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.fininvoiceoutd TO regular;


--
-- Name: SEQUENCE fininvoiceouth_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.fininvoiceouth_seq TO regular;


--
-- Name: TABLE fininvoiceouth; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.fininvoiceouth TO regular;


--
-- Name: SEQUENCE generictranslations_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.generictranslations_seq TO regular;


--
-- Name: TABLE generictranslations; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.generictranslations TO regular;


--
-- Name: SEQUENCE importtemplate_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.importtemplate_seq TO regular;


--
-- Name: TABLE importtemplate; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,UPDATE ON TABLE infra.importtemplate TO regular;


--
-- Name: SEQUENCE langcountry_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.langcountry_seq TO regular;


--
-- Name: TABLE langcountry; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.langcountry TO regular;


--
-- Name: SEQUENCE languages_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.languages_seq TO regular;


--
-- Name: TABLE languages; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.languages TO regular;


--
-- Name: SEQUENCE productclassifications_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.productclassifications_seq TO regular;


--
-- Name: TABLE productclassifications; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.productclassifications TO regular;


--
-- Name: TABLE productinternaldata; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.productinternaldata TO regular;


--
-- Name: SEQUENCE products_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.products_seq TO regular;


--
-- Name: TABLE products; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.products TO regular;


--
-- Name: SEQUENCE sysasyncemails_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysasyncemails_seq TO regular;


--
-- Name: TABLE sysasyncemails; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.sysasyncemails TO regular;


--
-- Name: SEQUENCE sysfeedback_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysfeedback_seq TO regular;


--
-- Name: TABLE sysfeedback; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.sysfeedback TO regular;


--
-- Name: TABLE syslogerrors; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.syslogerrors TO regular;


--
-- Name: TABLE syslogevents; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.syslogevents TO regular;


--
-- Name: SEQUENCE sysreferenceglobal_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysreferenceglobal_seq TO regular;


--
-- Name: TABLE sysreferenceglobal; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.sysreferenceglobal TO regular;


--
-- Name: SEQUENCE sysreferencelocal_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysreferencelocal_seq TO regular;


--
-- Name: TABLE sysreferencelocal; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.sysreferencelocal TO regular;


--
-- Name: SEQUENCE sysreferenceuser_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysreferenceuser_seq TO regular;


--
-- Name: TABLE sysreferenceuser; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.sysreferenceuser TO regular;


--
-- Name: TABLE syssemaphores; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE ON TABLE infra.syssemaphores TO regular;


--
-- Name: SEQUENCE systaskstats_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.systaskstats_seq TO regular;


--
-- Name: TABLE systaskstats; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,UPDATE ON TABLE infra.systaskstats TO regular;


--
-- Name: SEQUENCE sysunitofmeasure_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysunitofmeasure_seq TO regular;


--
-- Name: TABLE sysunitofmeasure; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,UPDATE ON TABLE infra.sysunitofmeasure TO regular;


--
-- Name: SEQUENCE sysunitsynonyms_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysunitsynonyms_seq TO regular;


--
-- Name: TABLE sysunitsynonyms; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.sysunitsynonyms TO regular;


--
-- Name: SEQUENCE uagrouporglinks_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.uagrouporglinks_seq TO regular;


--
-- Name: TABLE uagrouporglinks; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.uagrouporglinks TO regular;


--
-- Name: SEQUENCE ualogaccess_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.ualogaccess_seq TO regular;


--
-- Name: TABLE ualogaccess; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.ualogaccess TO regular;


--
-- Name: SEQUENCE uapermissions_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.uapermissions_seq TO regular;


--
-- Name: TABLE uapermissions; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT ON TABLE infra.uapermissions TO PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.uapermissions TO regular;


--
-- Name: SEQUENCE uarolepermissions_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.uarolepermissions_seq TO regular;


--
-- Name: TABLE uarolepermissions; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.uarolepermissions TO regular;


--
-- Name: SEQUENCE uaroles_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.uaroles_seq TO regular;


--
-- Name: TABLE uaroles; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.uaroles TO regular;


--
-- Name: SEQUENCE uauserroles_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.uauserroles_seq TO regular;


--
-- Name: TABLE uauserroles; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.uauserroles TO regular;


--
-- Name: SEQUENCE uausers_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.uausers_seq TO regular;


--
-- Name: TABLE uausers; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.uausers TO regular;


--
-- Name: TABLE vi_timezones; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT ON TABLE infra.vi_timezones TO regular;


--
-- Name: TABLE websessions; Type: ACL; Schema: public; Owner: _developer
--

GRANT SELECT,UPDATE ON TABLE public.websessions TO regular;


CREATE DATABASE stb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE stb OWNER TO _developer;

\connect stb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: infra; Type: SCHEMA; Schema: -; Owner: _developer
--

CREATE SCHEMA infra;


ALTER SCHEMA infra OWNER TO _developer;

--
-- Name: translate; Type: SCHEMA; Schema: -; Owner: _developer
--

CREATE SCHEMA translate;


ALTER SCHEMA translate OWNER TO _developer;

--
-- Name: sysreferenceorg_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysreferenceorg_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysreferenceorg_seq OWNER TO _developer;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: sysreferenceorg; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysreferenceorg (
    rfo_seq bigint DEFAULT nextval('infra.sysreferenceorg_seq'::regclass) NOT NULL,
    rfo_class character varying(15) NOT NULL,
    rfo_value character varying(15) NOT NULL,
    rfo_desc character varying(100) NOT NULL,
    rfo_order smallint,
    rfo_active smallint,
    rfo_char text,
    rfo_int bigint,
    rfo_number double precision,
    rfo_date date,
    rfo_bin bytea,
    rfo_time time without time zone,
    rfo_effective date,
    rfo_expires date,
    rfo_json jsonb,
    rfo_go_ref bigint NOT NULL,
    rfo_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfo_cby character varying(15) NOT NULL,
    rfo_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfo_mby character varying(15) NOT NULL,
    rfo_mcount integer DEFAULT 0 NOT NULL,
    rfo_inherit smallint DEFAULT 0 NOT NULL
);


ALTER TABLE infra.sysreferenceorg OWNER TO _developer;

--
-- Name: COLUMN sysreferenceorg.rfo_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_seq IS 'primary key';


--
-- Name: COLUMN sysreferenceorg.rfo_class; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_class IS 'classification column';


--
-- Name: COLUMN sysreferenceorg.rfo_value; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_value IS 'specific reference value';


--
-- Name: COLUMN sysreferenceorg.rfo_desc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_desc IS 'description';


--
-- Name: COLUMN sysreferenceorg.rfo_order; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_order IS 'ordering column';


--
-- Name: COLUMN sysreferenceorg.rfo_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_active IS '1 means an active lookup/reference entry';


--
-- Name: COLUMN sysreferenceorg.rfo_char; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_char IS 'big character column';


--
-- Name: COLUMN sysreferenceorg.rfo_int; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_int IS 'integer value';


--
-- Name: COLUMN sysreferenceorg.rfo_number; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_number IS 'floating number value';


--
-- Name: COLUMN sysreferenceorg.rfo_date; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_date IS 'date column';


--
-- Name: COLUMN sysreferenceorg.rfo_bin; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceorg.rfo_bin IS 'binary value';


--
-- Name: initinherited(text, text, integer); Type: FUNCTION; Schema: infra; Owner: _developer
--

CREATE FUNCTION infra.initinherited(pclass text, pvalue text DEFAULT ''::text, pgoref integer DEFAULT 0) RETURNS SETOF infra.sysreferenceorg
    LANGUAGE plpgsql
    AS $_$
/*******************************************************************************************
Purpose:    to offer the functionality of Omnis oValues.$initInherited returning one row
Created:    2016-08-31 Graham Stevens
Revisions:  2017-06-08 GRS reworked to return a full set of records for pClass when pValue is empty
            2018-01-29 GRS bug fix: added rfo_active to the order by clause 
                                    added check for pValue is null
            2018-02-08 GRS added to include/exclude records according to rfo/rfl_inherit
            2018-08-16 GRS reverted the rfo_inherit change above
			2018-08-17 GRS properly (I hpoe) incorporated xxx_inherit
			2018-08-20 GRS fixed: rows were missing when rfo_active = 1 but rfg_active = 0 
*******************************************************************************************/
declare
    rfoRow  infra.sysreferenceorg%rowtype;
    
begin
    if pClass is null or pClass = '' then
        raise invalid_parameter_value using message = 'Class must have a value';
    end if;
    
    
    if pValue = '' or pValue is null then
    	for rfoRow in
			-- select all relevant columns from the result set
			-- for the first row only in each partition
			-- ignoring inactive records
			select rfo_seq, rfo_class, rfo_value, rfo_desc, rfo_order, rfo_active, rfo_char, rfo_int, rfo_number, rfo_date, rfo_bin, rfo_time, rfo_effective, rfo_expires, rfo_json
			from
			(
			-- partition the results by class and value ordering each partition by its _active value desc and priority
			-- and numbering each row
			select *, row_number()
			over (partition by rfo_class, rfo_value order by rfo_active, priority)
			from
			(
			-- fetch all matching rows from all tables incl. ACTIVE = 0
			-- priority is used to order the rows in the outer windowing clause
			with rfo as ( -- get all the relevant refOrg records
			select 1 as priority, rfo_seq, rfo_class, rfo_value, rfo_desc, rfo_order, rfo_active, rfo_char, rfo_int, rfo_number, rfo_date, rfo_bin, rfo_time, rfo_effective, rfo_expires, rfo_json
			from infra.sysreferenceorg rfo
			where rfo_class = pClass
			and rfo_go_ref = pgoref 
			and not (rfo_active= 0 and rfo_inherit = 1) -- inherit overrides the deactivation as though the record did not exist
			), 
			rfl as ( -- get the relevant refLocal records and override rfl_active if rfo_active = 1
			select 2, rfl_seq, rfl_class, rfl_value, rfl_desc, rfl_order
			, case when rfo_active = 1 then rfo_active else rfl_active end, rfl_char, rfl_int, rfl_number, rfl_date, rfl_bin, rfl_time, rfl_effective, rfl_expires, rfl_json
			from infra.sysreferencelocal
			left join rfo on rfo_value = rfl_value
			where rfl_class = pClass
			and not (rfl_active= 0 and rfl_inherit = 1) -- inherit overrides the deactivation as though the record did not exist
			), 
			rfg as ( --get the relevant refGlobal records and override rfg_active if rfo_active = 1 or rfl_active = 1
			select 3 as priority, rfg_seq, rfg_class, rfg_value, rfg_desc, rfg_order
			, case when rfo_active = 1 then rfo_active when rfl_active = 1 then rfl_active else rfg_active end, rfg_char, rfg_int, rfg_number, rfg_date, rfg_bin, rfg_time, rfg_effective, rfg_expires, rfg_json
			from infra.sysreferenceglobal
			left join rfl on rfl_value = rfg_value
			left join rfo on rfo_value = rfg_value
			where rfg_class = pClass
			)
			-- put all of the above together
			select * from rfo union select * from rfl union select * from rfg
			) x 
			) y
			where row_number = 1 and rfo_active = 1
		
		loop
			return next rfoRow;
		end loop;
		
	else
		for rfoRow in
			-- select all relevant columns from the result set
			-- for the first row only in each partition
			-- ignoring inactive records
            select rfo_seq, rfo_class, rfo_value, rfo_desc, rfo_order, rfo_active, rfo_char, rfo_int, rfo_number, rfo_date, rfo_bin, rfo_time, rfo_effective, rfo_expires, rfo_json
			from
			(
			-- partition the results by class and value ordering each partition by its priority
			-- priority is used to order the rows in the outer windowing clause
			select *, row_number()
			over (partition by rfo_class, rfo_value order by rfo_active, priority)
			from
			(
			-- fetch all matching rows from all tables incl. ACTIVE = 0
			-- priority is used to order the rows in the outer windowing clause
			with rfo as ( -- get all the relevant refOrg records
			select 1 as priority, rfo_seq, rfo_class, rfo_value, rfo_desc, rfo_order, rfo_active, rfo_char, rfo_int, rfo_number, rfo_date, rfo_bin, rfo_time, rfo_effective, rfo_expires, rfo_json
			from infra.sysreferenceorg rfo
			where rfo_class = pClass and rfo_value = pValue
			and rfo_go_ref = pgoref 
			and not (rfo_active= 0 and rfo_inherit = 1) -- inherit overrides the deactivation as though the record did not exist
			), 
			rfl as ( -- get the relevant refLocal records and override rfl_active if rfo_active = 1
			select 2, rfl_seq, rfl_class, rfl_value, rfl_desc, rfl_order
			, case when rfo_active = 1 then rfo_active else rfl_active end, rfl_char, rfl_int, rfl_number, rfl_date, rfl_bin, rfl_time, rfl_effective, rfl_expires, rfl_json
			from infra.sysreferencelocal
			left join rfo on rfo_value = rfl_value
			where rfl_class = pClass and rfl_value = pValue
			and not (rfl_active= 0 and rfl_inherit = 1) -- inherit overrides the deactivation as though the record did not exist
			), 
			rfg as ( --get the relevant refGlobal records and override rfg_active if rfo_active = 1 or rfl_active = 1
			select 3 as priority, rfg_seq, rfg_class, rfg_value, rfg_desc, rfg_order
			, case when rfo_active = 1 then rfo_active when rfl_active = 1 then rfl_active else rfg_active end, rfg_char, rfg_int, rfg_number, rfg_date, rfg_bin, rfg_time, rfg_effective, rfg_expires, rfg_json
			from infra.sysreferenceglobal
			left join rfl on rfl_value = rfg_value
			left join rfo on rfo_value = rfg_value
			where rfg_class = pClass and rfg_value = pValue
			)
			-- put all of the above together
			select * from rfo union select * from rfl union select * from rfg
			) x
			) y
			where row_number = 1 and rfo_active = 1

		loop
			return next rfoRow;
		end loop;
		
	end if;	
	
    return;
    
end;
$_$;


ALTER FUNCTION infra.initinherited(pclass text, pvalue text, pgoref integer) OWNER TO _developer;

--
-- Name: entgrouporganisations_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.entgrouporganisations_seq
    START WITH 21
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.entgrouporganisations_seq OWNER TO _developer;

--
-- Name: entgrouporganisations; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.entgrouporganisations (
    go_seq bigint DEFAULT nextval('infra.entgrouporganisations_seq'::regclass) NOT NULL,
    go_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    go_cby character varying(15) NOT NULL,
    go_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    go_mby character varying(15) NOT NULL,
    go_mcount integer DEFAULT 0 NOT NULL,
    go_name_full character varying(255),
    go_name_short character varying(10) NOT NULL,
    go_addr_building character varying(100),
    go_addr_street character varying(100),
    go_addr_locality character varying(100),
    go_addr_town character varying(100),
    go_addr_state character varying(50),
    go_addr_postcode character varying(20),
    go_addr_country character varying(50),
    go_comm_ph character varying(20),
    go_comm_mob character varying(20),
    go_comm_email character varying(100),
    go_company_no character varying(20),
    go_vat_no character varying(15),
    go_currency character varying(3),
    go_mec_id character varying(20),
    go_mec_type smallint,
    go_rrs character varying(255),
    go_ddn_ap1 character varying(255),
    go_ddn_ap2 character varying(255),
    go_surname character varying(30),
    go_firstnames character varying(60),
    go_name_ltbc character varying(15),
    go_dob date,
    go_sex character varying(1),
    go_mmn character varying(15),
    go_id_type character varying(15),
    go_id_code character varying(20),
    go_mc_listid character varying(16),
    go_report_to_go_ref integer,
    go_report_to_percent numeric(5,4) DEFAULT 0,
    CONSTRAINT go_report_to_percent_check CHECK (((go_report_to_percent >= (0)::numeric) AND (go_report_to_percent <= (1)::numeric)))
);


ALTER TABLE infra.entgrouporganisations OWNER TO _developer;

--
-- Name: COLUMN entgrouporganisations.go_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporganisations.go_seq IS 'primary key';


--
-- Name: COLUMN entgrouporganisations.go_mc_listid; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporganisations.go_mc_listid IS 'MailChimp default list id';


--
-- Name: entgrouporgnames_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.entgrouporgnames_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.entgrouporgnames_seq OWNER TO _developer;

--
-- Name: entgrouporgnames; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.entgrouporgnames (
    gon_seq bigint DEFAULT nextval('infra.entgrouporgnames_seq'::regclass) NOT NULL,
    gon_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    gon_cby character varying(15) NOT NULL,
    gon_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    gon_mby character varying(15) NOT NULL,
    gon_mcount integer DEFAULT 0 NOT NULL,
    gon_go_ref bigint NOT NULL,
    gon_name_full character varying(255) NOT NULL,
    gon_type character varying(1),
    CONSTRAINT gon_type_chk CHECK (((gon_type IS NULL) OR ((gon_type)::text = 'I'::text) OR ((gon_type)::text = 'E'::text)))
);


ALTER TABLE infra.entgrouporgnames OWNER TO _developer;

--
-- Name: COLUMN entgrouporgnames.gon_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_seq IS 'primary key';


--
-- Name: COLUMN entgrouporgnames.gon_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_cwhen IS 'creation timestamp';


--
-- Name: COLUMN entgrouporgnames.gon_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_cby IS 'created by';


--
-- Name: COLUMN entgrouporgnames.gon_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_mwhen IS 'modification timestamp';


--
-- Name: COLUMN entgrouporgnames.gon_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_mby IS 'modified by';


--
-- Name: COLUMN entgrouporgnames.gon_mcount; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_mcount IS 'modification count';


--
-- Name: COLUMN entgrouporgnames.gon_go_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_go_ref IS 'foreign key to entgrouporganisations';


--
-- Name: COLUMN entgrouporgnames.gon_name_full; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_name_full IS 'organisation name in referenced language';


--
-- Name: COLUMN entgrouporgnames.gon_type; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.entgrouporgnames.gon_type IS 'I = internal use, E = default for export, null';


--
-- Name: sysasyncemails_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysasyncemails_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysasyncemails_seq OWNER TO _developer;

--
-- Name: sysasyncemails; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysasyncemails (
    ae_seq bigint DEFAULT nextval('infra.sysasyncemails_seq'::regclass) NOT NULL,
    ae_to jsonb,
    ae_subject character varying(255),
    ae_message text,
    ae_cc jsonb,
    ae_bcc jsonb,
    ae_priority smallint,
    ae_encl jsonb,
    ae_html text,
    ae_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    ae_go_ref integer,
    ae_fail_count smallint,
    ae_fail_dialogue text,
    ae_fail_status integer,
    ae_from jsonb,
    ae_extraheaders jsonb,
    ae_sendercode character varying(15)
);


ALTER TABLE infra.sysasyncemails OWNER TO _developer;

--
-- Name: COLUMN sysasyncemails.ae_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_seq IS 'primary key';


--
-- Name: COLUMN sysasyncemails.ae_to; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_to IS 'list of email addressees';


--
-- Name: COLUMN sysasyncemails.ae_subject; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_subject IS 'subject line of email';


--
-- Name: COLUMN sysasyncemails.ae_message; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_message IS 'email content';


--
-- Name: COLUMN sysasyncemails.ae_cc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_cc IS 'list of email addressees';


--
-- Name: COLUMN sysasyncemails.ae_bcc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_bcc IS 'list of email addressees';


--
-- Name: COLUMN sysasyncemails.ae_priority; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_priority IS 'priority - 0 to 3';


--
-- Name: COLUMN sysasyncemails.ae_encl; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_encl IS 'attachments';


--
-- Name: COLUMN sysasyncemails.ae_html; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_html IS 'HTML version of email message';


--
-- Name: COLUMN sysasyncemails.ae_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysasyncemails.ae_cwhen IS 'creation timestamp';


--
-- Name: syslogerrors; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.syslogerrors (
    sle_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    sle_code character varying(15),
    sle_subcode character varying(15),
    sle_message character varying(1000),
    sle_vhost_ref integer,
    sle_server_ip character varying(45),
    sle_server_port integer
);


ALTER TABLE infra.syslogerrors OWNER TO _developer;

--
-- Name: COLUMN syslogerrors.sle_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogerrors.sle_cwhen IS 'creation timestamp';


--
-- Name: COLUMN syslogerrors.sle_code; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogerrors.sle_code IS 'primary grouping category';


--
-- Name: COLUMN syslogerrors.sle_subcode; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogerrors.sle_subcode IS 'secondary grouping category';


--
-- Name: COLUMN syslogerrors.sle_message; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogerrors.sle_message IS 'message';


--
-- Name: syslogevents; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.syslogevents (
    slv_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    slv_code character varying(15),
    slv_subcode character varying(15),
    slv_message character varying(1000),
    slv_vhost_ref integer,
    slv_server_ip character varying(45),
    slv_server_port integer
);


ALTER TABLE infra.syslogevents OWNER TO _developer;

--
-- Name: COLUMN syslogevents.slv_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogevents.slv_cwhen IS 'creation timestamp';


--
-- Name: COLUMN syslogevents.slv_code; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogevents.slv_code IS 'primary grouping category';


--
-- Name: COLUMN syslogevents.slv_subcode; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogevents.slv_subcode IS 'secondary grouping category';


--
-- Name: COLUMN syslogevents.slv_message; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.syslogevents.slv_message IS 'message';


--
-- Name: sysreferenceglobal_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysreferenceglobal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysreferenceglobal_seq OWNER TO _developer;

--
-- Name: sysreferenceglobal; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysreferenceglobal (
    rfg_seq bigint DEFAULT nextval('infra.sysreferenceglobal_seq'::regclass) NOT NULL,
    rfg_class character varying(15) NOT NULL,
    rfg_value character varying(15) NOT NULL,
    rfg_desc character varying(100) NOT NULL,
    rfg_order smallint,
    rfg_active smallint,
    rfg_char text,
    rfg_int bigint,
    rfg_number double precision,
    rfg_date date,
    rfg_bin bytea,
    rfg_time time without time zone,
    rfg_effective date,
    rfg_expires date,
    rfg_json jsonb,
    rfg_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfg_cby character varying(15) NOT NULL,
    rfg_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfg_mby character varying(15) NOT NULL,
    rfg_mcount integer DEFAULT 0 NOT NULL
);


ALTER TABLE infra.sysreferenceglobal OWNER TO _developer;

--
-- Name: COLUMN sysreferenceglobal.rfg_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_seq IS 'primary key';


--
-- Name: COLUMN sysreferenceglobal.rfg_class; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_class IS 'classification column';


--
-- Name: COLUMN sysreferenceglobal.rfg_value; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_value IS 'specific reference value';


--
-- Name: COLUMN sysreferenceglobal.rfg_desc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_desc IS 'description';


--
-- Name: COLUMN sysreferenceglobal.rfg_order; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_order IS 'ordering column';


--
-- Name: COLUMN sysreferenceglobal.rfg_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_active IS '1 means an active lookup/reference entry';


--
-- Name: COLUMN sysreferenceglobal.rfg_char; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_char IS 'big character column';


--
-- Name: COLUMN sysreferenceglobal.rfg_int; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_int IS 'integer value';


--
-- Name: COLUMN sysreferenceglobal.rfg_number; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_number IS 'floating number value';


--
-- Name: COLUMN sysreferenceglobal.rfg_date; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_date IS 'date column';


--
-- Name: COLUMN sysreferenceglobal.rfg_bin; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceglobal.rfg_bin IS 'binary value';


--
-- Name: sysreferencelocal_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysreferencelocal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysreferencelocal_seq OWNER TO _developer;

--
-- Name: sysreferencelocal; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysreferencelocal (
    rfl_seq bigint DEFAULT nextval('infra.sysreferencelocal_seq'::regclass) NOT NULL,
    rfl_class character varying(15) NOT NULL,
    rfl_value character varying(15) NOT NULL,
    rfl_desc character varying(100) NOT NULL,
    rfl_order smallint,
    rfl_active smallint,
    rfl_char text,
    rfl_int bigint,
    rfl_number double precision,
    rfl_date date,
    rfl_bin bytea,
    rfl_time time without time zone,
    rfl_effective date,
    rfl_expires date,
    rfl_json jsonb,
    rfl_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfl_cby character varying(15) NOT NULL,
    rfl_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfl_mby character varying(15) NOT NULL,
    rfl_mcount integer DEFAULT 0 NOT NULL,
    rfl_inherit smallint DEFAULT 0 NOT NULL
);


ALTER TABLE infra.sysreferencelocal OWNER TO _developer;

--
-- Name: COLUMN sysreferencelocal.rfl_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_seq IS 'primary key';


--
-- Name: COLUMN sysreferencelocal.rfl_class; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_class IS 'classification column';


--
-- Name: COLUMN sysreferencelocal.rfl_value; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_value IS 'specific reference value';


--
-- Name: COLUMN sysreferencelocal.rfl_desc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_desc IS 'description';


--
-- Name: COLUMN sysreferencelocal.rfl_order; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_order IS 'ordering column';


--
-- Name: COLUMN sysreferencelocal.rfl_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_active IS '1 means an active lookup/reference entry';


--
-- Name: COLUMN sysreferencelocal.rfl_char; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_char IS 'big character column';


--
-- Name: COLUMN sysreferencelocal.rfl_int; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_int IS 'integer value';


--
-- Name: COLUMN sysreferencelocal.rfl_number; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_number IS 'floating number value';


--
-- Name: COLUMN sysreferencelocal.rfl_date; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_date IS 'date column';


--
-- Name: COLUMN sysreferencelocal.rfl_bin; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferencelocal.rfl_bin IS 'binary value';


--
-- Name: sysreferenceuser_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.sysreferenceuser_seq
    START WITH 45
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.sysreferenceuser_seq OWNER TO _developer;

--
-- Name: sysreferenceuser; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.sysreferenceuser (
    rfu_seq bigint DEFAULT nextval('infra.sysreferenceuser_seq'::regclass) NOT NULL,
    rfu_class character varying(15) NOT NULL,
    rfu_value character varying(15) NOT NULL,
    rfu_desc character varying(100) NOT NULL,
    rfu_order smallint,
    rfu_active smallint,
    rfu_char character varying(1000),
    rfu_int bigint,
    rfu_number double precision,
    rfu_date date,
    rfu_bin bytea,
    rfu_time time without time zone,
    rfu_effective date,
    rfu_expires date,
    rfu_json jsonb,
    rfu_go_ref bigint NOT NULL,
    rfu_usr_ref bigint NOT NULL,
    rfu_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfu_cby character varying(15) NOT NULL,
    rfu_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    rfu_mby character varying(15) NOT NULL,
    rfu_mcount integer DEFAULT 0 NOT NULL
);


ALTER TABLE infra.sysreferenceuser OWNER TO _developer;

--
-- Name: COLUMN sysreferenceuser.rfu_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_seq IS 'primary key';


--
-- Name: COLUMN sysreferenceuser.rfu_class; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_class IS 'classification column';


--
-- Name: COLUMN sysreferenceuser.rfu_value; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_value IS 'specific reference value';


--
-- Name: COLUMN sysreferenceuser.rfu_desc; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_desc IS 'description';


--
-- Name: COLUMN sysreferenceuser.rfu_order; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_order IS 'ordering column';


--
-- Name: COLUMN sysreferenceuser.rfu_active; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_active IS '1 means an active lookup/reference entry';


--
-- Name: COLUMN sysreferenceuser.rfu_char; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_char IS 'big character column';


--
-- Name: COLUMN sysreferenceuser.rfu_int; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_int IS 'integer value';


--
-- Name: COLUMN sysreferenceuser.rfu_number; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_number IS 'floating number value';


--
-- Name: COLUMN sysreferenceuser.rfu_date; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_date IS 'date column';


--
-- Name: COLUMN sysreferenceuser.rfu_bin; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.sysreferenceuser.rfu_bin IS 'binary value';


--
-- Name: systaskstats_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.systaskstats_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.systaskstats_seq OWNER TO _developer;

--
-- Name: systaskstats; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.systaskstats (
    sts_seq bigint DEFAULT nextval('infra.systaskstats_seq'::regclass) NOT NULL,
    sts_start timestamp without time zone,
    sts_count_start smallint,
    sts_end timestamp without time zone,
    sts_count_end smallint,
    sts_last_response timestamp without time zone,
    sts_go_ref integer,
    sts_bytes_reqcursent bigint,
    sts_bytes_reqcurrecd bigint,
    sts_bytes_reqmaxsent bigint,
    sts_bytes_reqmaxrecd bigint,
    sts_bytes_reqtotsent bigint,
    sts_bytes_reqtotrecd bigint,
    sts_tot_events integer,
    sts_ula_ref integer,
    sts_ip4 character varying(16),
    sts_type character varying(1) DEFAULT 'R'::character varying NOT NULL,
    sts_db_requests integer DEFAULT 0,
    sts_fetches integer DEFAULT 0,
    sts_inserts integer DEFAULT 0,
    sts_updates integer DEFAULT 0,
    sts_deletes integer DEFAULT 0,
    sts_device_size character varying(255),
    sts_init_class character varying(100),
    sts_gl_ref bigint,
    sts_browser text,
    sts_ws_name character varying(255),
    sts_table_name character varying(50),
    sts_table_method character varying(50),
    sts_params text,
    sts_table_list text,
    CONSTRAINT sts_type_chk CHECK ((((sts_type)::text = 'F'::text) OR ((sts_type)::text = 'R'::text) OR ((sts_type)::text = 'U'::text) OR ((sts_type)::text = 'J'::text) OR ((sts_type)::text = 'S'::text) OR ((sts_type)::text = '?'::text)))
);


ALTER TABLE infra.systaskstats OWNER TO _developer;

--
-- Name: COLUMN systaskstats.sts_type; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_type IS '(S)tartup Task, (R)emoteTask';


--
-- Name: COLUMN systaskstats.sts_db_requests; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_db_requests IS 'total number of DB calls';


--
-- Name: COLUMN systaskstats.sts_fetches; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_fetches IS 'total number of rows fetched from the DB';


--
-- Name: COLUMN systaskstats.sts_inserts; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_inserts IS 'total number of rows inserted into the DB';


--
-- Name: COLUMN systaskstats.sts_updates; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_updates IS 'total number of rows updated in the DB';


--
-- Name: COLUMN systaskstats.sts_deletes; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_deletes IS 'total number of rows deleted from the DB';


--
-- Name: COLUMN systaskstats.sts_ws_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_ws_name IS 'web service name';


--
-- Name: COLUMN systaskstats.sts_table_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_table_name IS 'table class name';


--
-- Name: COLUMN systaskstats.sts_table_method; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_table_method IS 'table class method';


--
-- Name: COLUMN systaskstats.sts_params; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_params IS 'parameters pass to table class method in JSON format';


--
-- Name: COLUMN systaskstats.sts_table_list; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.systaskstats.sts_table_list IS 'tables accessed during REST and SOAP service calls';


--
-- Name: uagrouporglinks_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.uagrouporglinks_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.uagrouporglinks_seq OWNER TO _developer;

--
-- Name: uagrouporglinks; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.uagrouporglinks (
    ugo_seq bigint DEFAULT nextval('infra.uagrouporglinks_seq'::regclass) NOT NULL,
    ugo_go_ref bigint NOT NULL,
    ugo_usr_ref bigint NOT NULL,
    ugo_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL,
    ugo_cby character varying(15) NOT NULL
);


ALTER TABLE infra.uagrouporglinks OWNER TO _developer;

--
-- Name: COLUMN uagrouporglinks.ugo_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uagrouporglinks.ugo_seq IS 'primary key';


--
-- Name: COLUMN uagrouporglinks.ugo_go_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uagrouporglinks.ugo_go_ref IS 'foreign key to entGroupOrganisations';


--
-- Name: COLUMN uagrouporglinks.ugo_usr_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uagrouporglinks.ugo_usr_ref IS 'foreign key to uaUsers';


--
-- Name: COLUMN uagrouporglinks.ugo_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uagrouporglinks.ugo_cwhen IS 'creation date';


--
-- Name: COLUMN uagrouporglinks.ugo_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uagrouporglinks.ugo_cby IS 'created by';


--
-- Name: ualogaccess_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.ualogaccess_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.ualogaccess_seq OWNER TO _developer;

--
-- Name: ualogaccess; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.ualogaccess (
    ula_seq bigint DEFAULT nextval('infra.ualogaccess_seq'::regclass) NOT NULL,
    ula_usr_ref bigint,
    ula_login timestamp without time zone,
    ula_logout timestamp without time zone,
    ula_forms_visited character varying(255),
    ula_ip_address character varying(50),
    ula_go_name character varying(10),
    ula_connect_time timestamp without time zone,
    ula_bytes_connect bigint,
    ula_bytes_total_sent bigint,
    ula_bytes_total_recd bigint,
    ula_bytes_max_sent bigint,
    ula_bytes_max_recd bigint,
    ula_requests bigint,
    ula_comment character varying(1000),
    ula_last_hit timestamp without time zone,
    ula_dg_ref bigint
);


ALTER TABLE infra.ualogaccess OWNER TO _developer;

--
-- Name: COLUMN ualogaccess.ula_go_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.ualogaccess.ula_go_name IS 'group organisation short name';


--
-- Name: COLUMN ualogaccess.ula_dg_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.ualogaccess.ula_dg_ref IS 'foreign key to delegates (for specific applications only)';


--
-- Name: uausers_seq; Type: SEQUENCE; Schema: infra; Owner: _developer
--

CREATE SEQUENCE infra.uausers_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE infra.uausers_seq OWNER TO _developer;

--
-- Name: uausers; Type: TABLE; Schema: infra; Owner: _developer
--

CREATE TABLE infra.uausers (
    usr_seq bigint DEFAULT nextval('infra.uausers_seq'::regclass) NOT NULL,
    usr_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usr_cby character varying(15),
    usr_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) with time zone,
    usr_mby character varying(15),
    usr_mcount integer,
    usr_usr_ref bigint,
    usr_name character varying(15),
    usr_real_name character varying(30),
    usr_salt character varying(40),
    usr_hashpass character varying(100),
    usr_extn character varying(15),
    usr_mobile character varying(20),
    usr_email character varying(100),
    usr_pw_expires date,
    usr_ac_expires date,
    usr_initials character varying(5),
    usr_job_title character varying(50),
    usr_team character varying(15),
    usr_startdate date,
    usr_active smallint DEFAULT 1 NOT NULL,
    CONSTRAINT usr_usr_ref_chk CHECK ((usr_usr_ref <> usr_seq))
);


ALTER TABLE infra.uausers OWNER TO _developer;

--
-- Name: COLUMN uausers.usr_seq; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_seq IS 'primary key';


--
-- Name: COLUMN uausers.usr_cwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_cwhen IS 'created timestamp';


--
-- Name: COLUMN uausers.usr_cby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_cby IS 'created by';


--
-- Name: COLUMN uausers.usr_mwhen; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_mwhen IS 'last modified';


--
-- Name: COLUMN uausers.usr_mby; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_mby IS 'modified by';


--
-- Name: COLUMN uausers.usr_mcount; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_mcount IS 'update count';


--
-- Name: COLUMN uausers.usr_usr_ref; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_usr_ref IS 'manager key';


--
-- Name: COLUMN uausers.usr_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_name IS 'user login name';


--
-- Name: COLUMN uausers.usr_real_name; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_real_name IS 'user full name';


--
-- Name: COLUMN uausers.usr_salt; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_salt IS 'hash salt for password';


--
-- Name: COLUMN uausers.usr_hashpass; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_hashpass IS 'user password hashed';


--
-- Name: COLUMN uausers.usr_extn; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_extn IS 'phone extension';


--
-- Name: COLUMN uausers.usr_mobile; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_mobile IS 'mobile number';


--
-- Name: COLUMN uausers.usr_email; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_email IS 'email address';


--
-- Name: COLUMN uausers.usr_pw_expires; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_pw_expires IS 'password expiry date';


--
-- Name: COLUMN uausers.usr_ac_expires; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_ac_expires IS 'account expiry date';


--
-- Name: COLUMN uausers.usr_initials; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_initials IS 'user initials';


--
-- Name: COLUMN uausers.usr_job_title; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_job_title IS 'job title';


--
-- Name: COLUMN uausers.usr_team; Type: COMMENT; Schema: infra; Owner: _developer
--

COMMENT ON COLUMN infra.uausers.usr_team IS 'team name';


--
-- Name: omgroup_seq; Type: SEQUENCE; Schema: translate; Owner: _developer
--

CREATE SEQUENCE translate.omgroup_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE translate.omgroup_seq OWNER TO _developer;

--
-- Name: omgroup; Type: TABLE; Schema: translate; Owner: _developer
--

CREATE TABLE translate.omgroup (
    omg_seq integer DEFAULT nextval('translate.omgroup_seq'::regclass) NOT NULL,
    omg_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    omg_cby character varying(15) NOT NULL,
    omg_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    omg_mby character varying(15) NOT NULL,
    omg_mcount integer DEFAULT 0 NOT NULL,
    omg_class character varying(15) NOT NULL,
    omg_function character varying(50) NOT NULL
);


ALTER TABLE translate.omgroup OWNER TO _developer;

--
-- Name: COLUMN omgroup.omg_seq; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omgroup.omg_seq IS 'primary key';


--
-- Name: COLUMN omgroup.omg_cwhen; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omgroup.omg_cwhen IS 'creation timestamp';


--
-- Name: COLUMN omgroup.omg_cby; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omgroup.omg_cby IS 'created by';


--
-- Name: COLUMN omgroup.omg_mwhen; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omgroup.omg_mwhen IS 'modification timestamp';


--
-- Name: COLUMN omgroup.omg_mby; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omgroup.omg_mby IS 'modified by';


--
-- Name: COLUMN omgroup.omg_class; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omgroup.omg_class IS 'classification of strings, eg. schemas';


--
-- Name: COLUMN omgroup.omg_function; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omgroup.omg_function IS 'description of functionall grouping';


--
-- Name: omlibgrouplinks_seq; Type: SEQUENCE; Schema: translate; Owner: _developer
--

CREATE SEQUENCE translate.omlibgrouplinks_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE translate.omlibgrouplinks_seq OWNER TO _developer;

--
-- Name: omlibgrouplinks; Type: TABLE; Schema: translate; Owner: _developer
--

CREATE TABLE translate.omlibgrouplinks (
    olg_seq integer DEFAULT nextval('translate.omlibgrouplinks_seq'::regclass) NOT NULL,
    olg_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    olg_cby character varying(15) NOT NULL,
    olg_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    olg_mby character varying(15) NOT NULL,
    olg_mcount integer DEFAULT 0 NOT NULL,
    olg_oml_ref integer NOT NULL,
    olg_omg_ref integer NOT NULL
);


ALTER TABLE translate.omlibgrouplinks OWNER TO _developer;

--
-- Name: COLUMN omlibgrouplinks.olg_seq; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omlibgrouplinks.olg_seq IS 'primary key';


--
-- Name: COLUMN omlibgrouplinks.olg_cwhen; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omlibgrouplinks.olg_cwhen IS 'creation timestamp';


--
-- Name: COLUMN omlibgrouplinks.olg_cby; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omlibgrouplinks.olg_cby IS 'created by';


--
-- Name: COLUMN omlibgrouplinks.olg_mwhen; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omlibgrouplinks.olg_mwhen IS 'modifcation timestamp';


--
-- Name: COLUMN omlibgrouplinks.olg_mby; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omlibgrouplinks.olg_mby IS 'modified by';


--
-- Name: COLUMN omlibgrouplinks.olg_mcount; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omlibgrouplinks.olg_mcount IS 'modification count';


--
-- Name: COLUMN omlibgrouplinks.olg_oml_ref; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omlibgrouplinks.olg_oml_ref IS 'foregin key to omlibrary';


--
-- Name: omlibrary_seq; Type: SEQUENCE; Schema: translate; Owner: _developer
--

CREATE SEQUENCE translate.omlibrary_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE translate.omlibrary_seq OWNER TO _developer;

--
-- Name: omlibrary; Type: TABLE; Schema: translate; Owner: _developer
--

CREATE TABLE translate.omlibrary (
    oml_seq integer DEFAULT nextval('translate.omlibrary_seq'::regclass) NOT NULL,
    oml_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    oml_cby character varying(15) NOT NULL,
    oml_name character varying(15) NOT NULL
);


ALTER TABLE translate.omlibrary OWNER TO _developer;

--
-- Name: COLUMN omlibrary.oml_seq; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omlibrary.oml_seq IS 'primary key';


--
-- Name: COLUMN omlibrary.oml_cwhen; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omlibrary.oml_cwhen IS 'creation timestamp';


--
-- Name: COLUMN omlibrary.oml_cby; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omlibrary.oml_cby IS 'created by';


--
-- Name: COLUMN omlibrary.oml_name; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omlibrary.oml_name IS 'library name (upper case)';


--
-- Name: omstrings_seq; Type: SEQUENCE; Schema: translate; Owner: _developer
--

CREATE SEQUENCE translate.omstrings_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE translate.omstrings_seq OWNER TO _developer;

--
-- Name: omstrings; Type: TABLE; Schema: translate; Owner: _developer
--

CREATE TABLE translate.omstrings (
    oms_seq integer DEFAULT nextval('translate.omstrings_seq'::regclass) NOT NULL,
    oms_cwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    oms_cby character varying(15) NOT NULL,
    oms_mwhen timestamp without time zone DEFAULT ('now'::text)::timestamp(0) without time zone NOT NULL,
    oms_mby character varying(15) NOT NULL,
    oms_mcount integer DEFAULT 0 NOT NULL,
    oms_omg_ref integer,
    oms_cols_modified character varying(255),
    stringid character varying(50) NOT NULL,
    en text,
    de text,
    sv text,
    nl text,
    zh text,
    ca text,
    es text,
    it text,
    fr text,
    no text,
    fi text,
    da text,
    pt text,
    cy text,
    el text,
    pl text,
    hr text,
    bg text,
    tr text,
    ro text,
    cs text,
    hu text,
    ru text,
    ja text,
    ar text,
    he text
);


ALTER TABLE translate.omstrings OWNER TO _developer;

--
-- Name: COLUMN omstrings.oms_seq; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.oms_seq IS 'primary key';


--
-- Name: COLUMN omstrings.oms_cwhen; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.oms_cwhen IS 'creation timestamp';


--
-- Name: COLUMN omstrings.oms_cby; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.oms_cby IS 'created by';


--
-- Name: COLUMN omstrings.oms_mwhen; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.oms_mwhen IS 'modification timestamp';


--
-- Name: COLUMN omstrings.oms_mby; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.oms_mby IS 'modified by';


--
-- Name: COLUMN omstrings.oms_mcount; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.oms_mcount IS 'modification count';


--
-- Name: COLUMN omstrings.oms_omg_ref; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.oms_omg_ref IS 'foreign key to omgroup';


--
-- Name: COLUMN omstrings.oms_cols_modified; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.oms_cols_modified IS 'string of translation columns manually modified';


--
-- Name: COLUMN omstrings.stringid; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.stringid IS 'unique indexed string table entry identifier';


--
-- Name: COLUMN omstrings.en; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.en IS 'english';


--
-- Name: COLUMN omstrings.de; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.de IS 'german';


--
-- Name: COLUMN omstrings.sv; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.sv IS 'swedish';


--
-- Name: COLUMN omstrings.nl; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.nl IS 'dutch';


--
-- Name: COLUMN omstrings.zh; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.zh IS 'chinese';


--
-- Name: COLUMN omstrings.ca; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.ca IS 'catalan';


--
-- Name: COLUMN omstrings.es; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.es IS 'spanish';


--
-- Name: COLUMN omstrings.it; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.it IS 'italian';


--
-- Name: COLUMN omstrings.fr; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.fr IS 'french';


--
-- Name: COLUMN omstrings.no; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.no IS 'norwegian';


--
-- Name: COLUMN omstrings.fi; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.fi IS 'finnish';


--
-- Name: COLUMN omstrings.da; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.da IS 'danish';


--
-- Name: COLUMN omstrings.pt; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.pt IS 'portuguese';


--
-- Name: COLUMN omstrings.cy; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.cy IS 'welsh';


--
-- Name: COLUMN omstrings.el; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.el IS 'greek';


--
-- Name: COLUMN omstrings.pl; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.pl IS 'polish';


--
-- Name: COLUMN omstrings.hr; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.hr IS 'croatian';


--
-- Name: COLUMN omstrings.bg; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.bg IS 'bulgarian';


--
-- Name: COLUMN omstrings.tr; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.tr IS 'turkish';


--
-- Name: COLUMN omstrings.ro; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.ro IS 'romanian';


--
-- Name: COLUMN omstrings.cs; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.cs IS 'czech';


--
-- Name: COLUMN omstrings.hu; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.hu IS 'hungarian';


--
-- Name: COLUMN omstrings.ru; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.ru IS 'russian';


--
-- Name: COLUMN omstrings.ja; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.ja IS 'japanese';


--
-- Name: COLUMN omstrings.ar; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.ar IS 'arabic';


--
-- Name: COLUMN omstrings.he; Type: COMMENT; Schema: translate; Owner: _developer
--

COMMENT ON COLUMN translate.omstrings.he IS 'hebrew';


--
-- Data for Name: entgrouporganisations; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.entgrouporganisations (go_seq, go_cwhen, go_cby, go_mwhen, go_mby, go_mcount, go_name_full, go_name_short, go_addr_building, go_addr_street, go_addr_locality, go_addr_town, go_addr_state, go_addr_postcode, go_addr_country, go_comm_ph, go_comm_mob, go_comm_email, go_company_no, go_vat_no, go_currency, go_mec_id, go_mec_type, go_rrs, go_ddn_ap1, go_ddn_ap2, go_surname, go_firstnames, go_name_ltbc, go_dob, go_sex, go_mmn, go_id_type, go_id_code, go_mc_listid, go_report_to_go_ref, go_report_to_percent) FROM stdin;
1	2018-12-12 10:06:58	x	2018-12-12 10:06:58	x	0	\N	STB	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0.0000
\.


--
-- Data for Name: entgrouporgnames; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.entgrouporgnames (gon_seq, gon_cwhen, gon_cby, gon_mwhen, gon_mby, gon_mcount, gon_go_ref, gon_name_full, gon_type) FROM stdin;
1	2018-12-12 10:07:28	x	2018-12-12 10:07:28	x	0	1	STB	\N
\.


--
-- Data for Name: sysasyncemails; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysasyncemails (ae_seq, ae_to, ae_subject, ae_message, ae_cc, ae_bcc, ae_priority, ae_encl, ae_html, ae_cwhen, ae_go_ref, ae_fail_count, ae_fail_dialogue, ae_fail_status, ae_from, ae_extraheaders, ae_sendercode) FROM stdin;
\.


--
-- Data for Name: syslogerrors; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.syslogerrors (sle_cwhen, sle_code, sle_subcode, sle_message, sle_vhost_ref, sle_server_ip, sle_server_port) FROM stdin;
\.


--
-- Data for Name: syslogevents; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.syslogevents (slv_cwhen, slv_code, slv_subcode, slv_message, slv_vhost_ref, slv_server_ip, slv_server_port) FROM stdin;
\.


--
-- Data for Name: sysreferenceglobal; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysreferenceglobal (rfg_seq, rfg_class, rfg_value, rfg_desc, rfg_order, rfg_active, rfg_char, rfg_int, rfg_number, rfg_date, rfg_bin, rfg_time, rfg_effective, rfg_expires, rfg_json, rfg_cwhen, rfg_cby, rfg_mwhen, rfg_mby, rfg_mcount) FROM stdin;
2	GOOGLE	TRANSLATION_KEY	API key to the Google translation service	1	1	Enter your API Key here	\N	\N	\N	\N	\N	\N	\N	\N	2018-11-21 14:00:56	CONSOLE	2018-11-21 14:00:56	CONSOLE	0
\.


--
-- Data for Name: sysreferencelocal; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysreferencelocal (rfl_seq, rfl_class, rfl_value, rfl_desc, rfl_order, rfl_active, rfl_char, rfl_int, rfl_number, rfl_date, rfl_bin, rfl_time, rfl_effective, rfl_expires, rfl_json, rfl_cwhen, rfl_cby, rfl_mwhen, rfl_mby, rfl_mcount, rfl_inherit) FROM stdin;
\.


--
-- Data for Name: sysreferenceorg; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysreferenceorg (rfo_seq, rfo_class, rfo_value, rfo_desc, rfo_order, rfo_active, rfo_char, rfo_int, rfo_number, rfo_date, rfo_bin, rfo_time, rfo_effective, rfo_expires, rfo_json, rfo_go_ref, rfo_cwhen, rfo_cby, rfo_mwhen, rfo_mby, rfo_mcount, rfo_inherit) FROM stdin;
\.


--
-- Data for Name: sysreferenceuser; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.sysreferenceuser (rfu_seq, rfu_class, rfu_value, rfu_desc, rfu_order, rfu_active, rfu_char, rfu_int, rfu_number, rfu_date, rfu_bin, rfu_time, rfu_effective, rfu_expires, rfu_json, rfu_go_ref, rfu_usr_ref, rfu_cwhen, rfu_cby, rfu_mwhen, rfu_mby, rfu_mcount) FROM stdin;
\.


--
-- Data for Name: systaskstats; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.systaskstats (sts_seq, sts_start, sts_count_start, sts_end, sts_count_end, sts_last_response, sts_go_ref, sts_bytes_reqcursent, sts_bytes_reqcurrecd, sts_bytes_reqmaxsent, sts_bytes_reqmaxrecd, sts_bytes_reqtotsent, sts_bytes_reqtotrecd, sts_tot_events, sts_ula_ref, sts_ip4, sts_type, sts_db_requests, sts_fetches, sts_inserts, sts_updates, sts_deletes, sts_device_size, sts_init_class, sts_gl_ref, sts_browser, sts_ws_name, sts_table_name, sts_table_method, sts_params, sts_table_list) FROM stdin;
\.


--
-- Data for Name: uagrouporglinks; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.uagrouporglinks (ugo_seq, ugo_go_ref, ugo_usr_ref, ugo_cwhen, ugo_cby) FROM stdin;
1	1	1	2018-12-12 10:07:46	x
\.


--
-- Data for Name: ualogaccess; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.ualogaccess (ula_seq, ula_usr_ref, ula_login, ula_logout, ula_forms_visited, ula_ip_address, ula_go_name, ula_connect_time, ula_bytes_connect, ula_bytes_total_sent, ula_bytes_total_recd, ula_bytes_max_sent, ula_bytes_max_recd, ula_requests, ula_comment, ula_last_hit, ula_dg_ref) FROM stdin;
\.


--
-- Data for Name: uausers; Type: TABLE DATA; Schema: infra; Owner: _developer
--

COPY infra.uausers (usr_seq, usr_cwhen, usr_cby, usr_mwhen, usr_mby, usr_mcount, usr_usr_ref, usr_name, usr_real_name, usr_salt, usr_hashpass, usr_extn, usr_mobile, usr_email, usr_pw_expires, usr_ac_expires, usr_initials, usr_job_title, usr_team, usr_startdate, usr_active) FROM stdin;
1	2018-12-12 10:05:53	x	2018-12-12 10:05:53	x	\N	\N	console	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1
\.


--
-- Data for Name: omgroup; Type: TABLE DATA; Schema: translate; Owner: _developer
--

COPY translate.omgroup (omg_seq, omg_cwhen, omg_cby, omg_mwhen, omg_mby, omg_mcount, omg_class, omg_function) FROM stdin;
1	2017-04-25 14:22:58	stevensg	2017-04-25 14:22:58	stevensg	0	schemas	Infrastructure
3	2017-04-26 15:02:07	stevensg	2017-04-26 15:02:07	stevensg	0	messages	All messages
48	2017-05-10 13:38:21	mostynrs	2017-05-10 13:38:21	mostynrs	0	labels	REM.FORM menu entries
52	2017-06-09 14:22:58	MOSTYNRS	2017-06-09 14:22:58	MOSTYNRS	0	menus	Infrastructure
40	2017-04-27 17:24:14	stevensg	2017-04-27 17:24:14	stevensg	0	labels	Infrastructure
19	2017-04-27 16:23:51	stevensg	2017-04-27 16:23:51	stevensg	0	schemas	helloworld
42	2017-04-27 17:24:14	stevensg	2017-04-27 17:24:14	stevensg	0	labels	helloworld
57	2018-09-10 15:30:00	mostynrs	2018-09-10 15:30:00	mostynrs	0	menus	helloworld
\.


--
-- Data for Name: omlibgrouplinks; Type: TABLE DATA; Schema: translate; Owner: _developer
--

COPY translate.omlibgrouplinks (olg_seq, olg_cwhen, olg_cby, olg_mwhen, olg_mby, olg_mcount, olg_oml_ref, olg_omg_ref) FROM stdin;
14	2017-04-27 10:34:37	stevensg	2017-04-27 10:34:37	stevensg	0	11	1
53	2017-04-28 08:53:07	stevensg	2017-04-28 08:53:07	stevensg	0	11	40
54	2017-04-28 08:53:07	stevensg	2017-04-28 08:53:07	stevensg	0	11	42
90	2017-05-10 13:25:59	MOSTYNRS	2017-05-10 13:25:59	MOSTYNRS	0	11	19
96	2017-05-10 13:51:30	MOSTYNRS	2017-05-10 13:51:30	MOSTYNRS	0	11	48
101	2017-06-09 15:43:37	MOSTYNRS	2017-06-09 15:43:37	MOSTYNRS	0	11	3
135	2018-04-20 16:22:34	STEVENSG	2018-04-20 16:22:34	STEVENSG	0	11	52
140	2018-09-10 15:38:11	MOSTYNRS	2018-09-10 15:38:11	MOSTYNRS	0	11	57
\.


--
-- Data for Name: omlibrary; Type: TABLE DATA; Schema: translate; Owner: _developer
--

COPY translate.omlibrary (oml_seq, oml_cwhen, oml_cby, oml_name) FROM stdin;
11	2017-04-27 09:47:29	stevensg	HELLOWORLD
\.


--
-- Data for Name: omstrings; Type: TABLE DATA; Schema: translate; Owner: _developer
--

COPY translate.omstrings (oms_seq, oms_cwhen, oms_cby, oms_mwhen, oms_mby, oms_mcount, oms_omg_ref, oms_cols_modified, stringid, en, de, sv, nl, zh, ca, es, it, fr, no, fi, da, pt, cy, el, pl, hr, bg, tr, ro, cs, hu, ru, ja, ar, he) FROM stdin;
9956	2018-12-12 10:00:19	STEVENSG	2018-12-12 10:13:00	console	1	40	\N	greeting_LBL	Hello World!		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
712	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_BCC_LBL	list of email addressees		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
713	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_BCC_TT	list of email addressees		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
714	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_CC_LBL	list of email addressees		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
715	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_CC_TT	list of email addressees		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
716	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_CWHEN_LBL	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
717	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_CWHEN_TT	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
718	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_ENCL_LBL	attachments		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
719	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_ENCL_TT	attachments		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
720	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_FROM_LBL	from		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
721	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_GO_REF_LBL	internal company		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
722	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_HTML_LBL	HTML version of email message		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
723	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_HTML_TT	HTML version of email message		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
724	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_MESSAGE_LBL	email content		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
725	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_MESSAGE_TT	email content		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
726	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_PRIORITY_LBL	priority - 0 to 3		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
727	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_PRIORITY_TT	priority - 0 to 3		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
728	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
729	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
730	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_SUBJECT_LBL	subject		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
731	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_SUBJECT_TT	subject line of email		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
732	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_TO_LBL	to		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1798	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_MBY_TT	Identity of person who last modified this record.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1758	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_EO_REF_LBL	foreign key to external organisation - entExtOrganaisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1759	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_EO_REF_TT	foreign key to external organisation - entExtOrganaisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1760	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_FINACCT_CUID_LBL	sales ledger ID		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1761	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_FINACCT_CUID_TT	customer ID in financial accounting system sales ledger		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1762	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_FINACCT_SUID_LBL	purchase ledger ID		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1763	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_FINACCT_SUID_TT	supplier ID in financial accounting system purchase ledger		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1764	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_GO_REF_LBL	internal company		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1765	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_GO_REF_TT	reference to internal organisation - entGroupOrganisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
733	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AE_TO_TT	list of email addressees		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
801	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_BINARY_LBL	data in binary format		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
802	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_BINARY_TT	data in binary format		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
803	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
804	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_CBY_TT	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
805	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_CWHEN_LBL	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
806	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_CWHEN_TT	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
807	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_MBY_LBL	updated by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
808	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_MBY_TT	updated by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
809	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_MWHEN_LBL	latest update		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
810	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_MWHEN_TT	latest update		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
811	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_PK_LBL	primary key of associated record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
812	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_PK_TT	primary key of associated record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
813	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
814	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
815	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_TABLE_PREFIX_LBL	table identifier		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1766	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1767	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_MBY_TT	Identity of person who last modified record.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1768	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1769	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1770	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_MWHEN_LBL	modified		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1771	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_MWHEN_TT	Timestamp when record was last modified.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1772	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	EOL_REFS	either a supplier or customer code		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1773	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_SEQ_LBL	record ID		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1774	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1775	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_ADDR_BILL_LBL	billing address		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1776	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_ADDR_BILL_TT	organisation's address for sending the invoice to		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1777	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_ADDR_SHIP_LBL	shipping address		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1778	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_ADDR_SHIP_TT	optional address (shipping for customer records)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1779	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1780	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_CBY_TT	Identity of person who created this record.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1781	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_COMMENT_LBL	comment		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1782	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_COMMENT_TT	general comment such as what is supplied		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1783	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_COMPANY_NO_LBL	company registration no		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1784	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_COMPANY_NO_TT	company registration no		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1785	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_CONTACT_LBL	contact name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1786	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_CONTACT_TT	Name of person with organisation with whom to discuss accounts issues.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1787	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_CWHEN_LBL	created		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
816	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	AS_TABLE_PREFIX_TT	table identifier		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1788	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_CWHEN_TT	Timestamp of when record was created.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1789	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_EMAIL_LBL	contact email		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1790	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_EMAIL_TT	email address for the contact within the organisation with whom to discuss accounts issues		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1791	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_FAX_LBL	fax		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1792	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_FAX_TT	fax number for the named contact within the organisation		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1793	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	EO_Heading	Suppliers and Customers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1794	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_INSTRUCTIONS_LBL	shipping instructions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1795	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_INSTRUCTIONS_TT	other relevant information/instructions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1796	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	EO_Intro	organisations to whom we send or from whom we receive eco invoices and products		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1797	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1799	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1800	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1803	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_MWHEN_LBL	modified		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1804	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_MWHEN_TT	Timestamp of when record was last modified.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1806	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_NAME_TT	Name of company or organisation 		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1807	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_PHONE_LBL	phone		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1808	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_PHONE_TT	phone number for the contact within the organisation		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1809	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_SEQ_LBL	record ID		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1810	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_SEQ_TT	Unique record number.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1811	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_VAT_NO_LBL	VAT no		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1812	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EO_VAT_NO_TT	company VAT no		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1813	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	EO_icSearch_CT	search text here		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1805	2017-04-27 15:20:51	stevensg	2017-06-15 14:54:58	STEVENSG	1	1	\N	EO_NAME_LBL	company name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1801	2017-04-27 15:20:51	stevensg	2018-04-10 16:01:00	STEVENSG	1	1	\N	EO_MEC_ID_LBL	EcoCost ID		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1818	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	ERR_INVALID_VALUE	invalid value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1819	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	ERR_MAX_VAL_EXCEEDED	maximum value exceeded		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2045	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2046	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_MWHEN_LBL	modification timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2047	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_MWHEN_TT	modification timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2048	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_NAME_FULL_LBL	full name of organisation		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2049	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_NAME_FULL_TT	full name of organisation		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2050	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2051	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2052	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_TYPE_LBL	I=Internal use, E=default value to send with ecoInvoices		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2053	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_TYPE_TT	I=Internal use, E=default value to send with ecoInvoices		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2054	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_BUILDING_LBL	Building name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2055	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_BUILDING_TT	Building name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1997	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_PERMISSIONS	Permissions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2000	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_PRD	Product definitions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2004	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_RES	Resources		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2006	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_RFL	Group configuration		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2007	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_RFO	Company configuration		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2008	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_ROLES	Roles		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2014	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_SUPP	Suppliers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2016	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_UOM	Units of measurement		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2017	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_UP	User preferences		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2018	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_USERS	Users		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2056	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_COUNTRY_LBL	Country		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2057	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_COUNTRY_TT	Country		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1109	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_ACTIVE_LBL	active		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1110	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1111	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_CBY_TT	user who created this record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1112	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_CONTINENT_LBL	continent		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1113	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_CONTINENT_TT	used for grouping		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1114	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_CWHEN_LBL	creation date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1115	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_CWHEN_TT	creation date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1116	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_INTL_DIAL_CODE_LBL	dial code prefix		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1117	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_INTL_DIAL_CODE_TT	International dialling code for this country		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1118	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_ISO2_LBL	ISO 2 code		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1119	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_ISO3_LBL	ISO 3 code		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1120	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_LANGS_LBL	languages		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1121	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1122	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1123	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1125	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_MONEY_SYMB_LBL	currency symbol		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1126	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_MWHEN_LBL	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1127	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_MWHEN_TT	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1124	2017-04-27 15:20:51	stevensg	2018-04-10 16:01:00	STEVENSG	1	1	\N	CO_MM_OFFICE_LBL	EcoCost office exists		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1128	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_NAME_LBL	country name - english		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1129	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_NAME_LOCAL_LBL	country name - local language		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1130	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_PCODE_FORMAT_LBL	meta description of postcode formatting rules		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1131	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	CO_PCODE_FORMAT_TT	meta description of postcode formatting rules		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2058	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_LOCALITY_LBL	Locality		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2059	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_LOCALITY_TT	Locality		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2060	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_POSTCODE_LBL	Postcode		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2061	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_POSTCODE_TT	Postcode		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4247	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_DATE_LBL	date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2062	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_STATE_LBL	State or county		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2063	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_STATE_TT	State or county		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2064	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_STREET_LBL	Number and street		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2065	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_STREET_TT	Number and street		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2066	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_TOWN_LBL	Town		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2067	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ADDR_TOWN_TT	Town		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1293	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	CUSTOMER_LBL	customer		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1294	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	CUSTOMER_TT	full name of customer		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1295	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	CUST_EO_NAME_LBL	customer's name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1296	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	CUST_EO_NAME_TT	name of the customer or client		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1297	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	CUST_Heading	Customers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1298	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	CUST_Intro	organisations to whom we send products and eco invoices		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1300	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	Char_LBL	C		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1301	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	Char_TT	character variable		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1303	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	DB_ERR	database error		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1756	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_CWHEN_LBL	created timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2068	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	GO_ALL_RECORDS	All Group Companies		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2069	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2070	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_CBY_TT	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2071	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_COMM_EMAIL_LBL	Email		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2072	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_COMM_EMAIL_TT	Email		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2073	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_COMM_MOB_LBL	Fax		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2074	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_COMM_MOB_TT	Fax		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2075	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_COMM_PH_LBL	Phone		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2076	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_COMM_PH_TT	Phone		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2077	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_COMPANY_NO_LBL	Company no.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2078	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_COMPANY_NO_TT	Company no.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2079	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_CURRENCY_LBL	currency symbol		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2080	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_CURRENCY_TT	currency symbol for product pricing		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2081	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_CWHEN_LBL	created timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2082	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_CWHEN_TT	created timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2084	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_DDN_AP1_TT	primary access point for the data delivery network		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2086	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_DDN_AP2_TT	fall back access point for the data delivery network		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2087	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_DOB_LBL	Individual's Date of birth		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2088	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_DOB_TT	Individual's Date of birth		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2089	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_FIRSTNAMES_LBL	All names excluding surname		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2090	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_FIRSTNAMES_TT	All names excluding surname		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2091	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	GO_Heading	Group Companies		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2092	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ID_CODE_LBL	Identification number		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2093	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ID_CODE_TT	Identification number		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2094	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ID_TYPE_LBL	Type of offical ID - passport, drivers licence, national insurance no		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2095	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_ID_TYPE_TT	Type of offical ID - passport, drivers licence, national insurance no		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2096	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	GO_Intro	at least 1 Company must be represented here		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2097	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2098	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_MBY_TT	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2099	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2100	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2102	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_MEC_ID_TT	unique MEC user ID throughout the world		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2105	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_MMN_LBL	Mothers maiden name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1556	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	Description_LBL	description		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1557	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	Description_TT	detailed description of the item		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1757	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_CWHEN_TT	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1754	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1755	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	EOL_CBY_TT	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2106	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_MMN_TT	Mothers maiden name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2107	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_MWHEN_LBL	modified timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2108	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_MWHEN_TT	modified timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2109	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_NAME_FULL_LBL	organisation's full name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2110	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_NAME_FULL_TT	organisation's full name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2111	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_NAME_LTBC_LBL	Name like to be called		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2112	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_NAME_LTBC_TT	Name like to be called		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2113	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_NAME_SHORT_LBL	organisation short name  		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2114	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_NAME_SHORT_TT	organisation short name  		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2115	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_RRS_LBL	URL of the relevant registration server		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2101	2017-04-27 15:20:51	stevensg	2018-04-10 16:02:00	STEVENSG	1	1	\N	GO_MEC_ID_LBL	EcoCost identifier		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2103	2017-04-27 15:20:51	stevensg	2018-04-10 16:02:00	STEVENSG	1	1	\N	GO_MEC_TYPE_LBL	EcoCost registration type		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2104	2017-04-27 15:20:51	stevensg	2018-04-10 16:02:00	STEVENSG	1	1	\N	GO_MEC_TYPE_TT	EcoCost registration type		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2116	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_RRS_TT	URL of the relevant registration server		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2117	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2118	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2119	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_SEX_LBL	Individual's gender		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2120	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_SEX_TT	Individual's gender		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2121	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_SURNAME_LBL	Individual's family name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2122	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_SURNAME_TT	Individual's family name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2123	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_VAT_NO_LBL	VAT no.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2124	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GO_VAT_NO_TT	VAT no.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2127	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2128	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_CBY_TT	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2129	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_CWHEN_LBL	created timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2130	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_CWHEN_TT	created timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2131	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_DESC_LANG_LBL	translation of foreign table DESC column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2256	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Intro_4	There may or may not be a drop down list here.  If they are shown you can use these to locate certain groups of records.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2257	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Intro_5	The result set:  whatever criteria has been applied above will show a list of found records here.  Click a line in this list to display the full contents of the record in the light grey area.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2259	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Intro_7	Further information may be hidden within tabs - click on a tab to see more information.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2260	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Intro_9	If it is grey the field is display only and cannot be changed.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2380	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	IMT_CBY_TT	user who created this record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2381	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	IMT_CWHEN_LBL	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2382	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	IMT_CWHEN_TT	creation date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2383	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	IMT_HEADER_LBL	import file has a header row		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2384	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	IMT_HEADER_TT	import file has a header row		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2385	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	IMT_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2386	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	IMT_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1821	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	ERR_NODEL_CHILDREN	record has associated child records, delete those first		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1822	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	ERR_OUT_OF_RANGE	value out of range		\N	\N	\N	\N	Valor fuera de rango	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1820	2017-04-27 15:20:51	stevensg	2017-12-18 15:16:00	STEVENSG	1	3	\N	ERR_NODEL_CALCULATION	record has associated calculations and cannot be removed		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1888	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	FEEDBACK_Heading	User feedback form - thank you		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1889	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	FEEDBACK_Intro	please make your comments below and click ‘save’ when completed		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2387	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	IMT_MWHEN_LBL	modification timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2388	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	IMT_MWHEN_TT	modification timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2427	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	Integer_LBL	I		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2428	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	Integer_TT	integer variable		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2469	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CAPITAL_ENDONYM_LBL	country capital in local language		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2470	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CAPITAL_ENDONYM_TT	country capital in local language		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2471	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CAPITAL_EXONYM_LBL	country capital in english		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2472	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CAPITAL_EXONYM_TT	country capital in english		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2473	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CAPITAL_TRANSLIT_ENDONYM_LBL	transliteration of capital		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2474	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CAPITAL_TRANSLIT_ENDONYM_TT	transliteration of capital in local language to latin text (usually english but sometimes french or others)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2475	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2476	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CBY_TT	user who created this record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2477	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_COUNTRY_TRANSLIT_ENDONYM_LBL	transliteration of country		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2478	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_COUNTRY_TRANSLIT_ENDONYM_TT	transliteration of country in local language to latin text (usually english but sometimes french or others)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2492	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_MAINLANG_TT	1 if this is the main language of the country		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2494	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_MBY_TT	user who last modified this record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2495	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2496	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2497	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_MWHEN_LBL	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2498	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_MWHEN_TT	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2499	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_OFFICIAL_LBL	1 if language is an official language of the country		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2500	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_OFFICIAL_TT	1 if language is an official language of the country		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2501	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2502	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2506	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_ACTIVE_LBL	active		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2507	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2508	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_CBY_TT	user who created this record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2509	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_CWHEN_LBL	creation date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2510	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_CWHEN_TT	creation date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2511	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_ENDONYM_LBL	endonym		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2512	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_ISO2_LBL	ISO 2 code		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2513	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_ISO3_ALT_LBL	alternate ISO 3 code		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2514	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_ISO3_LBL	ISO 3 code		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2515	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2516	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2517	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_MWHEN_LBL	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2518	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_MWHEN_TT	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1975	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_CUST	Customers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1981	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_EO	Suppliers and Customers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1983	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_FOH	Financial invoices preparation		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1984	2017-04-27 15:20:51	stevensg	2017-06-09 14:29:00	MOSTYNRS	2	48	\N	FORM_GO	Group companies		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1985	2017-04-27 15:20:51	stevensg	2018-01-30 10:38:00	STEVENSG	2	48	\N	FORM_HELP	Help with using the system		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2030	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GL_CWHEN_LBL	creation date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2031	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GL_CWHEN_TT	creation date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2519	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_NO_OF_SPEAKERS_LBL	No. of speakers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2520	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LG_SEQ_LBL	record ID		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2533	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	LOGIN_FAILED	login failed		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2534	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	LoginID_LBL	login ID		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2535	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	LoginID_TT	your unique login ID is entered here		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2536	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	LoginPW_LBL	password		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2747	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_ADDCRITERIATEXT	provide additional criteria in text search		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2748	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_ADMINPWORD	administrator password must be at least 7 characters in length		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2749	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_ALLCUSTOMERS	All customers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2750	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_ALLORGSPRIVS	with privileges to select all Organisations, all records have been fetched		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2838	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_PWORDMISMATCH	passwords do not match		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2839	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_RAWNODISP	raw - no display -		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2840	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_RECORDCOUNT	record count of		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2841	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_REFINE	please refine your search		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2844	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_ROWSINSERTED	records inserted		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2845	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_ROWSUSINGBATCH	rows using batch id of		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2846	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_ROWSUSINGPROD	rows using product id of		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2847	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_SAVESETTINGS	If you wish to save your settings, please enter a name for the template and click ok		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2848	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_SAVESETTINGSCHANGED	The template has been changed.  If you wish to save it, click ok.  To save it under a different name, change it here first.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2849	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_SERVCALL_FAILED	Service call FAILURE ! 		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2850	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_SERVCALL_SUCCESS	Service call successful		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2851	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_SERVICESTATUS	Service status 		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2852	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_SUBMITCANCELLED	Submission cancelled		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2853	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_SUBMITSUCCESS	Submission successful		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2854	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_SUPPNAMECODEMISMATCH	Supplier code does not match supplier name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2855	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_SUPPNAMENOCODE	Supplier name without supplier product code		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2856	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_SUPPNAMENOTFOUND	Supplier name not found:		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2857	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_SUPPNOTFOUND	Supplier not found		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2858	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_THOUSEPARATOR	thousands separator		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4244	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_CLASS_TT	classification column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4245	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_CWHEN_LBL	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4246	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_CWHEN_TT	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4248	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_DATE_TT	To refer to a date, use this field.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4249	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_DESC_LBL	description		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2032	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GL_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2033	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GL_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2034	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GL_MWHEN_LBL	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2035	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GL_MWHEN_TT	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2036	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2037	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_CBY_TT	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2038	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_CWHEN_LBL	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2039	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_CWHEN_TT	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2040	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_GO_REF_LBL	foreign key to entGroupOrganisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2041	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_GO_REF_TT	foreign key to entGroupOrganisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2042	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2043	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_MBY_TT	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2044	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GON_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2132	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_DESC_LANG_TT	translation of foreign table DESC column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2133	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_FT_PREFIX_LBL	prefix identifying foreign table this record belongs to		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2134	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_FT_PREFIX_TT	prefix identifying foreign table this record belongs to		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2135	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_FT_REF_LBL	foreign key to table identified by GT_FT_PREFIX		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2136	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_FT_REF_TT	foreign key to table identified by GT_FT_PREFIX		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2137	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_LANG_CODE_LBL	language and country code, eg. it_it		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2138	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_LANG_CODE_TT	language and country code, eg. it_it		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2139	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2140	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_MBY_TT	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2141	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2142	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2143	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_MWHEN_LBL	modifed timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2144	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_MWHEN_TT	modifed timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2145	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_NAME_LANG_LBL	translation of foreign table NAME column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2146	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_NAME_LANG_TT	translation of foreign table NAME column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2147	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2148	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	GT_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2171	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	Grid_FOD_LBL	Invoice Detail,Product code,Description,Unit price,Unit tax,Qty,Price,Tax,Total		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2172	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	Grid_FOD_TT	all financial invoice items with quantities and prices		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4250	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_DESC_TT	description		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4252	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_EFFECTIVE_TT	if record has a shelf life, the from and to date can be set		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4254	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_EXPIRES_TT	if record has a shelf life, the from and to date can be set		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4255	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFG_Heading	Global System Configuration		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4256	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_INT_LBL	integer value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4257	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_INT_TT	Use this field for integers.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4258	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFG_Intro	Configuration values that apply across ALL installations of the system		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4259	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_JSON_LBL	JSON		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4260	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4261	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2237	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Display_8	Record was not saved because XXXX was missing.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2238	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Heading_1	Application Navigation area		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2239	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Heading_10	If you see a field with a magenta border, 		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2240	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Heading_11	A field with a light blue background must be a unique value.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2241	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Heading_12	Buttons represent actions you can take		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2242	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Heading_2	Record Navigation area - to the left		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2243	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Heading_3	Record Navigation - text search		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2244	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Heading_4	Record Navigation - criteria selection lists		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2245	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Heading_5	Record Navigation - result set		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2246	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Heading_6	The heading and some helpful information		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2247	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Heading_7	Within the grey area is the full information about the record you have selected on the left.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2248	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Heading_8	Any error messages are displayed at the bottom of the form.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2249	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Heading_9	If you see a field in white, you can alter the contents of that field.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2479	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CO_ENDONYM_LBL	country name in local language		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2480	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CO_ENDONYM_TT	country name in local language		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4262	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_MWHEN_LBL	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4263	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_MWHEN_TT	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4264	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_NUMBER_LBL	floating number		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4265	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_NUMBER_TT	Use this field for real numbers.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4266	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_ORDER_LBL	ordering column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4267	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_ORDER_TT	ordering column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4268	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4269	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4270	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFG_VALUES	Global values		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4271	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_VALUE_LBL	specific reference value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4272	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_VALUE_TT	specific reference value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4273	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_ACTIVE_LBL	active?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4274	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_ACTIVE_TT	If unchecked, accessing this record in the rest of the system will be suppressed.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4275	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_BIN_LBL	binary value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4276	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_BIN_TT	binary content		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4277	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_CBY_LBL	creator		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4278	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_CBY_TT	creator		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2250	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Intro_1	The light yellow bar at top of screen is the Application Navigation area.  Use the drop down list to choose the function you want to access.  You will only see functions that you have been granted permission to use.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2251	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Intro_10	it will be a mandatory field and cannot be left blank		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2252	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Intro_11	more than 1 field light blue then a combination of those fields must be unique.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2253	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Intro_12	Clicking on + will create a new record;  click on pencil to write over an existing record; - will delete a record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2254	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Intro_2	All of the light green area is the record navigation area.  This area is used to find the record(s) you want to view.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2255	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Intro_3	There may or may not be a text search box in the top left corner.  If it is there you can do a text search for records.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2258	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	HELP_Intro_6	will be displayed where you are seeing this text.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2379	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	IMT_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2481	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CO_EXONYM_LBL	country in english		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2482	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CO_EXONYM_TT	country in english		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2483	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CO_REF_ISO3_LBL	link to country table		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2484	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CO_REF_ISO3_TT	link to country table		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2485	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CWHEN_LBL	creation date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2486	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_CWHEN_TT	creation date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2487	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_LGREF_ISO3_LBL	link to languages table		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2488	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_LGREF_ISO3_TT	link to languages table		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2489	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_LG_REF_LBL	foreign key to language		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2490	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_LG_REF_TT	foreign key to language		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2491	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_MAINLANG_LBL	1 if this is the main language of the country		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2493	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	LC_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2751	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_ASSIGNROLESORGS	assign roles and group organisations to Users		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2752	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_ATLEAST	There must be at least		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2760	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_CANCWITHOUTRETURN	cancelled without a form to return to		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2763	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_CANNOTVIEWRESULTS	Results cannot be viewed while editing data		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2765	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_CLASSFIRSTCHAR	First character of Classification must be a letter of the alphabet.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2766	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_CONFIRM	Are you sure?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2767	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_CREATEUSERS	create new users		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2768	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_CUSTEXISTS	new Customer record already exists		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2769	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_DATAINTEGRITY	data integrity problem		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2770	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_DBCONNECTBROKEN	Connection to database is broken.  Please try again later.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2771	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_DECSEPARATOR	decimal separator		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2783	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_FIXERRORS	please fix the displayed errors		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2786	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_GT_MAXRETURN_e	con('>',inMaxReturnCount,' rows, please refine')		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2787	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_IMPABORT	Import aborted.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2788	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_IMPABORTERRORS	Import aborted due to excessive errors		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2795	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_INVALIDPRDREF	Invalid - value did not identify a product		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2796	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_INVALIDREENTER	invalid entry - re-enter		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2797	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_INVALIDSUBMISSION	INVALID SUBMISSION		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2798	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_INVALIDTAXBAND	Tax Band has invalid value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2799	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_LOGINFAILEDCOMPANY	login failed for company		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2800	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_LOGINFAILEDRETRY	login failed - try again		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2803	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_MICROMISMATCH	product linked to a different retail product		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2804	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_MINBATCH	batch quantity must be greater than zero		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4279	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_CHAR_LBL	big character column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4280	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_CHAR_TT	big character column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2805	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_MISSINGCURRENCY	You must have a currency symbol to present the correct banking details.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3159	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	OTHER	other period		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2807	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_MISSINGPRDSUPPCODE	product has no supplier code		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2814	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_MODEL_RESALESTEP3	Resale product output		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2815	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_MULTIGO	multiple group org links when not expected		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2820	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_NEWPWORD	new password must be at least 7 characters in length		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2823	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_NONEXIST	does not exist		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2824	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_NOQUEUE	There are no records in the queue		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2825	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_NORETURNFORM	there is no previous form to return to		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2826	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_NOSERVCALL	No service call made.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2829	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_NOTFOUND	not found		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2830	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_NOTVALIDPROD	is not a valid product code		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2831	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_NOTXLSX	not recognised as a .xlsx file		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2834	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_PREVCOMMENTS	Earlier comments		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2835	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_PROVIDEMORE	Provide more characters to reduce result set.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2836	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_PWORDCHANGED	password changed		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3374	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2837	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_PWORDMIN	password must be at least 7 characters in length		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2859	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_TOOMANYPROD	Too many products using		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2860	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_TOOMANYROWS	too many rows returned		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2861	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_TYPEMISMATCH	data type mismatch		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2862	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_UNABLERECOVER	Unable to recover useful data.  Reloading from database.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2863	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_UNEXPECTEDERR	unexpected error occurred, unable to return		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2865	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_UNSPECIFIEDUSER	User type not specified		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2866	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_UNSUPPORTEDIMPORT	not supported for import		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2867	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_UPDATEBUSRECORD	updated businss record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2868	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_UPDATEDCONTACTPLURAL	updated contacts		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2869	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_UPDATEDCONTACTSINGLE	updated contact		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2871	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	MSG_VALIDEMAILMANDATORY	this must be a valid email address		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2864	2017-04-27 15:20:51	stevensg	2017-07-04 16:30:00	STEVENSG	1	3	\N	MSG_UNRECOGNISEDEOL	does not have a recognised end-of-line character sequence		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2870	2017-04-27 15:20:51	stevensg	2018-04-12 11:27:00	STEVENSG	2	3	\N	MSG_USERMANAGE	User management		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2919	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	NavigationList	you can access the following:		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3362	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	PERMISSIONS_Heading	Permissions definition		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3363	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	PERMISSIONS_Intro	create new permissions, assign roles to permissions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3364	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	PER_ALL_RECORDS	All Permissions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3365	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	PER_ASSIGNED_ALL_ROLES	Permission has been assigned to all Roles		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3366	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3367	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_CBY_TT	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3368	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_CWHEN_LBL	created timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4281	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFL_CLASSES	Local reference classes		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4282	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_CLASS_LBL	classification		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4283	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_CLASS_TT	classification column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4284	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_CWHEN_LBL	created		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4285	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_CWHEN_TT	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4286	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_DATE_LBL	date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4287	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_DATE_TT	To refer to a date, use this field.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4288	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_DESC_LBL	description		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3369	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_CWHEN_TT	timestamp of when record was created		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3370	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_DESC_EN_LBL	description		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3371	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_DESC_EN_TT	descriptive label (English) eg. create users, modify process models, etc.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3372	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_LABEL_LBL	permission code		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3373	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_LABEL_TT	unique permission code used by the application to assign access		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3375	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_MBY_TT	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3376	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3377	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3378	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_MWHEN_LBL	modified when		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3379	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_MWHEN_TT	modified timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3380	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	PER_NEW	Enter name of  new permission		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3381	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	PER_ROLE_LIST	Roles using this Permission		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3382	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	PER_ROL_ADD	Add role to Permission		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3383	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_SEQ_LBL	record ID		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3384	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	PER_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4289	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_DESC_TT	description		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4291	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_EFFECTIVE_TT	if record has a shelf life, the from and to date can be set		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4293	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_EXPIRES_TT	if record has a shelf life, the from and to date can be set		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4294	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFL_Heading	Group Configuration		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4295	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_INT_LBL	integer value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4296	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_INT_TT	Use this field for integers.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4297	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFL_Intro	Configuration values that apply across all group companies		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4298	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_JSON_LBL	JSON		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4299	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_JSON_TT	this field will accept valid JSON only.  It can be validated with the on screen button before saving.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4300	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4301	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_MBY_TT	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4302	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4303	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4304	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_MWHEN_LBL	modified		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4305	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_MWHEN_TT	modified timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4306	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_NUMBER_LBL	floating number		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4307	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_NUMBER_TT	number value with any scale/precision		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4308	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_ORDER_LBL	ordering column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4309	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_ORDER_TT	ordering column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4310	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4311	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4312	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_TIME_LBL	time of day		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4292	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	1	\N	RFL_EXPIRES_LBL	valid to date		\N	\N	\N	\N	Válido hasta la fecha	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4313	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_TIME_TT	time of day		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4314	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFL_VALUES	Local values		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4315	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_VALUE_LBL	specific reference value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4316	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFL_VALUE_TT	specific reference value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4317	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_ACTIVE_LBL	active?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4318	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_ACTIVE_TT	If unchecked, accessing this record in the rest of the system will be suppressed.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4319	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_BIN_LBL	binary value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4320	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_BIN_TT	binary value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4321	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_CBY_LBL	creator		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4322	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_CBY_TT	creator		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4323	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_CHAR_LBL	big character column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4324	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_CHAR_TT	big character column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4325	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFO_CLASSES	Company reference classes		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4326	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_CLASS_LBL	classification column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4327	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_CLASS_TT	classification column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4328	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_CWHEN_LBL	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4329	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_CWHEN_TT	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4330	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_DATE_LBL	date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4331	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_DATE_TT	To refer to a date, use this field.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4332	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_DESC_LBL	description		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4333	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_DESC_TT	description		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4335	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_EFFECTIVE_TT	if record has a shelf life, the from and to date can be set		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4337	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_EXPIRES_TT	if record has a shelf life, the from and to date can be set		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4338	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_GO_REF_LBL	foreign key to GroupOrganisation		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4339	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_GO_REF_TT	foreign key to GroupOrganisation		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4340	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFO_Heading	Company Configuration		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4341	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_INT_LBL	integer value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4342	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_INT_TT	Use this field for integers.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4343	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFO_Intro	Configuration values for a specific company within the group		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4344	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_JSON_LBL	JSON		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4345	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_JSON_TT	this field will accept valid JSON only.  It can be validated with the on screen button before saving.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4346	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4347	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_MBY_TT	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4348	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4349	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4350	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_MWHEN_LBL	modified timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4351	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_MWHEN_TT	modified timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4352	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_NUMBER_LBL	floating number		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4353	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_NUMBER_TT	number with any scale/precision		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4354	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_ORDER_LBL	ordering column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4355	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_ORDER_TT	ordering column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4356	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4357	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4358	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_TIME_LBL	time of day		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4359	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_TIME_TT	time of day		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4360	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFO_VALUES	Company configuration values		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4361	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_VALUE_LBL	specific reference value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4362	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFO_VALUE_TT	specific reference value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4363	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_ACTIVE_LBL	active?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4436	2017-04-27 15:20:51	stevensg	2018-01-18 13:01:00	MOSTYNRS	1	1	\N	ROL_ACTIVE_LBL	active		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4546	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_CLASS_TT	select the form to which this feedback is relevant		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4364	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_ACTIVE_TT	when ticked, indicates that the value is to be used within the system		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4365	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_BIN_LBL	binary value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4366	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_BIN_TT	binary value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4367	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_CBY_LBL	creator		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4368	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_CBY_TT	creator		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4369	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_CHAR_LBL	big character column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4370	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_CHAR_TT	big character column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4371	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFU_CLASSES	User preference classes		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4372	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_CLASS_LBL	classification column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4336	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	1	\N	RFO_EXPIRES_LBL	valid to date		\N	\N	\N	\N	Válido hasta la fecha	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4373	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_CLASS_TT	classification column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4374	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_CWHEN_LBL	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4375	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_CWHEN_TT	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4376	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_DATE_LBL	date column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4377	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_DATE_TT	date column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4378	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_DESC_LBL	description		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4379	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_DESC_TT	description		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4384	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_GO_REF_LBL	foreign key to entgrouporganisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4385	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_GO_REF_TT	foreign key to entgrouporganisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4386	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFU_Heading	User Preferences		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4387	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_INT_LBL	integer value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4388	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_INT_TT	integer value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4389	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFU_Intro	user's personal system preferences when logged in to the current company		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4390	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_JSON_TT	this field will accept valid JSON only.  It can be validated with the on screen button before saving.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4391	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4392	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_MBY_TT	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4393	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4394	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4395	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_MWHEN_LBL	modified timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4396	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_MWHEN_TT	modified timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4397	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_NUMBER_LBL	floating number		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4398	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_NUMBER_TT	number with any scale/precision		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4399	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_ORDER_LBL	ordering column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4400	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_ORDER_TT	ordering column		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4401	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4402	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4403	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_TIME_LBL	time of day		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4404	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_TIME_TT	time of day		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4405	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_USR_REF_LBL	foreign key to uausers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4446	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_MBY_TT	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4447	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4448	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4449	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_MWHEN_LBL	modified timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4450	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_MWHEN_TT	modified timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4451	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_NAME_LBL	name of the role, eg. auditor, administrator, manager, 		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4452	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_NAME_TT	name of the role, eg. auditor, administrator, manager, 		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4453	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ROL_NEW	Enter name of new role		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4454	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ROL_PER_ADD	Add permission to Role		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4240	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_CHAR_LBL	text data		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4234	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_ACTIVE_LBL	active?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4235	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_ACTIVE_TT	If unchecked, accessing this record in the rest of the system will be suppressed.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4236	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_BIN_LBL	binary value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4237	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_BIN_TT	container for binary data		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4238	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4239	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_CBY_TT	user who created this record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4241	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_CHAR_TT	this box can hold a large volume of text		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4242	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	RFG_CLASSES	Glocal reference classes		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4243	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFG_CLASS_LBL	classification		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4406	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_USR_REF_TT	foreign key to ususers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4407	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_VALUE_LBL	specific reference value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4408	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RFU_VALUE_TT	specific reference value		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4382	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	1	\N	RFU_EXPIRES_LBL	validity end date		\N	\N	\N	\N	Fecha de finalización de validez	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4383	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	1	\N	RFU_EXPIRES_TT	validity end date		\N	\N	\N	\N	Fecha de finalización de validez	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4434	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ROLES_Heading	Role management		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4435	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ROLES_Intro	create new Roles, assign permissions and users to Roles		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4438	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ROL_ALL_RECORDS	All Roles		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4439	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	ROL_ASSIGNED_ALL_PERMS	Role has been assigned all Permissions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4440	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	ROL_ASSIGNED_ALL_USERS	Role has been assigned to all Users		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4441	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4442	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_CBY_TT	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4443	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_CWHEN_LBL	created timetamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4444	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_CWHEN_TT	created timetamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4445	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4456	2017-04-27 15:20:51	stevensg	2018-01-18 13:18:00	MOSTYNRS	1	1	\N	ROL_REVOKE_LBL	revoke		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4457	2017-04-27 15:20:51	stevensg	2018-01-18 13:19:00	MOSTYNRS	1	1	\N	ROL_REVOKE_TT	When checked, this role will REVOKE the permissions assigned to it from the user.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4504	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	Real_TT	real number variable		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4539	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	SEQ_Heading	Sequential primary keys		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4540	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	SEQ_Intro	with ability to adjust them		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4543	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4544	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_CBY_TT	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4545	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_CLASS_LBL	name of form		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4547	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_CLASS_VSN_LBL	class version number / date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4548	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_CLASS_VSN_TT	class version number / date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4455	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ROL_PER_LIST	Permissions assigned to Role		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4458	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_ROL_REF_LBL	inherit permissions from 		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4459	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_ROL_REF_TT	inherit permissions from 		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4503	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	Real_LBL	R		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4549	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_COMMENT_LBL	comment		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4550	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_COMMENT_TT	enter as much feedback detail here as required		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4551	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_COMPLETE_LBL	displayed as a checkbox, marks when developer/designer considered the topic addressed		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4552	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_COMPLETE_TT	displayed as a checkbox, marks when developer/designer considered the topic addressed		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4553	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_CWHEN_LBL	created when		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4554	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_CWHEN_TT	created when		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4555	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_FROM_LBL	user name of person making comment		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4556	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_FROM_TT	user name of person making comment		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4557	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4558	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_MBY_TT	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4559	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4560	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4561	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_MWHEN_LBL	modified when		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4562	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_MWHEN_TT	modified when		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4563	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_REPLY_LBL	developers reply to comment		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4564	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_REPLY_TT	developers reply to comment		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4565	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_RESP_DUE_LBL	requested response date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4566	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_RESP_DUE_TT	requested response date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4567	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_RESP_TYPE_LBL	user can request a type of response		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4568	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_RESP_TYPE_TT	user can request a type of response		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4569	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4570	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4571	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_TOPIC_LBL	thread heading		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4572	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_TOPIC_TT	thread heading		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4573	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_TYPE_LBL	type of comment		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4574	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SF_TYPE_TT	type of comment: BUG, ENHANCEMENT, BEHAVIOUR		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4588	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLE_CODE_LBL	primary grouping category		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4589	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLE_CODE_TT	primary grouping category		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4590	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLE_CWHEN_LBL	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4591	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLE_CWHEN_TT	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4592	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLE_MESSAGE_LBL	message		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4593	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLE_MESSAGE_TT	message		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4594	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLE_SUBCODE_LBL	secondary grouping category		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4595	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLE_SUBCODE_TT	secondary grouping category		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4596	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLV_CODE_LBL	primary grouping category		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4597	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLV_CODE_TT	primary grouping category		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4598	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLV_CWHEN_LBL	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4599	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLV_CWHEN_TT	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4600	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLV_MESSAGE_LBL	message		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4601	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLV_MESSAGE_TT	message		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4603	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLV_SUBCODE_TT	secondary grouping category		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4644	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_BROWSER_LBL	appName and userAgent info		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4645	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_BROWSER_TT	appName and userAgent info		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4646	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_COUNT_END_LBL	in anticipation of IP v6		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4647	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_COUNT_END_TT	in anticipation of IP v6		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4648	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_DB_REQUESTS_LBL	total number of DB calls		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4649	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_DB_REQUESTS_TT	total number of DB calls		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4650	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_DELETES_LBL	total number of rows deleted from the DB		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4651	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_DELETES_TT	total number of rows deleted from the DB		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4652	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_DEVICE_SIZE_LBL	screen resolution of device		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4460	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4461	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ROL_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4462	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ROL_USR_ADD	Add user to Role		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4463	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ROL_USR_LIST	Users for selected Role		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4466	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RP_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4467	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RP_CBY_TT	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4468	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RP_CWHEN_LBL	created when		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4469	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RP_CWHEN_TT	created timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4470	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RP_PER_REF_LBL	foreign key to uaPermissions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4471	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RP_PER_REF_TT	foreign key to uaPermissions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4472	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RP_ROL_REF_LBL	foreign key to uaRoles		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4473	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RP_ROL_REF_TT	foreign key to uaRoles		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4474	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RP_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4475	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	RP_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4437	2017-04-27 15:20:51	stevensg	2018-01-18 13:03:00	MOSTYNRS	1	1	\N	ROL_ACTIVE_TT	The role can be deactivated while still assigned to a user.  This is typically a temporary measure to disable the use of a particular function.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4653	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_DEVICE_SIZE_TT	screen resolution of device		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4654	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_FETCHES_LBL	total number of rows fetched from the DB		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4655	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_FETCHES_TT	total number of rows fetched from the DB		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4656	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_GL_REF_LBL	foreign key to geoLookup		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4657	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_GL_REF_TT	foreign key to geoLookup		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4658	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_GO_REF_LBL	group organisation short name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4659	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_GO_REF_TT	group organisation short name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4660	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_INIT_CLASS_LBL	initial class that created task		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4661	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_INIT_CLASS_TT	initial class that created task		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4662	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_INSERTS_LBL	total number of rows inserted into the DB		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4663	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_INSERTS_TT	total number of rows inserted into the DB		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4664	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_IP4_LBL	IP address v4 format		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4665	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_IP4_TT	IP address v4 format		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4666	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4667	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4668	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_TYPE_LBL	(S)tartup Task, (R)emote Task		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4669	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_TYPE_TT	(S)tartup Task, (R)emote Task		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4670	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_ULA_REF_LBL	only applies when user is identified with a login screen.  Won't apply to any public facing forms.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4671	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_ULA_REF_TT	only applies when user is identified with a login screen.  Won't apply to any public facing forms.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4672	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_UPDATES_LBL	total number of rows updated in the DB		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4673	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	STS_UPDATES_TT	total number of rows updated in the DB		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4674	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	SUPPLIER_LBL	supplier		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4675	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	SUPPLIER_TT	full name of the supplier		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4676	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	SUPP_EO_NAME_LBL	supplier's name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4602	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	SLV_SUBCODE_LBL	secondary grouping category		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4677	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	SUPP_EO_NAME_TT	name of the supplier		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4678	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	SUPP_Heading	Suppliers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4679	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	SUPP_Intro	organisations from whom we receive products and eco invoices		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4680	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	SelectFromList_LBL	select from list		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4681	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	SelectFromList_TT	Select the correct line from the list.  You may need to provide text to filter the list first.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4914	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	TabControl_RFL_TT	classification, value, and other metadata\\large text value and valid JSON\\binary data stored with the record\\record creation and modification data (view only)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4915	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	TabControl_RFO_LBL	Name, desc, active, order\\Text & JSON\\Binary data\\Technical		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4907	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	TabControl_GREET_LBL	Hey you!\\tab2\\tab3		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4908	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	TabControl_GREET_TT	greet the planet\\second tab\\third tab		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4892	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	TabControl_EO_LBL	Name and contact information\\Comments\\Technical		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4893	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	TabControl_EO_TT	company name and contact details with shipping and billing addresses and other relevant information\\general comments\\record creation and modification details (view only)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4896	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	TabControl_FOH_LBL	Financial Invoice\\ecoInvoice\\Technical		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4897	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	TabControl_FOH_TT	invoice header information\\ecoInvoice records\\invoice creation and modification details (view only)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4911	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	TabControl_RFG_LBL	Name, desc, active, order\\Text & JSON\\Binary data\\Technical		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4912	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	TabControl_RFG_TT	classification, value, and other metadata\\large text value and valid JSON\\binary data stored with the record\\record creation and modification data (view only)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4913	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	TabControl_RFL_LBL	Name, desc, active, order\\Text & JSON\\Binary data\\Technical		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5050	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_PW_EXPIRES_TT	password expiry date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5052	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_REAL_NAME_TT	user full name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5053	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	USR_ROL_ADD	select role to add to user		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5043	2017-04-27 15:20:51	stevensg	2018-02-08 21:21:00	MOSTYNRS	1	1	\N	USR_MOBILE_LBL	mobile		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5031	2017-04-27 15:20:51	stevensg	2018-02-08 21:21:00	MOSTYNRS	1	1	\N	USR_EXTN_LBL	phone		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5049	2017-04-27 15:20:51	stevensg	2018-02-08 21:21:00	MOSTYNRS	1	1	\N	USR_PW_EXPIRES_LBL	password expires		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5051	2017-04-27 15:20:51	stevensg	2018-02-08 21:21:00	MOSTYNRS	1	1	\N	USR_REAL_NAME_LBL	full name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5047	2017-04-27 15:20:51	stevensg	2018-02-08 21:21:00	MOSTYNRS	1	1	\N	USR_NAME_LBL	login name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5042	2017-04-27 15:20:51	stevensg	2018-02-08 21:22:00	MOSTYNRS	1	1	\N	USR_MCOUNT_TT	number of times record has been modified		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5046	2017-04-27 15:20:51	stevensg	2018-02-08 21:22:00	MOSTYNRS	1	1	\N	USR_MWHEN_TT	timestamp of when record was last modified		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5027	2017-04-27 15:20:51	stevensg	2018-02-08 21:22:00	MOSTYNRS	1	1	\N	USR_CWHEN_LBL	timestamp of when record was created		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5026	2017-04-27 15:20:51	stevensg	2018-02-08 21:23:00	MOSTYNRS	1	1	\N	USR_CBY_TT	person who created this record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5018	2017-04-27 15:20:51	stevensg	2018-04-12 11:40:00	STEVENSG	2	40	\N	USERS_Heading	User management		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5054	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	USR_ROL_LIST	Roles for selected user		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5055	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_SALT_LBL	hash salt		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5056	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_SALT_TT	hash salt for password		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5059	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5338	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_roles	All roles		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5159	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_COSTCENTRE	has a value so DIVISION, PLANT, BUS_UNIT, CATEGORY and PROJECT must be clear		\N	\N	\N	\N	Tiene un valor así que DIVISION, PLANT, BUS_UNIT, CATEGORY y PROJECT deben ser claros	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5174	2017-04-27 15:20:00	stevensg	2018-06-19 04:06:00	MOSTYNRS	2	40	\N	VAL_EMAIL_ILLEGAL_CHAR	illegal character in email		\N	\N	\N	\N	Carácter ilegal en el correo electrónico	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5175	2017-04-27 15:20:00	stevensg	2018-06-19 04:06:00	MOSTYNRS	2	40	\N	VAL_EMAIL_INUSE	The email address is already in use		\N	\N	\N	\N	La dirección de correo electrónico ya está en uso	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5176	2017-04-27 15:20:00	stevensg	2018-06-19 04:06:00	MOSTYNRS	2	40	\N	VAL_EMAIL_MISSING	Email address missing		\N	\N	\N	\N	Falta la dirección de correo electrónico	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5178	2017-04-27 15:20:00	stevensg	2018-06-19 04:06:00	MOSTYNRS	2	40	\N	VAL_EMAIL_SERVERNOTFOUND	Invalid email address		\N	\N	\N	\N	Dirección de correo electrónico no válida	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5206	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_PB_ACTUAL	must be one of A/T/Q		\N	\N	\N	\N	Debe ser uno de A / T / Q	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5225	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_UNASSIGNED	not assigned		\N	\N	\N	\N	no asignado	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5296	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	address_LBL	postal address		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5297	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	address_TT	enter a full postal address		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5314	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	dataTypeMismatch	data type specified and data value provided do not concur		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5315	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_all_tab_classes	All table classes		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5316	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_child_nodelete	Cannot be deleted because the record has children associated with it.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5317	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_components	Components		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5319	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_confirm	Are you sure?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5320	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_cust	customers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5321	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_cust_inv	Customer invoices		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5322	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_del_canc	Deletion cancelled		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5323	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_delete	Delete		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5329	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_orgs	Selected organisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5330	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_other_cat	Other category		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5331	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_periods	accounting periods		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5332	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_permissions	selected Permissions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5333	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_prev_comm	Previous comments		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5376	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ilCountries_TT	select a country from the drop list		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5377	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ilGroupOrgs_TT	assign and deassign accounts to individual organisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5386	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ilSynonyms_LBL	Synonyms		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5387	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ilSynonyms_TT	synonyms with the conversion factor for the currently selected unit of measurement		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5388	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ilUserGroups_LBL	select the organisation you wish to log in under		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5470	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	msg_atLeastOneLine	At least one line must exist in the list.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5473	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	msg_daterangeformat	DD/MM/YYYY - DD/MM/YYYY		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6841	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbMinusAction_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5519	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbCancel_TT	ignore all changes and leave everything as it was		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5529	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbDeleteRow_TT	delete the current record from the list		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5530	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbDelete_TT	Delete current record. A check for dependent records will be done first.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5531	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbDisplayIndicator_LBL	indicators		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5533	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbDropLink_TT	drop the link to this organisation		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5534	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	42	\N	pbDuplicate_TT	Duplicate the current record to create new event based on existing record.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5536	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbEditOrgLink_TT	modify overhead account organisation details		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5538	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbEdit_TT	click here to edit the currently displayed record(s)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5542	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbFeedback_TT	click here to open the feedback form to send to the developers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5543	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbFetch_LBL	fetch		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5574	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbPlusSynonym_TT	create a new synonym for the currently selected unit of measure		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5586	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbReturn_LBL	return		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5587	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbReturn_TT	click here to return to the previous screen		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5589	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbSaveAndContinue_LBL	save		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5590	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbSaveAndContinue_TT	save current changes and go to next tab		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5595	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbSave_LBL	save		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5596	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbSave_TT	any changes you have made in this screen will be saved to the database		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5597	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbSearch_LBL	search		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5598	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbSelect_LBL	Select		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5599	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbSelect_TT	select your chosen organisation above and then click here		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5600	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbSend_LBL	send invoice		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5610	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	plural_f	s		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5611	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	plural_m	s		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5612	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	plural_s	es		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5688	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	sel_class	select class		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5692	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	sel_criteria1	select criteria 1		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5693	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	sel_criteria2	select criteria2		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5694	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	sel_customer	select customer		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5695	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	sel_daterange	select date range		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5697	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	sel_group	select group		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5698	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	sel_org	select organisation		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5700	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	sel_prefix	select prefix		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5703	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	sel_supplier	select supplier		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6269	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_BYTES_REQMAXSENT_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6282	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_SEP_DEC_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6326	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	USR_USR_REF_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6332	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_SEP_DEC_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6343	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_FMT_DATE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6375	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	RFG_MBY_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6509	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	USR_TEAM_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6511	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	ULA_REQUESTS_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6515	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_COUNT_START_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6575	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_CODE_OTHER_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6577	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_METRO_CODE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6601	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LG_NO_OF_SPEAKERS_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6857	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_TOT_EVENTS_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6858	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CFG_SEQ_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6860	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LIB_DESC_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6870	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_START_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6895	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_COL_ORDER_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6898	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_SEP_THOU_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6905	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DB_KEY_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6920	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_ISO3_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6934	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DD_PATH_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6954	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CFG_VALUE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6963	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_EXPIRED_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7061	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_CODE_OTHER_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7078	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_MONEY_SYMB_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7095	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LIB_KEY_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7107	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	AE_FROM_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7111	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_BYTES_REQCURRECD_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7113	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_ISO2_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7128	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_MM_OFFICE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7144	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	TabControl_UOM_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7149	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LG_MBY_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7157	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_CITY_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7158	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	SLE_SERVER_IP_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7162	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CFG_SEQ_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7192	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	USR_ACTIVE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7223	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_SEQ_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7226	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LIB_DESC_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7277	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LIB_SEQ_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7278	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_TIME_ZONE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7285	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_TOT_EVENTS_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7329	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CFG_NO_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7335	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbAddRole_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7341	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_BYTES_REQTOTRECD_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7348	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_OTHER_INFO_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7381	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_CODE_ORIGIN_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7406	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_CODE_ORIGIN_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7407	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	ULA_COMMENT_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7426	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_IMP_FLAGS_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7435	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	RFG_MBY_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7460	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_IMP_FLAGS_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7473	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_OTHER_INFO_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7492	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_REGION_CODE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7515	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_SEQ_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7537	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	ULA_COMMENT_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7541	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	SLE_SERVER_PORT_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7553	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	SLE_VHOST_REF_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7603	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_FMT_DATE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7611	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_NAME_LOCAL_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4916	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	TabControl_RFO_TT	classification, value, and other metadata\\large text value and valid JSON\\binary data stored with the record\\record creation and modification data (view only)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4925	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UGO_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4926	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UGO_CBY_TT	name of user who created this record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4927	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UGO_CWHEN_LBL	creation date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4928	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UGO_CWHEN_TT	creation date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4929	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UGO_GO_REF_LBL	foreign key to entGroupOrganisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4930	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UGO_GO_REF_TT	foreign key to entGroupOrganisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4931	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UGO_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4932	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UGO_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4933	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UGO_USR_REF_LBL	foreign key to uaUsers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4934	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UGO_USR_REF_TT	foreign key to uaUsers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4909	2017-04-27 15:20:51	stevensg	2018-04-30 15:52:00	STEVENSG	2	40	\N	TabControl_PRD_LBL	Product Info\\Internal data\\Technical		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4917	2017-04-27 15:20:51	stevensg	2017-08-10 09:11:00	STEVENSG	1	40	\N	TabControl_USERS_LBL	Roles\\Group Organisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4894	2017-04-27 15:20:51	stevensg	2017-08-10 09:10:00	STEVENSG	1	40	\N	TabControl_FEEDBACK_LBL	Feedback\\Technical		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4895	2017-04-27 15:20:51	stevensg	2017-08-10 09:10:00	STEVENSG	1	40	\N	TabControl_FEEDBACK_TT	feedback details entered\\record creation and modification details (view only)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4900	2017-04-27 15:20:51	stevensg	2017-08-10 09:10:00	STEVENSG	1	40	\N	TabControl_HELP_LBL	Roles\\Group Organisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5339	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_sequences	All sequences		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7661	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_BYTES_REQCURRECD_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7684	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DB_VALUE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7689	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_REGION_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7784	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CFG_KEY_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7799	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbAddAction_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7820	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	UOM_Intro	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7848	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	SLV_VHOST_REF_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7853	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	USR_TEAM_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7877	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	AE_FAIL_STATUS_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7880	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CFG_DESC_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7895	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_LONGITUDE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7898	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_COL_COUNT_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7899	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DB_VALUE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7908	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DB_SEQ_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7915	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_BYTES_REQCURSENT_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7925	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_LAST_RESPONSE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7957	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	USR_STARTDATE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7999	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbPlusRoleUser_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8008	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DB_NO_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8018	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	SLV_SERVER_IP_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8030	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	TabControl_UOM_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4918	2017-04-27 15:20:51	stevensg	2017-08-10 09:11:00	STEVENSG	1	40	\N	TabControl_USERS_TT	list of system roles to which the user belongs\\list of group organisations that the user is a member of		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4910	2017-04-27 15:20:51	stevensg	2018-04-30 15:52:00	STEVENSG	2	40	\N	TabControl_PRD_TT	name, brand and packaging information for the product\\internal product information\\record audit info		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4898	2017-04-27 15:20:51	stevensg	2018-04-10 16:02:00	STEVENSG	1	40	\N	TabControl_GO_LBL	Name and numbers\\EcoCost registration\\Technical		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4935	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_CONNECT_TIME_LBL	set on opening of task		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4936	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_CONNECT_TIME_TT	set on opening of task		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4937	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_DG_REF_LBL	foreign key to delegates (where it exists)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4938	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_DG_REF_TT	foreign key to delegates (where it exists)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4939	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_FORMS_VISITED_LBL	forms used		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4940	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_FORMS_VISITED_TT	forms used		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4941	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_GO_NAME_LBL	group organisation short name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4942	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_GO_NAME_TT	group organisation short name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8059	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_COUNTRY_NAME_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8062	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	SLE_VHOST_REF_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8077	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	SLV_SERVER_PORT_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8081	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_BYTES_REQMAXSENT_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8121	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_BYTES_REQMAXRECD_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8125	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	SLE_SERVER_PORT_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8143	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	ULA_REQUESTS_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8152	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbEdit_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8189	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LG_ISO3_ALT_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8195	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DB_DESC_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8230	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	AE_GO_REF_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8235	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_SEP_THOU_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8246	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_START_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8258	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_IP_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8262	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_LAST_USED_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8283	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_SCHEMA_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8302	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_COL_COUNT_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8319	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DB_SEQ_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8320	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DD_METHOD_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8341	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	RFG_TIME_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8346	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbSend_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8359	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	USR_STARTDATE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8367	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LIB_KEY_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8395	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_BYTES_REQTOTSENT_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8397	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CFG_VALUE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8400	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	SLV_SERVER_PORT_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8403	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	USR_USR_REF_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8418	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	AE_FAIL_STATUS_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8419	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DB_DESC_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8425	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LG_ISO2_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8443	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_LAST_USED_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8453	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_COL_ORDER_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8461	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_COUNT_START_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8480	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	RFG_TIME_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8502	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_SEQ_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8508	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	ULA_LAST_HIT_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4943	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_IP_ADDRESS_LBL	in anticipation of IP v6		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4944	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_IP_ADDRESS_TT	in anticipation of IP v6		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4945	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_LOGIN_LBL	login		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4946	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_LOGIN_TT	time of login		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4947	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_LOGOUT_LBL	logout		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4948	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_LOGOUT_TT	time of logout		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4949	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4950	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4951	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_USR_REF_LBL	foreign key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4952	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	ULA_USR_REF_TT	foreign key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4959	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_ACTIVE_LBL	available for use		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4960	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_ACTIVE_TT	available for use		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4961	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4962	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_CBY_TT	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4963	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_CODE_LBL	unique code		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4964	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_CODE_TT	unique code for the unit, eg. kg, m3, m2		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4965	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_CWHEN_LBL	created		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4966	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_CWHEN_TT	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4967	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_DESC_EN_LBL	description		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4968	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_DESC_EN_TT	description of measurement in English		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4969	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_GROUP_LBL	measurement group		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4970	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_GROUP_TT	grouping of units of measurement, eg. volume, length, area		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8515	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_NAME_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8541	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_IP_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8565	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbBack_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8585	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DD_METHOD_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8586	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_METRO_CODE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8610	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	SLV_SERVER_IP_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8617	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LIB_NAME_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8637	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	SLE_SERVER_IP_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8647	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LG_ISO3_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8649	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CFG_DESC_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8695	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LG_MBY_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8702	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_LAST_RESPONSE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8731	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbDeleteRole_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8735	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	USR_ACTIVE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8738	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_MBY_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8742	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_MBY_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8771	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	AE_FAIL_DIALOGUE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4971	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	UOM_Heading	Units of Measurement		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4972	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4973	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_MBY_TT	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4974	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4975	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4976	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_MWHEN_LBL	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4977	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_MWHEN_TT	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4978	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4979	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOM_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4980	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_ACTIVE_LBL	available for use		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4981	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_ACTIVE_TT	available for use		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4982	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4983	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_CBY_TT	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4984	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_CODE_LBL	unique id		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4985	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_CODE_TT	unique identifier, eg. kg, ml, m2		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4986	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_CWHEN_LBL	created		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4987	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_CWHEN_TT	creation timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4988	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_FACTOR_LBL	conversion factor		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4989	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_FACTOR_TT	multiplier to convert to base unit		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4990	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_FILTER_LBL	filter group		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4991	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_FILTER_TT	filter, eg. metric, imperial, US		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4992	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4993	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_MBY_TT	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4994	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4995	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_MCOUNT_TT	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4996	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_MWHEN_LBL	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4997	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_MWHEN_TT	modification date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4998	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_NAME_EN_LBL	description (english)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8785	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LIB_VALUE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8803	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	AE_FAIL_COUNT_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8819	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_SEQ_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4999	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_NAME_EN_TT	description of the unit in English		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5000	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5001	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5002	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_UOM_REF_LBL	foreign key to sysunitofmeasure		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5003	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UOS_UOM_REF_TT	foreign key to sysunitofmeasure		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5004	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_ACTIVE_LBL	is this User-Role relationship currently active?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5005	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_ACTIVE_TT	is this User-Role relationship currently active?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5006	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5007	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_CBY_TT	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5008	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_CWHEN_LBL	created timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5009	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_CWHEN_TT	created timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5010	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_DEFAULT_LBL	does the user get this role by default?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5011	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_DEFAULT_TT	does the user get this role by default?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5012	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_ROL_REF_LBL	foreign key to uaRoles		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5013	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_ROL_REF_TT	foreign key to uaRoles		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5014	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_SEQ_LBL	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5015	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_SEQ_TT	primary key		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5016	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_USR_REF_LBL	foreign key to uaUsers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5017	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	UR_USR_REF_TT	foreign key to uaUsers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5019	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	USERS_Intro	create new Users, assign roles and group organisations to Users		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5020	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_AC_EXPIRES_LBL	account expiry date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5021	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_AC_EXPIRES_TT	account expiry date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5022	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	USR_ALL_RECORDS	All Users		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5023	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	USR_ASSIGNED_ALL_GROUPORGS	User has been assigned to all Organisations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8832	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbSearch_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8842	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_ACTIVE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8845	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DB_KEY_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8849	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	SLV_VHOST_REF_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8859	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_ZIP_CODE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8865	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbFetch_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5024	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	USR_ASSIGNED_ALL_ROLES	User has been assigned all Roles		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5025	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_CBY_LBL	created by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5028	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_CWHEN_TT	created timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5029	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_EMAIL_LBL	email address		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5030	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_EMAIL_TT	email address		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5032	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_EXTN_TT	internal phone no/extension		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5033	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	USR_GO_ADD	select organisation to add to user		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5034	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	USR_GO_LIST	Group Organisations for selected user		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5036	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_INITIALS_TT	users initials to include in reports		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5037	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_JOB_TITLE_LBL	job title		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5038	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_JOB_TITLE_TT	job title		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5039	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_MBY_LBL	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5040	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_MBY_TT	modified by		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5041	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_MCOUNT_LBL	modification count		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5044	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_MOBILE_TT	mobile phone number		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5045	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_MWHEN_LBL	modified timestamp		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5048	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	1	\N	USR_NAME_TT	user login name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5166	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_DIVISION	has a value so DIVISION, PLANT, BUS_UNIT, CATEGORY and COSTCENTRE must be clear		\N	\N	\N	\N	Tiene un valor así que DIVISION, PLANT, BUS_UNIT, CATEGORY y COSTCENTRE deben ser claros	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5179	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_ERR	validation check		\N	\N	\N	\N	Verificación de validación	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5180	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_EXCLUSIVE	are mutually exclusive		\N	\N	\N	\N	Son mutuamente excluyentes	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5185	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_INVALID	is invalid		\N	\N	\N	\N	es inválido	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5186	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_LABEL_FORMAT	requires an underscore (_)		\N	\N	\N	\N	Requiere un guión bajo (_)	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5188	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_MANDATORY	must be provided		\N	\N	\N	\N	debe ser provisto	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5189	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_MASSEQUALONE	total mass must equal 1		\N	\N	\N	\N	La masa total debe ser igual a 1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5190	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_MAX_100	cannot be greater than 100		\N	\N	\N	\N	No puede ser mayor de 100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5191	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_MISMATCH	mismatch		\N	\N	\N	\N	Incompatibilidad	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5192	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_MISSING	missing		\N	\N	\N	\N	desaparecido	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5194	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_NEGATIVE	cannot be negative		\N	\N	\N	\N	No puede ser negativo	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5196	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	3	\N	VAL_NOT_UNIQUE	is not unique		\N	\N	\N	\N	No es único	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5334	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_prods	Selected products		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5337	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_respond	Please respond		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5289	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	YESTERDAY	yesterday		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5340	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	42	\N	disp_statusChange	change status		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5341	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_subcats	Subcategories		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5342	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_submit_canc	Submission cancelled		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5344	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_substances	Substances		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5345	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_supp	suppliers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5346	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_supp_inv	Supplier invoices		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5347	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_units	Units		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5348	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_users	All users		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5349	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_values	Selected values		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5350	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	email_LBL	email address		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5351	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	email_TT	enter a valid email address		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5352	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	endOfReport	End of report		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5356	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	icCheckPassword_LBL	confirm new password		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5357	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	icCheckPassword_TT	reenter the new password		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5358	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	icNewPassword_LBL	new password		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5359	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	icNewPassword_TT	enter the new password for this user		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5364	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	icReactionString_LBL	formula		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5365	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	icReactionString_TT	the chemical reaction used in the calculation		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5374	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ilChains_TT	list of chained invoices, click to display		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5375	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ilCountries_LBL	country		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5475	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	msg_del_desc	Are you sure you want to delete this description?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5476	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	msg_del_detail	Are you sure you want to delete this detail line?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5484	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	msg_enterdates	Please enter the date range separated by a -.   A single date will fetch for that date.   A single date followed or preceded by a - will fetch records starting or ending with that date, respectively.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5485	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	msg_invaliddate	is not a valid date.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5503	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbAddLink_LBL			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5486	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	msg_invaliddaterange	The end date must be equal to or later than the start date.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5487	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	msg_promptnumberofunits	Please enter the number of units required.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5498	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbAddAction_TT	add a new line to the list		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5499	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbAddCode_TT	insert a new code above selected line		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5502	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbAddInput_TXT	+		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5504	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbAddLink_TT	add a link this organisation		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5508	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbAddRow_TT	add a new record to the end of the list		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5509	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbAddRule_TT	insert a new rule above the selected line		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5510	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbAddToInvoice_LBL	add to invoice		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5511	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbAdd_TT	create a new entry		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5512	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbBack_LBL	back		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5518	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbCancel_LBL	cancel		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5550	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbInsert_TT	Create a new record by clicking here.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5532	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbDropLink_LBL			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5552	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbMinusAction_TT	remove the currently selected line from the list		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5539	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbExit_LBL			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5541	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbFeedback_LBL			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5613	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	plural_v	ies		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5540	2017-04-27 15:20:51	stevensg	2018-04-10 16:03:00	STEVENSG	1	40	\N	pbExit_TT	click here to close the EcoCost application		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5556	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbMinusSynonym_TT	delete the currently selected synonym (blocked if the synonym has been used)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5561	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbMoveRowDown_TT	move the current record down one row in the list		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5558	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbMinusUserGroupOrg_TT			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5562	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbMoveRowUp_TT	move the current record up one row in the list		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5569	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbOK_LBL	ok		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5570	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbOK_TT	you are acknowledging this message		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5926	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LG_SEQ_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5571	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbPlusPeriod_TT	create a new accounting period based on the latest period in the list		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5572	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbPlusPermission_TT	create a new permission		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5573	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbPlusRolePermission_TT	assign the currently selected permission to a role		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5559	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbMinusUserRole_LBL			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5560	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbMinusUserRole_TT			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5575	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbPlusUserGroupOrg_TT			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5576	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbPlusUserRole_LBL			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5564	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbNextEntry_LBL	next		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5621	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	postcode_LBL	postcode		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5622	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	postcode_TT	enter a valid postcode		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5577	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbPlusUserRole_TT			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5623	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	3	\N	recordsListed	records listed		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5606	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbToClipboard_LBL			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5634	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	rm_Discard	Discard changes to this list		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5657	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	rm_Refresh	Refresh		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5676	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	rm_shiftActionLine+1_	con('shuffle this ',lcWhichAction,' +1 line')		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5607	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbToClipboard_TT			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5677	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	rm_shiftActionLine+2_	con('shuffle this ',lcWhichAction,' +2 line')		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5678	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	rm_shiftActionLine-1_	con('shuffle this ',lcWhichAction,' -1 line')		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5679	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	rm_shiftActionLine-2_	con('shuffle this ',lcWhichAction,' -2 line')		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5680	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	rm_shiftStep+1	shuffle step +1		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5681	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	rm_shiftStep+2	shuffle step +2		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5682	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	rm_shiftStep-1	shuffle step -1		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5683	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	rm_shiftStep-2	shuffle step -2		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5704	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	42	\N	sel_variousCriteria	various criteria		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5795	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	word_at	at		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5799	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	word_date	date		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5808	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	word_of	of		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5810	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	word_on	on		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5813	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	word_pane	pane		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5814	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	word_record	record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5825	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_COUNTRY_NAME_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5854	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	AE_FAIL_COUNT_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5856	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LG_DESC_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5807	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	word_missing	missing		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5873	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_TIME_ZONE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5875	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_LONGITUDE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5898	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LG_ACTIVE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5934	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	ULA_LAST_HIT_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5935	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LG_ENDONYM_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5979	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	RFU_JSON_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5988	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_END_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5996	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_CITY_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6023	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_COUNTRY_CODE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6033	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	HELP_Intro_8	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6056	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_BYTES_REQMAXRECD_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6071	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_NAME_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6106	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_REGION_NAME_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6109	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_SEQ_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6115	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_LATITUDE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6131	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_REGION_CODE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6231	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	TabControl_HELP_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6283	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_END_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6618	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_REGION_NAME_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6632	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DB_NO_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6640	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	42	\N	pbDuplicate_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6663	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbDisplayIndicator_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6688	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_NAME_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6723	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_REGION_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6731	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbHelpNext_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6761	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_BYTES_REQTOTRECD_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6764	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	RFG_JSON_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6786	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbAddToInvoice_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6835	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LIB_NAME_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6846	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_MBY_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6852	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LIB_VALUE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7602	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_LANGS_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8671	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_LATITUDE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8866	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LG_DESC_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8893	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbPlusUserGroupOrg_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8932	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	IMT_SCHEMA_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8939	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_ZIP_CODE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8971	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CO_SEQ_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
8989	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	DD_PATH_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9045	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CFG_KEY_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9057	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_BYTES_REQCURSENT_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9062	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	40	\N	pbHelpPrevious_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9081	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	LIB_SEQ_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9085	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	CFG_NO_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9136	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	AE_FAIL_DIALOGUE_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9175	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_EXPIRED_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9198	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	STS_BYTES_REQTOTSENT_TT	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9237	2017-04-27 15:34:48	stevensg	2017-04-27 15:34:48	stevensg	0	1	\N	GL_COUNTRY_CODE_LBL	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9939	2018-10-23 10:20:00	STEVENSG	2018-10-23 10:20:00	STEVENSG	1	3	\N	MSG_MISSINGCONAME	company name missing		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9940	2018-10-23 10:20:00	STEVENSG	2018-10-23 10:20:00	STEVENSG	1	3	\N	MSG_MISSINGFINACCTID	finacial accounting ID missing		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9488	2018-01-15 11:27:00	STEVENSG	2018-01-15 11:32:00	STEVENSG	1	40	\N	TabControl_Access_TT	create and modify user accounts and system access\\create/assign business roles\\create database access permissions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9476	2018-01-08 11:53:00	STEVENSG	2018-01-26 14:49:00	STEVENSG	4	48	\N	FORM_GLATTR	Units of Measure, etc.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9493	2018-01-18 11:33:00	MOSTYNRS	2018-01-18 11:33:00	MOSTYNRS	1	40	\N	text_search	text search		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9496	2018-01-18 11:52:00	MOSTYNRS	2018-01-18 11:53:00	MOSTYNRS	1	3	\N	inconsistent_su	Inconsistent restriction		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9499	2018-01-18 11:56:00	MOSTYNRS	2018-01-18 11:57:00	MOSTYNRS	1	1	\N	ROL_SU_LBL	restricted		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9380	2017-08-16 11:07:00	STEVENSG	2017-08-16 11:07:00	STEVENSG	1	3	\N	MSG_INVALIDUOM	invalid unit of measure		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9501	2018-01-18 11:56:00	MOSTYNRS	2018-01-18 11:57:00	MOSTYNRS	1	1	\N	USR_SU_LBL	restricted		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9502	2018-01-18 11:56:00	MOSTYNRS	2018-01-18 11:58:00	MOSTYNRS	1	1	\N	USR_SU_TT	Restricted users are limited to restricted roles and restricted roles are limted to restricted permissions.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9498	2018-01-18 11:56:00	MOSTYNRS	2018-01-18 11:58:00	MOSTYNRS	1	1	\N	PER_SU_TT	Restricted users are limited to restricted roles and restricted roles are limted to restricted permissions.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9500	2018-01-18 11:56:00	MOSTYNRS	2018-01-18 11:58:00	MOSTYNRS	1	1	\N	ROL_SU_TT	Restricted users are limited to restricted roles and restricted roles are limted to restricted permissions.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9503	2018-01-19 14:50:00	MOSTYNRS	2018-01-19 14:50:00	MOSTYNRS	1	40	\N	TabControl_Ref_LBL	Prefs\\Organisation\\Site\\Global		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9504	2018-01-19 14:50:00	MOSTYNRS	2018-01-19 14:52:00	MOSTYNRS	1	40	\N	TabControl_Ref_TT	User preferences\\Company specific values\\Site specific values applicable to all businesses in this installation\\Standard values applicable to every site		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9506	2018-01-26 11:49:00	MOSTYNRS	2018-01-26 11:50:00	MOSTYNRS	2	40	\N	TabControl_Interact_LBL	Group company\\Suppliers\\Customers\\Products\\Invoicing		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9507	2018-01-26 11:49:00	MOSTYNRS	2018-01-26 11:53:00	MOSTYNRS	1	40	\N	TabControl_Interact_TT	Internal group companies\\Organisations from whom we purchase things\\Organisations to whom we sell things\\The items we sell\\Financial invoices		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9509	2018-02-08 14:31:00	MOSTYNRS	2018-02-08 14:31:00	MOSTYNRS	1	3	\N	REC_UPDATED	Record has been updated.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9510	2018-02-08 14:31:00	MOSTYNRS	2018-02-08 14:31:00	MOSTYNRS	1	3	\N	REC_INSERTED	Record has been inserted.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9511	2018-02-08 14:31:00	MOSTYNRS	2018-02-08 14:32:00	MOSTYNRS	1	3	\N	REC_NOCHANGE	The record has not been altered so no changes made.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9512	2018-02-08 14:32:00	MOSTYNRS	2018-02-08 14:32:00	MOSTYNRS	1	3	\N	REC_CANC	Changes have been discarded.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9252	2017-05-04 12:18:00	STEVENSG	2017-05-04 12:18:00	STEVENSG	1	1	\N	STS_TABLE_METHOD	table class method name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9253	2017-05-04 12:18:00	STEVENSG	2017-05-04 12:18:00	STEVENSG	1	1	\N	STS_PARAMS_LBL	web service parameters in JSON format		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9254	2017-05-04 12:18:00	STEVENSG	2017-05-04 12:18:00	STEVENSG	1	1	\N	STS_PARAMS_TT	web service parameters in JSON format		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9247	2017-05-04 12:17:00	STEVENSG	2017-05-04 12:17:00	STEVENSG	1	1	\N	STS_WS_NAME_LBL	web service name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9248	2017-05-04 12:17:00	STEVENSG	2017-05-04 12:17:00	STEVENSG	1	1	\N	STS_WS_NAME_TT	web service name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9249	2017-05-04 12:17:00	STEVENSG	2017-05-04 12:17:00	STEVENSG	1	1	\N	STS_TABLE_NAME_LBL	table class name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9250	2017-05-04 12:18:00	STEVENSG	2017-05-04 12:18:00	STEVENSG	1	1	\N	STS_TABLE_NAME_TT	table class name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9251	2017-05-04 12:18:00	STEVENSG	2017-05-04 12:18:00	STEVENSG	1	1	\N	STS_TABLE_METHOD_LBL	table class method name		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2003	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	3	48	\N	FORM_REPORT	Reports		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2005	2017-04-27 15:20:51	stevensg	2017-05-10 13:44:00	MOSTYNRS	1	48	\N	FORM_RFG	Global configuration		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4251	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	1	\N	RFG_EFFECTIVE_LBL	valid from		\N	\N	\N	\N	válida desde	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4253	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	1	\N	RFG_EXPIRES_LBL	valid to		\N	\N	\N	\N	válido hasta	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4290	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	1	\N	RFL_EFFECTIVE_LBL	valid from date		\N	\N	\N	\N	Válido desde la fecha	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4334	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	1	\N	RFO_EFFECTIVE_LBL	valid from date		\N	\N	\N	\N	Válido desde la fecha	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4380	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	1	\N	RFU_EFFECTIVE_LBL	valid from date		\N	\N	\N	\N	Válido desde la fecha	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4381	2017-04-27 15:20:00	stevensg	2017-05-11 16:23:00	STEVENSG	1	1	\N	RFU_EFFECTIVE_TT	valid from date		\N	\N	\N	\N	Válido desde la fecha	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5177	2017-04-27 15:20:00	stevensg	2018-06-19 04:06:00	MOSTYNRS	2	40	\N	VAL_EMAIL_NOT_RECOGNISED	email not recognised		\N	\N	\N	\N	Email no reconocido	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9362	2017-07-05 13:06:00	STEVENSG	2017-07-05 13:06:00	STEVENSG	1	3	\N	MSG_SELFREFERENCE	this record cannot reference itself		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9373	2017-07-28 16:58:00	STEVENSG	2017-07-28 16:58:00	STEVENSG	1	3	\N	MSG_INSERTFAILED	unable to insert the record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9513	2018-02-08 14:45:00	MOSTYNRS	2018-02-08 14:46:00	MOSTYNRS	1	3	\N	not_authorised	You are not authorised to perform this function.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9514	2018-02-08 15:04:00	MOSTYNRS	2018-02-08 15:05:00	MOSTYNRS	1	3	\N	REC_INSERT	You are inserting a new record.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9515	2018-02-08 15:05:00	MOSTYNRS	2018-02-08 15:05:00	MOSTYNRS	1	3	\N	REC_UPDATE	You are editing an existing record.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9516	2018-02-08 20:59:00	MOSTYNRS	2018-02-08 21:00:00	MOSTYNRS	1	3	\N	REC_DELETED	Record has been deleted.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9363	2017-07-18 11:01:00	STEVENSG	2017-07-18 11:15:00	STEVENSG	6	3	,fr,	MSG_MISSINGTOADDRESS	"to" address missing		\N	\N	\N	\N	"To" address missing	\N	"An" Adresse fehlt	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5035	2017-04-27 15:20:51	stevensg	2018-02-08 21:20:00	MOSTYNRS	1	1	\N	USR_INITIALS_LBL	initials		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9517	2018-02-13 08:35:00	MOSTYNRS	2018-02-13 08:36:00	MOSTYNRS	1	40	\N	TabControl_Logs_LBL	Events\\Errors\\Async. email queue		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9518	2018-02-13 08:36:00	MOSTYNRS	2018-02-13 08:38:00	MOSTYNRS	1	40	\N	TabControl_Logs_TT	Log of system events\\Log of system errors\\Asyncronous email queue - messages waiting to be sent via email.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9519	2018-02-16 12:32:00	STEVENSG	2018-02-16 12:33:00	STEVENSG	2	40	\N	TabControl_ROLES_LBL	Permissions\\Users		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9520	2018-02-16 12:33:00	STEVENSG	2018-02-16 12:36:00	STEVENSG	2	40	\N	TabControl_ROLES_TT	lists of permissions granted to and revoked from the selected role\\users who have or can be granted the selected role		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9360	2017-06-16 12:07:00	STEVENSG	2017-06-16 12:07:00	STEVENSG	1	40	\N	cb_ReportErrors	Report errors, do not abort import		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4899	2017-04-27 15:20:51	stevensg	2018-04-10 16:02:00	STEVENSG	2	40	\N	TabControl_GO_TT	organisation(s) making up this company group\\view, edit and save EcoCost registration details\\creation and modification details (view only)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9391	2017-09-06 12:23:00	STEVENSG	2017-09-06 12:23:00	STEVENSG	1	40	\N	Imports_LBL	import(s)		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9415	2017-12-18 15:16:00	STEVENSG	2017-12-18 15:17:00	STEVENSG	1	3	\N	ERR_NODEL_LAST	last record cannot be removed		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5313	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	ct_dateentry	DD/MM/YY		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5318	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_comps	selected composites		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5343	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	disp_submit_success	Submission successful.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9534	2018-03-09 12:10:00	MOSTYNRS	2018-03-09 12:11:00	MOSTYNRS	1	40	\N	SCREEN_TOO_SMALL	This form is not compatible with this screen size. Please rotate your device or expand your browser window.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9548	2018-03-14 11:05:00	MOSTYNRS	2018-03-14 12:44:00	MOSTYNRS	2	52	\N	FACT_UPDR_D	Modify the current record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9546	2018-03-14 11:04:00	MOSTYNRS	2018-03-14 12:43:00	MOSTYNRS	2	52	\N	FACT_INSR_D	Create a new record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9505	2018-01-25 15:25:00	STEVENSG	2018-04-12 11:45:00	STEVENSG	2	40	\N	NAVMENU_CASCADE	Select an option:		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9543	2018-03-14 10:53:00	STEVENSG	2018-03-14 10:53:00	STEVENSG	1	40	\N	TabControl_Invoicing_LBL	Financial invoices\\ecoInvoices sent\\ecoInvoices received		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9544	2018-03-14 10:54:00	STEVENSG	2018-03-14 10:55:00	STEVENSG	1	40	\N	TabControl_Invoicing_TT	create and edit customer invoices and submit them for ecoInvoice despatch\\view ecoInvoices despatched to customers\\view ecoInvoices received from suppliers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9555	2018-03-14 11:07:00	MOSTYNRS	2018-03-14 11:07:00	MOSTYNRS	1	52	\N	FACT_ZZZ	ZZZ		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9547	2018-03-14 11:05:00	MOSTYNRS	2018-03-14 12:43:00	MOSTYNRS	2	52	\N	FACT_UPDR	Edit record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9549	2018-03-14 11:05:00	MOSTYNRS	2018-03-14 11:06:00	MOSTYNRS	1	52	\N	FACT_DELR	Delete record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9550	2018-03-14 11:06:00	MOSTYNRS	2018-03-14 11:06:00	MOSTYNRS	1	52	\N	FACT_DELR_D	Permanently remove the current record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9551	2018-03-14 11:06:00	MOSTYNRS	2018-03-14 11:06:00	MOSTYNRS	1	52	\N	FACT_XXX	XXX		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9552	2018-03-14 11:06:00	MOSTYNRS	2018-03-14 11:06:00	MOSTYNRS	2	52	\N	FACT_XXX_D	Apply the XXX action		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9553	2018-03-14 11:07:00	MOSTYNRS	2018-03-14 11:07:00	MOSTYNRS	1	52	\N	FACT_YYY	YYY		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9554	2018-03-14 11:07:00	MOSTYNRS	2018-03-14 11:07:00	MOSTYNRS	1	52	\N	FACT_YYY_D	Apply the YYY action		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9556	2018-03-14 11:07:00	MOSTYNRS	2018-03-14 11:07:00	MOSTYNRS	1	52	\N	FACT_ZZZ_D	Apply the ZZZ action		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9557	2018-03-14 11:08:00	MOSTYNRS	2018-03-14 11:08:00	MOSTYNRS	1	52	\N	FACT_PRINT	Print		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9558	2018-03-14 11:08:00	MOSTYNRS	2018-03-14 11:09:00	MOSTYNRS	1	52	\N	FACT_PRINT_D	Print the current record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9559	2018-03-14 12:10:00	STEVENSG	2018-03-14 12:10:00	STEVENSG	1	40	\N	word_to	to		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9560	2018-03-14 12:42:00	MOSTYNRS	2018-03-14 12:42:00	MOSTYNRS	1	52	\N	FACT_DUP	Duplicate		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9561	2018-03-14 12:42:00	MOSTYNRS	2018-03-14 12:43:00	MOSTYNRS	1	52	\N	FACT_DUP_D	Clone this record and modify		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9545	2018-03-14 11:04:00	MOSTYNRS	2018-03-14 12:43:00	MOSTYNRS	3	52	\N	FACT_INSR	Insert record		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9924	2018-08-13 12:24:00	MOSTYNRS	2018-08-13 12:25:00	MOSTYNRS	1	40	\N	ilNow_TT	You are working on the selected line in this list.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9925	2018-08-13 12:25:00	MOSTYNRS	2018-08-13 12:25:00	MOSTYNRS	1	40	\N	ilPrevious_LBL	Parent		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9926	2018-08-13 12:25:00	MOSTYNRS	2018-08-13 12:25:00	MOSTYNRS	1	40	\N	ilPrevious_TT	These are the superior records in the company structure.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9935	2018-10-22 13:41:00	STEVENSG	2018-10-22 13:41:00	STEVENSG	1	52	\N	FACT_IMP_SUPP	Import suppliers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9936	2018-10-22 13:41:00	STEVENSG	2018-10-22 13:42:00	STEVENSG	1	52	\N	FACT_IMP_SUPP_D	Import supplier information from text/xls file		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9937	2018-10-22 15:59:00	STEVENSG	2018-10-22 15:59:00	STEVENSG	1	52	\N	FACT_IMP_CUST	Import customers		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9938	2018-10-22 15:59:00	STEVENSG	2018-10-22 16:00:00	STEVENSG	1	52	\N	FACT_IMP_CUST_D	Import customer records from atext/xls file		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5557	2017-04-27 15:20:51	stevensg	2017-09-20 15:13:00	STEVENSG	1	40	\N	pbMinusUserGroupOrg_LBL			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5366	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	icTextSearchInput_LBL	search text		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5367	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	icTextSearchInput_TT	Text entered here will be used to filter input options according to the input source specified.  Use % as a wild card.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5368	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	icTextSearchOutput_LBL	search output		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5369	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	icTextSearchOutput_TT	Text entered here will be used to filter the output options.  Use % as a wild card		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5472	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	msg_clear_qty	Changing to a quote will clear all quantities and prices.  Continue?		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5482	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	msg_emptyenddate	period end date cannot be empty		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5483	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	msg_emptystartdate	period start date cannot be empty		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5565	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbNextEntry_TT	go to the next line in the list of entries, disabled when the last line is displayed		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5578	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbPreviousEntry_LBL	previous		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5579	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	pbPreviousEntry_TT	go to the previous line in the list of entries, disabled when the first line is displayed		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5811	2017-04-27 15:20:51	stevensg	2017-04-27 15:20:51	stevensg	0	40	\N	word_outofrange	out of range		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9478	2018-01-08 11:54:00	STEVENSG	2018-02-07 10:41:00	STEVENSG	2	48	\N	FORM_CFG	System configuration		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9489	2018-01-15 14:24:00	STEVENSG	2018-04-12 11:45:00	STEVENSG	4	40	\N	NAVMENU_CONFIG	Configuration		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9470	2018-01-08 11:51:00	STEVENSG	2018-01-30 10:41:00	STEVENSG	4	48	\N	FORM_INVOICING	Invoicing		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9486	2018-01-12 15:09:00	STEVENSG	2018-01-12 15:09:00	STEVENSG	1	3	\N	MSG_WARN_SMALLSCREEN	This form is not compatible with this screen size.  Please rotate your device or expand your browser window.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9479	2018-01-08 11:55:00	STEVENSG	2018-02-28 10:21:00	STEVENSG	4	48	\N	FORM_ACCESS	Access permissions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9487	2018-01-15 11:27:00	STEVENSG	2018-01-15 11:36:00	STEVENSG	2	40	\N	TabControl_Access_LBL	Users\\Roles\\Permissions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9492	2018-01-15 14:27:00	STEVENSG	2018-04-12 11:45:00	STEVENSG	3	40	\N	NAVMENU_DATA	Functions		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9472	2018-01-08 11:52:00	STEVENSG	2018-01-26 14:50:00	STEVENSG	2	48	\N	FORM_ORGS	Business setup		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9477	2018-01-08 11:54:00	STEVENSG	2018-01-26 09:39:00	STEVENSG	4	48	\N	FORM_USERINPUT	Send feedback		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9471	2018-01-08 11:51:00	STEVENSG	2018-01-26 09:39:00	STEVENSG	4	48	\N	FORM_BUSCFG	Business configurations		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9491	2018-01-15 14:26:00	STEVENSG	2018-04-12 11:45:00	STEVENSG	4	40	\N	NAVMENU_ORGS	Work in Progress		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9495	2018-01-18 11:38:00	MOSTYNRS	2018-01-18 11:40:00	MOSTYNRS	1	40	\N	text_search_TT	Text entered here will be searched for broadly.  Use text% to search from beginning, use %text to search from end.  Default is search anywhere.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9494	2018-01-18 11:38:00	MOSTYNRS	2018-01-18 11:40:00	MOSTYNRS	2	40	\N	text_search_LBL	search text		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9497	2018-01-18 11:56:00	MOSTYNRS	2018-01-18 11:57:00	MOSTYNRS	1	1	\N	PER_SU_LBL	restricted		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1802	2017-04-27 15:20:51	stevensg	2018-04-10 16:02:00	STEVENSG	1	1	\N	EO_MEC_ID_TT	Unique code identifying this company within the EcoCost network.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2083	2017-04-27 15:20:51	stevensg	2018-04-10 16:02:00	STEVENSG	1	1	\N	GO_DDN_AP1_LBL	EcoCost Access point 1		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2085	2017-04-27 15:20:51	stevensg	2018-04-10 16:02:00	STEVENSG	1	1	\N	GO_DDN_AP2_LBL	EcoCost Access point 2		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9756	2018-04-12 17:21:00	STEVENSG	2018-04-12 17:22:00	STEVENSG	1	52	\N	FACT_UPDLINK_D	Modify the selected link		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9758	2018-04-12 17:22:00	STEVENSG	2018-04-12 17:22:00	STEVENSG	1	52	\N	FACT_DELLINK_D	Delete the selected link		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9757	2018-04-12 17:22:00	STEVENSG	2018-04-12 17:22:00	STEVENSG	2	52	\N	FACT_DELLINK	Delete		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9755	2018-04-12 17:20:00	STEVENSG	2018-04-12 17:23:00	STEVENSG	2	52	\N	FACT_UPDLINK	Modify		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9766	2018-04-13 10:11:00	STEVENSG	2018-04-13 10:14:00	STEVENSG	2	52	\N	FACT_SPACER_D	---------------------		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9768	2018-04-13 10:57:00	STEVENSG	2018-04-13 10:57:00	STEVENSG	1	52	\N	FACT_PRINTREP	Print		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9769	2018-04-13 10:58:00	STEVENSG	2018-04-13 10:58:00	STEVENSG	1	52	\N	FACT_PRINTREP_D	Print the selected report		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9789	2018-04-20 12:04:00	STEVENSG	2018-04-20 12:04:00	STEVENSG	1	42	\N	disp_venues	All venues		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9791	2018-04-20 14:36:00	STEVENSG	2018-04-20 14:36:00	STEVENSG	1	42	\N	disp_attendees	All attendees		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9792	2018-04-23 09:40:00	STEVENSG	2018-04-23 09:40:00	STEVENSG	1	42	\N	disp_certs	Selected certificates		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9845	2018-05-21 14:22:00	STEVENSG	2018-05-21 14:22:00	STEVENSG	1	40	\N	word_ignore	ignore		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9846	2018-05-21 14:22:00	STEVENSG	2018-05-21 14:23:00	STEVENSG	2	40	\N	word_rows	rows		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9854	2018-06-13 16:30:00	MOSTYNRS	2018-06-13 16:31:00	MOSTYNRS	1	3	\N	max_opt_exceeded	You have exceeded the maximum allowed.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9855	2018-06-13 16:31:00	MOSTYNRS	2018-06-13 16:31:00	MOSTYNRS	1	3	\N	max_opt_reached	You have reached the maximum number of options allowed.		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5173	2017-04-27 15:20:00	stevensg	2018-06-19 04:06:00	MOSTYNRS	2	40	\N	VAL_EMAIL_BADFORMAT	Invalid email address format		\N	\N	\N	\N	Formato de dirección de correo electrónico no válido	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5172	2017-04-27 15:20:00	stevensg	2018-06-19 04:06:00	MOSTYNRS	2	40	\N	VAL_EMAILANDPASSWORD_NOT_RECOGNISED	email and password not recognised		\N	\N	\N	\N	Correo electrónico y contraseña no reconocidos	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9886	2018-06-19 09:23:00	MOSTYNRS	2018-06-19 09:24:00	MOSTYNRS	1	40	\N	word_printed	Printed:		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9765	2018-04-13 10:10:00	STEVENSG	2018-04-13 10:12:00	STEVENSG	2	52	\N	FACT_SPACER			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9889	2018-07-09 12:03:00	STEVENSG	2018-07-09 12:03:00	STEVENSG	1	40	\N	word_show	show		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9890	2018-07-09 12:03:00	STEVENSG	2018-07-09 12:03:00	STEVENSG	1	40	\N	word_hide	hide		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9923	2018-08-13 12:24:00	MOSTYNRS	2018-08-13 12:24:00	MOSTYNRS	1	40	\N	ilNow_LBL	Current		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
9786	2018-04-17 16:19:00	STEVENSG	2018-04-17 16:19:00	STEVENSG	1	48	\N	FORM_START	Greetings		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Name: entgrouporganisations_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.entgrouporganisations_seq', 2, true);


--
-- Name: entgrouporgnames_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.entgrouporgnames_seq', 2, true);


--
-- Name: sysasyncemails_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysasyncemails_seq', 46, true);


--
-- Name: sysreferenceglobal_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysreferenceglobal_seq', 2, true);


--
-- Name: sysreferencelocal_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysreferencelocal_seq', 1, false);


--
-- Name: sysreferenceorg_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysreferenceorg_seq', 1, false);


--
-- Name: sysreferenceuser_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.sysreferenceuser_seq', 1, true);


--
-- Name: systaskstats_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.systaskstats_seq', 1, false);


--
-- Name: uagrouporglinks_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.uagrouporglinks_seq', 4, true);


--
-- Name: ualogaccess_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.ualogaccess_seq', 1, false);


--
-- Name: uausers_seq; Type: SEQUENCE SET; Schema: infra; Owner: _developer
--

SELECT pg_catalog.setval('infra.uausers_seq', 3, true);


--
-- Name: omgroup_seq; Type: SEQUENCE SET; Schema: translate; Owner: _developer
--

SELECT pg_catalog.setval('translate.omgroup_seq', 57, true);


--
-- Name: omlibgrouplinks_seq; Type: SEQUENCE SET; Schema: translate; Owner: _developer
--

SELECT pg_catalog.setval('translate.omlibgrouplinks_seq', 140, true);


--
-- Name: omlibrary_seq; Type: SEQUENCE SET; Schema: translate; Owner: _developer
--

SELECT pg_catalog.setval('translate.omlibrary_seq', 18, true);


--
-- Name: omstrings_seq; Type: SEQUENCE SET; Schema: translate; Owner: _developer
--

SELECT pg_catalog.setval('translate.omstrings_seq', 9956, true);


--
-- Name: entgrouporganisations entgrouporganisations_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporganisations
    ADD CONSTRAINT entgrouporganisations_pkey PRIMARY KEY (go_seq);


--
-- Name: entgrouporgnames entgrouporgnames_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporgnames
    ADD CONSTRAINT entgrouporgnames_pkey PRIMARY KEY (gon_seq);


--
-- Name: entgrouporganisations go_mec_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporganisations
    ADD CONSTRAINT go_mec_ukey UNIQUE (go_mec_id);


--
-- Name: entgrouporganisations go_name_short_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporganisations
    ADD CONSTRAINT go_name_short_ukey UNIQUE (go_name_short);


--
-- Name: entgrouporgnames gon_name_full_uk; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporgnames
    ADD CONSTRAINT gon_name_full_uk UNIQUE (gon_name_full);


--
-- Name: entgrouporgnames gon_ukey2; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporgnames
    ADD CONSTRAINT gon_ukey2 UNIQUE (gon_type, gon_name_full);


--
-- Name: sysreferenceglobal rfg_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceglobal
    ADD CONSTRAINT rfg_ukey UNIQUE (rfg_class, rfg_value);


--
-- Name: sysreferencelocal rfl_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferencelocal
    ADD CONSTRAINT rfl_ukey UNIQUE (rfl_class, rfl_value);


--
-- Name: sysreferenceorg rfo_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceorg
    ADD CONSTRAINT rfo_ukey UNIQUE (rfo_go_ref, rfo_class, rfo_value);


--
-- Name: sysreferenceuser rfu_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceuser
    ADD CONSTRAINT rfu_ukey UNIQUE (rfu_go_ref, rfu_usr_ref, rfu_class, rfu_value);


--
-- Name: sysasyncemails sysasyncemails_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysasyncemails
    ADD CONSTRAINT sysasyncemails_pkey PRIMARY KEY (ae_seq);


--
-- Name: sysreferenceglobal sysreferenceglobal_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceglobal
    ADD CONSTRAINT sysreferenceglobal_pkey PRIMARY KEY (rfg_seq);


--
-- Name: sysreferencelocal sysreferencelocal_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferencelocal
    ADD CONSTRAINT sysreferencelocal_pkey PRIMARY KEY (rfl_seq);


--
-- Name: sysreferenceorg sysreferenceorg_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceorg
    ADD CONSTRAINT sysreferenceorg_pkey PRIMARY KEY (rfo_seq);


--
-- Name: sysreferenceuser sysreferenceuser_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceuser
    ADD CONSTRAINT sysreferenceuser_pkey PRIMARY KEY (rfu_seq);


--
-- Name: systaskstats systaskstats_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.systaskstats
    ADD CONSTRAINT systaskstats_pkey PRIMARY KEY (sts_seq);


--
-- Name: uagrouporglinks uagrouporglinks_pkey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uagrouporglinks
    ADD CONSTRAINT uagrouporglinks_pkey PRIMARY KEY (ugo_seq);


--
-- Name: uagrouporglinks ugo_ukey; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uagrouporglinks
    ADD CONSTRAINT ugo_ukey UNIQUE (ugo_go_ref, ugo_usr_ref);


--
-- Name: ualogaccess ula_seq; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.ualogaccess
    ADD CONSTRAINT ula_seq PRIMARY KEY (ula_seq);


--
-- Name: uausers usr_seq; Type: CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uausers
    ADD CONSTRAINT usr_seq PRIMARY KEY (usr_seq);


--
-- Name: omgroup omgroup_pkey; Type: CONSTRAINT; Schema: translate; Owner: _developer
--

ALTER TABLE ONLY translate.omgroup
    ADD CONSTRAINT omgroup_pkey PRIMARY KEY (omg_seq);


--
-- Name: omlibgrouplinks omlibgrouplinks_pkey; Type: CONSTRAINT; Schema: translate; Owner: _developer
--

ALTER TABLE ONLY translate.omlibgrouplinks
    ADD CONSTRAINT omlibgrouplinks_pkey PRIMARY KEY (olg_seq);


--
-- Name: omlibrary omlibrary_pkey; Type: CONSTRAINT; Schema: translate; Owner: _developer
--

ALTER TABLE ONLY translate.omlibrary
    ADD CONSTRAINT omlibrary_pkey PRIMARY KEY (oml_seq);


--
-- Name: omstrings omstrings_pkey; Type: CONSTRAINT; Schema: translate; Owner: _developer
--

ALTER TABLE ONLY translate.omstrings
    ADD CONSTRAINT omstrings_pkey PRIMARY KEY (oms_seq);


--
-- Name: omstrings omstrings_stringid_key; Type: CONSTRAINT; Schema: translate; Owner: _developer
--

ALTER TABLE ONLY translate.omstrings
    ADD CONSTRAINT omstrings_stringid_key UNIQUE (stringid);


--
-- Name: oml_omg_uk; Type: INDEX; Schema: translate; Owner: _developer
--

CREATE UNIQUE INDEX oml_omg_uk ON translate.omlibgrouplinks USING btree (olg_oml_ref, olg_omg_ref);


--
-- Name: sysasyncemails ae_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysasyncemails
    ADD CONSTRAINT ae_go_ref FOREIGN KEY (ae_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: entgrouporganisations go_report_to_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporganisations
    ADD CONSTRAINT go_report_to_go_ref FOREIGN KEY (go_report_to_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: entgrouporgnames gon_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.entgrouporgnames
    ADD CONSTRAINT gon_go_ref FOREIGN KEY (gon_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: sysreferenceorg rfo_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceorg
    ADD CONSTRAINT rfo_go_ref FOREIGN KEY (rfo_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: sysreferenceuser rfu_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceuser
    ADD CONSTRAINT rfu_go_ref FOREIGN KEY (rfu_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: sysreferenceuser rfu_usr_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.sysreferenceuser
    ADD CONSTRAINT rfu_usr_ref FOREIGN KEY (rfu_usr_ref) REFERENCES infra.uausers(usr_seq);


--
-- Name: systaskstats sts_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.systaskstats
    ADD CONSTRAINT sts_go_ref FOREIGN KEY (sts_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: systaskstats sts_ula_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.systaskstats
    ADD CONSTRAINT sts_ula_ref FOREIGN KEY (sts_ula_ref) REFERENCES infra.ualogaccess(ula_seq);


--
-- Name: uagrouporglinks ugo_go_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uagrouporglinks
    ADD CONSTRAINT ugo_go_ref FOREIGN KEY (ugo_go_ref) REFERENCES infra.entgrouporganisations(go_seq);


--
-- Name: uagrouporglinks ugo_usr_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uagrouporglinks
    ADD CONSTRAINT ugo_usr_ref FOREIGN KEY (ugo_usr_ref) REFERENCES infra.uausers(usr_seq);


--
-- Name: ualogaccess ula_usr_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.ualogaccess
    ADD CONSTRAINT ula_usr_ref FOREIGN KEY (ula_usr_ref) REFERENCES infra.uausers(usr_seq);


--
-- Name: uausers usr_usr_ref; Type: FK CONSTRAINT; Schema: infra; Owner: _developer
--

ALTER TABLE ONLY infra.uausers
    ADD CONSTRAINT usr_usr_ref FOREIGN KEY (usr_usr_ref) REFERENCES infra.uausers(usr_seq);


--
-- Name: omlibgrouplinks olg_omg_ref; Type: FK CONSTRAINT; Schema: translate; Owner: _developer
--

ALTER TABLE ONLY translate.omlibgrouplinks
    ADD CONSTRAINT olg_omg_ref FOREIGN KEY (olg_omg_ref) REFERENCES translate.omgroup(omg_seq);


--
-- Name: omlibgrouplinks olg_oml_ref; Type: FK CONSTRAINT; Schema: translate; Owner: _developer
--

ALTER TABLE ONLY translate.omlibgrouplinks
    ADD CONSTRAINT olg_oml_ref FOREIGN KEY (olg_oml_ref) REFERENCES translate.omlibrary(oml_seq) ON DELETE CASCADE;


--
-- Name: omstrings oms_omg_ref; Type: FK CONSTRAINT; Schema: translate; Owner: _developer
--

ALTER TABLE ONLY translate.omstrings
    ADD CONSTRAINT oms_omg_ref FOREIGN KEY (oms_omg_ref) REFERENCES translate.omgroup(omg_seq) ON DELETE CASCADE;


--
-- Name: SCHEMA infra; Type: ACL; Schema: -; Owner: _developer
--

GRANT USAGE ON SCHEMA infra TO regular;


--
-- Name: SCHEMA translate; Type: ACL; Schema: -; Owner: _developer
--

GRANT USAGE ON SCHEMA translate TO regular;


--
-- Name: SEQUENCE sysreferenceorg_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysreferenceorg_seq TO regular;


--
-- Name: TABLE sysreferenceorg; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.sysreferenceorg TO regular;


--
-- Name: FUNCTION initinherited(pclass text, pvalue text, pgoref integer); Type: ACL; Schema: infra; Owner: _developer
--

REVOKE ALL ON FUNCTION infra.initinherited(pclass text, pvalue text, pgoref integer) FROM PUBLIC;
GRANT ALL ON FUNCTION infra.initinherited(pclass text, pvalue text, pgoref integer) TO regular;


--
-- Name: SEQUENCE entgrouporganisations_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.entgrouporganisations_seq TO regular;


--
-- Name: TABLE entgrouporganisations; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.entgrouporganisations TO regular;


--
-- Name: SEQUENCE entgrouporgnames_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.entgrouporgnames_seq TO regular;


--
-- Name: TABLE entgrouporgnames; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.entgrouporgnames TO regular;


--
-- Name: SEQUENCE sysasyncemails_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysasyncemails_seq TO regular;


--
-- Name: TABLE sysasyncemails; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.sysasyncemails TO regular;


--
-- Name: TABLE syslogerrors; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.syslogerrors TO regular;


--
-- Name: TABLE syslogevents; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.syslogevents TO regular;


--
-- Name: SEQUENCE sysreferenceglobal_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysreferenceglobal_seq TO regular;


--
-- Name: TABLE sysreferenceglobal; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.sysreferenceglobal TO regular;


--
-- Name: SEQUENCE sysreferencelocal_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysreferencelocal_seq TO regular;


--
-- Name: TABLE sysreferencelocal; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.sysreferencelocal TO regular;


--
-- Name: SEQUENCE sysreferenceuser_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.sysreferenceuser_seq TO regular;


--
-- Name: TABLE sysreferenceuser; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.sysreferenceuser TO regular;


--
-- Name: SEQUENCE systaskstats_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.systaskstats_seq TO regular;


--
-- Name: TABLE systaskstats; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,UPDATE ON TABLE infra.systaskstats TO regular;


--
-- Name: SEQUENCE uagrouporglinks_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.uagrouporglinks_seq TO regular;


--
-- Name: TABLE uagrouporglinks; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.uagrouporglinks TO regular;


--
-- Name: SEQUENCE ualogaccess_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.ualogaccess_seq TO regular;


--
-- Name: TABLE ualogaccess; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.ualogaccess TO regular;


--
-- Name: SEQUENCE uausers_seq; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE infra.uausers_seq TO regular;


--
-- Name: TABLE uausers; Type: ACL; Schema: infra; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE infra.uausers TO regular;


--
-- Name: SEQUENCE omgroup_seq; Type: ACL; Schema: translate; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE translate.omgroup_seq TO regular;


--
-- Name: TABLE omgroup; Type: ACL; Schema: translate; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE translate.omgroup TO regular;


--
-- Name: SEQUENCE omlibgrouplinks_seq; Type: ACL; Schema: translate; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE translate.omlibgrouplinks_seq TO regular;


--
-- Name: TABLE omlibgrouplinks; Type: ACL; Schema: translate; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE translate.omlibgrouplinks TO regular;


--
-- Name: SEQUENCE omlibrary_seq; Type: ACL; Schema: translate; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE translate.omlibrary_seq TO regular;


--
-- Name: TABLE omlibrary; Type: ACL; Schema: translate; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE translate.omlibrary TO regular;


--
-- Name: SEQUENCE omstrings_seq; Type: ACL; Schema: translate; Owner: _developer
--

GRANT SELECT,UPDATE ON SEQUENCE translate.omstrings_seq TO regular;


--
-- Name: TABLE omstrings; Type: ACL; Schema: translate; Owner: _developer
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE translate.omstrings TO regular;


--
-- PostgreSQL database dump complete
--


