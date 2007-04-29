-- create or replace package body acs_attribute
-- function create_attribute with attribute_id
create or replace function acs_attribute__create_attribute (integer,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,integer,integer,integer,varchar,boolean)
returns integer as '
declare
  create_attribute__attribute_id           alias for $1;  
  create_attribute__object_type            alias for $2;  
  create_attribute__attribute_name         alias for $3;  
  create_attribute__datatype               alias for $4;  
  create_attribute__pretty_name            alias for $5;  
  create_attribute__pretty_plural          alias for $6;  -- default null
  create_attribute__table_name             alias for $7;  -- default null
  create_attribute__column_name            alias for $8;  -- default null
  create_attribute__default_value          alias for $9;  -- default null
  create_attribute__min_n_values           alias for $10;  -- default 1
  create_attribute__max_n_values           alias for $11; -- default 1
  create_attribute__sort_order             alias for $12; -- default null
  create_attribute__storage                alias for $13; -- default ''type_specific''
  create_attribute__static_p               alias for $14; -- default ''f''

  v_sort_order           acs_attributes.sort_order%TYPE;

begin
    if create_attribute__sort_order is null then
      select coalesce(max(sort_order), 1) into v_sort_order
      from acs_attributes
      where object_type = create_attribute__object_type
      and attribute_name = create_attribute__attribute_name;
    else
      v_sort_order := create_attribute__sort_order;
    end if;

    insert into acs_attributes
      (attribute_id, object_type, table_name, column_name, attribute_name,
       pretty_name, pretty_plural, sort_order, datatype, default_value,
       min_n_values, max_n_values, storage, static_p)
    values
      (create_attribute__attribute_id, create_attribute__object_type, 
       create_attribute__table_name, create_attribute__column_name, 
       create_attribute__attribute_name, create_attribute__pretty_name,
       create_attribute__pretty_plural, v_sort_order, 
       create_attribute__datatype, create_attribute__default_value,
       create_attribute__min_n_values, create_attribute__max_n_values, 
       create_attribute__storage, create_attribute__static_p);

    return v_attribute_id;
   
end;' language 'plpgsql';
