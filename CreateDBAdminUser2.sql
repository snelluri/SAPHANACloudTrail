Context
You specify a password for the SYSTEM user when your create your SAP HANA tenant database. You use the SYSTEM user to log on to SAP HANA cockpit and create your own database administration user.

The SYSTEM user is a preconfigured database superuser with irrevocable system privileges, such as the ability to create other database users, access system tables, and so on. A database-specific SYSTEM user exists in every database of a tenant database system. To ensure that the administration tool SAP HANA cockpit can be used immediately after database creation, the SYSTEM user is automatically given several roles the first time the SAP HANA cockpit is opened with this user.

To view the details of a database, for example, its state and the number of existing bindings, select a database in the list and click the link on its name. On the overview of the database, you can perform further actions, for example, delete the database.

This is the message we get. 

You've been assigned the roles 'sap.hana.admin.roles::Administrator', 'sap.hana.ide.roles::TraceViewer', 'sap.hana.ide.roles::SecurityAdmin'.

link 
https://help.sap.com/viewer/d4790b2de2f4429db6f3dff54e4d7b3a/Cloud/en-US/0289b61b67c2425683600b85ab1861f3.html
User id: snelluri
Password: W2!

Here are the sql steps:

	
CREATE USER snelluri PASSWORD AdminOnly01 NO FORCE_FIRST_PASSWORD_CHANGE;

A certain number of intermediate roles have to be created in order to organize and group privileges according to their domain of action. Final administrator roles which would be gathering all or some of the intermediate roles, will be created and assigned to one or more administrator users. You could have a PROJECT DEVELOPMENT ADMINITRATOR role, a TENANT DATABASE SYSTEM ADMINISTRATOR role and so on. 

BACKUP role

SQL Syntax

CREATE ROLE MY_BACKUP_ROLE;
-- role to perform backup

MONITOR role

SQL Syntax

CREATE ROLE MY_MONITOR_ROLE; 
-- role to checkup sap hana status

COCKPIT role

SQL Syntax

CREATE ROLE MY_COCKPIT_ROLE; 
-- role to access, use and manage hana cockpit

REPOSITORY role

SQL Syntax

CREATE ROLE MY_REPOSITORY_ROLE; 
-- role to access and manage repository

SYSTEM role

SQL Syntax

CREATE ROLE MY_SYSTEM_ROLE; 
-- role to manage system and tenant databases

ADMINISTRATION role

SQL Syntax

CREATE ROLE MY_ADMINISTRATOR_ROLE; 
-- Final role which gather all or some of the created roles

Which privileges to assign to sap hana administrator users?

A Sap hana administrator user requires many privileges. The best way to assign all those different privileges, is to use pre-defined roles which will be then assigned to final sap hana adminsitrator users. 

Here are some privileges not to forget : 

- The GRANT USER ADMIN authorizes the re-activation of the system user. Unfortunately the system user can be locked for different reasons. The most common one would be the "too many wrong connexion attempts". 
To re-activate SYSTEM user : [ ALTER USER SYSTEM RESET CONNECT ATTEMPTS ]

Assigning privileges to roles 

BACKUP privileges

SQL Syntax

GRANT BACKUP ADMIN TO MY_BACKUP_ROLE; 
GRANT CATALOG READ TO MY_BACKUP_ROLE; 
MONITOR privileges

SQL Syntax

GRANT MONITORING TO MY_MONITOR_ROLE;

COCKPIT privileges

SQL Syntax

GRANT TENANT ADMIN TO MY_COCKPIT_ROLE;
GRANT MONITORING TO MY_COCKPIT_ROLE;
GRANT BACKUP ADMIN TO MY_COCKPIT_ROLE;
GRANT CATALOG READ TO MY_COCKPIT_ROLE;
GRANT INIFILE ADMIN	TO MY_COCKPIT_ROLE;
GRANT SERVICE ADMIN TO MY_COCKPIT_ROLE;
GRANT TRACE ADMIN	TO MY_COCKPIT_ROLE;
GRANT RESOURCE ADMIN	TO MY_COCKPIT_ROLE;
GRANT LICENSE ADMIN TO MY_COCKPIT_ROLE;

GRANT EXECUTE ON SCHEMA _SYS_STATISTICS TO MY_COCKPIT_ROLE WITH GRANT OPTION;
GRANT SELECT ON SCHEMA _SYS_STATISTICS TO MY_COCKPIT_ROLE WITH GRANT OPTION;
GRANT DELETE ON SCHEMA _SYS_STATISTICS TO MY_COCKPIT_ROLE WITH GRANT OPTION;
GRANT UPDATE ON SCHEMA _SYS_STATISTICS TO MY_COCKPIT_ROLE WITH GRANT OPTION;
GRANT INSERT ON SCHEMA _SYS_STATISTICS TO MY_COCKPIT_ROLE WITH GRANT OPTION;

GRANT UPDATE ON _SYS_STATISTICS.STATISTICS_SCHEDULE TO MY_COCKPIT_ROLE WITH GRANT OPTION;
GRANT SELECT ON SYS.FULL_SYSTEM_INFO_DUMPS TO MY_COCKPIT_ROLE WITH GRANT OPTION;
GRANT EXECUTE ON SYS.MANAGEMENT_CONSOLE_PROC TO MY_COCKPIT_ROLE WITH GRANT OPTION;

GRANT UPDATE ON _SYS_STATISTICS.STATISTICS_SCHEDULE TO MY_COCKPIT_ROLE WITH GRANT OPTION;
GRANT EXECUTE ON SYS.MANAGEMENT_CONSOLE_PROC TO MY_COCKPIT_ROLE WITH GRANT OPTION;
GRANT EXECUTE ON SYS.FULL_SYSTEM_INFO_DUMP_DELETE TO MY_COCKPIT_ROLE WITH GRANT OPTION;
GRANT EXECUTE ON SYS.FULL_SYSTEM_INFO_DUMP_RETRIEVE TO MY_COCKPIT_ROLE WITH GRANT OPTION;
GRANT EXECUTE ON SYS.FULL_SYSTEM_INFO_DUMP_CREATE TO MY_COCKPIT_ROLE WITH GRANT OPTION;


-- to open the cockpit and access the tiles 
-- DB Administration, Platform Lifecycle Management; backup 
call GRANT_ACTIVATED_ROLE('sap.hana.admin.roles::Administrator','MY_COCKPIT_ROLE');

-- for SAP HANA System Replication
call GRANT_ACTIVATED_ROLE('sap.hana.admin.cockpit.sysrep.roles::SysRepAdmin','MY_COCKPIT_ROLE');

-- to open the Security tool 
call GRANT_ACTIVATED_ROLE('sap.hana.ide.roles::SecurityAdmin','MY_COCKPIT_ROLE'); 

-- Security Overview
call GRANT_ACTIVATED_ROLE('sap.hana.security.cockpit.roles::DisplaySecurityDashboard','MY_COCKPIT_ROLE'); 

-- User Management
call GRANT_ACTIVATED_ROLE('sap.hana.security.cockpit.roles::EditAssignedRoles','MY_COCKPIT_ROLE');

-- Certificate Management
call GRANT_ACTIVATED_ROLE('sap.hana.security.cockpit.roles::EditCertificateStore','MY_COCKPIT_ROLE');

-- to edit Fiori launchpad application
call GRANT_ACTIVATED_ROLE('sap.hana.uis.db::SITE_DESIGNER','MY_COCKPIT_ROLE'); 

REPOSITORY privileges

SQL Syntax

GRANT REPO.EXPORT TO MY_REPOSITORY_ROLE;
GRANT REPO.IMPORT TO MY_REPOSITORY_ROLE;
GRANT REPO.MAINTAIN_DELIVERY_UNITS TO MY_REPOSITORY_ROLE;
GRANT REPO.WORK_IN_FOREIGN_WORKSPACEGRANT TO MY_REPOSITORY_ROLE;
GRANT REPO.CONFIGURE TO MY_REPOSITORY_ROLE;
GRANT REPO.MODIFY_CHANGE TO MY_REPOSITORY_ROLE;
GRANT REPO.MODIFY_OWN_CONTRIBUTION TO MY_REPOSITORY_ROLE;
GRANT REPO.MODIFY_FOREIGN_CONTRIBUTION TO MY_REPOSITORY_ROLE;
SYSTEM privileges

SQL Syntax

GRANT ADAPTER ADMIN TO MY_SYSTEM_ROLE;
GRANT AGENT ADMIN TO MY_SYSTEM_ROLE;
GRANT ATTACH DEBUGGER TO MY_SYSTEM_ROLE;
GRANT AUDIT ADMIN TO MY_SYSTEM_ROLE;
GRANT AUDIT OPERATOR TO MY_SYSTEM_ROLE;
GRANT SSL ADMIN TO MY_SYSTEM_ROLE;
GRANT CREATE SCHEMA TO MY_SYSTEM_ROLE;
GRANT BACKUP ADMIN TO MY_SYSTEM_ROLE;
GRANT BACKUP OPERATOR TO MY_SYSTEM_ROLE;
GRANT CATALOG READ TO MY_SYSTEM_ROLE;
GRANT CERTIFICATE ADMIN TO MY_SYSTEM_ROLE;
GRANT CREATE REMOTE SOURCE TO MY_SYSTEM_ROLE;
GRANT CREATE STRUCTURED PRIVILEGE TO MY_SYSTEM_ROLE;
GRANT CREDENTIAL ADMIN TO MY_SYSTEM_ROLE;

GRANT DATA ADMIN TO MY_SYSTEM_ROLE;
GRANT DATABASE ADMIN TO MY_SYSTEM_ROLE;
GRANT EXPORT, IMPORT TO MY_SYSTEM_ROLE;
GRANT EXTENDED STORAGE ADMIN TO MY_SYSTEM_ROLE;
GRANT INIFILE ADMIN TO MY_SYSTEM_ROLE;
GRANT LICENSE ADMIN TO MY_SYSTEM_ROLE;
GRANT LOG ADMIN TO MY_SYSTEM_ROLE;
GRANT MONITOR ADMIN TO MY_SYSTEM_ROLE;
GRANT OPTIMIZER ADMIN TO MY_SYSTEM_ROLE;

GRANT RESOURCE ADMIN TO MY_SYSTEM_ROLE;
GRANT ROLE ADMIN TO MY_SYSTEM_ROLE;
GRANT SAVEPOINT ADMIN TO MY_SYSTEM_ROLE;
GRANT SCENARIO ADMIN TO MY_SYSTEM_ROLE;
GRANT SERVICE ADMIN TO MY_SYSTEM_ROLE;
GRANT SESSION ADMIN TO MY_SYSTEM_ROLE;
GRANT SSL ADMIN TO MY_SYSTEM_ROLE;
GRANT STRUCTUREDPRIVILEGE ADMIN TO MY_SYSTEM_ROLE;

GRANT TENANT ADMIN TO MY_SYSTEM_ROLE;
GRANT TABLE ADMIN TO MY_SYSTEM_ROLE;
GRANT TRACE ADMIN TO MY_SYSTEM_ROLE;
GRANT TRUST ADMIN TO MY_SYSTEM_ROLE;
GRANT USER ADMIN TO MY_SYSTEM_ROLE;
GRANT VERSION ADMIN TO MY_SYSTEM_ROLE;
GRANT WORKLOAD ANALYZE ADMIN TO MY_SYSTEM_ROLE;
GRANT WORKLOAD CAPTURE ADMIN TO MY_SYSTEM_ROLE;
GRANT WORKLOAD REPLAY ADMIN TO MY_SYSTEM_ROLE;
GRANT EXECUTE ON "SYS"."REPOSITORY_REST" TO MY_SYSTEM_ROLE;
GRANT EXECUTE ON "PUBLIC"."GRANT_ACTIVATED_ROLE" TO MY_SYSTEM_ROLE; 
GRANT EXECUTE ON "PUBLIC"."REVOKE_ACTIVATED_ROLE" TO MY_SYSTEM_ROLE; 




