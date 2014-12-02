CS575
=====

This repository contains two files: webchef_ddl.sql and webchef_metadata.sql.  The webchef_ddl.sql file contains SQL script which is used to generate and initially populate the parsing schema tables for the WebChef application.  This script may be run in sqlplus, Oracle SQL Developer, or the APEX SQL Workshop to build the requisite WebChef database tables.  The webchef_metadata.sql script may be run in sqlplus to generate the Oracle Application Express metadata tables, or simply, the application.  Alternatively, this file may be imported within the APEX Application Builder in order to generate the application.  The webchef_metadata.sql contains all the code used to generate all the application pages.

WebChef is an Oracle Application Express (APEX) application; as such, it can only be built on an Oracle DBMS.
