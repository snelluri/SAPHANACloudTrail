-- Setup user account by logging in as SYSTEM user:
CREATE USER MY_ADMINISTRATOR_USER PASSWORD AdminOnly01 NO FORCE_FIRST_PASSWORD_CHANGE;

-- Which hana roles to create for sap hana administrator users?
-- role to perform backup
CREATE ROLE MY_BACKUP_ROLE;

-- role to checkup sap hana status
CREATE ROLE MY_MONITOR_ROLE; 

-- role to access, use and manage hana cockpit
CREATE ROLE MY_COCKPIT_ROLE;

-- role to access and manage repository
CREATE ROLE MY_REPOSITORY_ROLE; 

-- role to manage system and tenant databases
CREATE ROLE MY_SYSTEM_ROLE; 

-- Final role which gather all or some of the created roles
CREATE ROLE MY_ADMINISTRATOR_ROLE; 

--Which privileges to assign to sap hana administrator users?

/* BACKUP privileges

SQL Syntax */

GRANT BACKUP ADMIN TO MY_BACKUP_ROLE; 
GRANT CATALOG READ TO MY_BACKUP_ROLE; 

/* MONITOR privileges

SQL Syntax */

GRANT MONITORING TO MY_MONITOR_ROLE;

/* COCKPIT privileges

SQL Syntax */

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

/* REPOSITORY privileges

SQL Syntax */

GRANT REPO.EXPORT TO MY_REPOSITORY_ROLE;
GRANT REPO.IMPORT TO MY_REPOSITORY_ROLE;
GRANT REPO.MAINTAIN_DELIVERY_UNITS TO MY_REPOSITORY_ROLE;
GRANT REPO.WORK_IN_FOREIGN_WORKSPACEGRANT TO MY_REPOSITORY_ROLE;
GRANT REPO.CONFIGURE TO MY_REPOSITORY_ROLE;
GRANT REPO.MODIFY_CHANGE TO MY_REPOSITORY_ROLE;
GRANT REPO.MODIFY_OWN_CONTRIBUTION TO MY_REPOSITORY_ROLE;
GRANT REPO.MODIFY_FOREIGN_CONTRIBUTION TO MY_REPOSITORY_ROLE;

/* SYSTEM privileges

SQL Syntax */

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

-- How to assign privileges to sap hana administrator users?
/* Grant all Roles to the 
final Administrator role
then to the user

SQL Syntax */

GRANT MY_BACKUP_ROLE TO MY_ADMINISTRATOR_ROLE;
GRANT MY_MONITOR_ROLE TO MY_ADMINISTRATOR_ROLE;
GRANT MY_COCKPIT_ROLE TO MY_ADMINISTRATOR_ROLE;
GRANT MY_REPOSITORY_ROLE TO MY_ADMINISTRATOR_ROLE;
GRANT MY_SYSTEM_ROLE TO MY_ADMINISTRATOR_ROLE;

GRANT MY_ADMINISTRATOR_ROLE TO snelluri;
