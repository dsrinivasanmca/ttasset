1. companies
2. companylog
3. branches
4. branchlog
5. rooms
6. roomlog
7. departments
8. departmentlog
9. designations
10. designationlog
11. roles
12. usertypes
13. users
14. userlog
15. vendorcompanies
16. vendorcompanylog



Sequences:
==========

1. companyid
2. branchid
3. roomid
4. departmentid
5. designationid
6. userid
7. vendorcompanyid


alter table companies drop constraint companies_createdby_fk;
alter table companies drop constraint companyname_unique;



alter table companylog drop constraint companylog_modifiedby_fk;
alter table companylog drop constraint companylog_companyid_fk;


alter table branches drop constraint branches_createdby_fk;
alter table branches drop constraint branches_companyid_fk;
alter table branches drop constraint branchname_unique;


alter table branchlog drop constraint branchloglog_modifiedby_fk;
alter table branchlog drop constraint branchlog_branchid_fk;


alter table rooms drop constraint rooms_createdby_fk;
alter table rooms drop constraint rooms_branchid_fk;
alter table rooms drop constraint rooms_companyid_fk;
alter table rooms drop constraint roomname_unique;


alter table roomlog drop constraint roomlog_modifiedby_fk;
alter table roomlog drop constraint roomlog_roomid_fk;


alter table departments drop constraint departments_createdby_fk;
alter table departments drop constraint departments_companyid_fk;
alter table departments drop constraint departmentname_unique;


alter table departmentlog drop constraint departmentlog_modifiedby_fk;
alter table departmentlog drop constraint departmentlog_departmentid_fk;


alter table designations drop constraint designations_createdby_fk;
alter table designations drop constraint designations_companyid_fk;
alter table designations drop constraint designation_unique;


alter table designationlog drop constraint designationlog_modifiedby_fk;
alter table designationlog drop constraint desglog_designationid_fk;


alter table vendorcompanies drop constraint vendorcompanies_createdby_fk;
alter table vendorcompanies drop constraint vendorcompanies_companyid_fk;
alter table vendorcompanies drop constraint vendorcompanyname_unique;


alter table vendorcompanylog drop constraint vencompanylog_modifiedby_fk;
alter table vendorcompanylog drop constraint vencomlog_vendorcompanyid_fk;



alter table users drop constraint users_rolename_fk;
alter table users drop constraint users_usertype_fk;
alter table users drop constraint users_branchid_fk;
alter table users drop constraint users_companyid_fk;
alter table users drop constraint users_departmentid_fk;
alter table users drop constraint users_designationid_fk;
alter table users drop constraint users_createdby_fk;
alter table users drop constraint employeeid_unique;
alter table users drop constraint mobileno_unique;
alter table users drop constraint emailid_unique;




alter table userlog drop constraint userlog_modifiedby_fk;
alter table userlog drop constraint userlog_userid_fk;
alter table userlog drop constraint userlog_rolename_fk;
alter table userlog drop constraint userlog_usertype_fk;
alter table userlog drop constraint userlog_branchid_fk;
alter table userlog drop constraint userlog_departmentid_fk;
alter table userlog drop constraint userlog_designationid_fk;



drop table userlog;
drop table users;
drop sequence userid;
drop table usertypes;
drop table roles;
drop table vendorcompanylog;
drop table vendorcompanies;
drop sequence vendorcompanyid;
drop table designationlog;
drop table designations;
drop sequence designationid;
drop table departmentlog;
drop table departments;
drop sequence departmentid;
drop table roomlog;
drop table rooms;
drop sequence roomid;
drop table branchlog;
drop table branches;
drop sequence branchid;
drop table companylog;
drop table companies;
drop sequence companyid;
commit;