create table companies
		(
		companyid number(2),
		companyname varchar2(35) not null,
		openingdate varchar(10) not null,
		status number(1) not null,
		createdby number,
    		creationdatetime varchar(20) not null,
		primary key(companyid),
		constraint companyname_unique UNIQUE(companyname)
		);
    
create sequence companyid start with 1 increment by 1;

create table companylog
		(
		companyid number(2) not null,
		companyname varchar2(35) not null,
		openingdate varchar(10) not null,
		status number(1) not null,
		modifiedby number,
		modifydatetime varchar(20) not null,
		description varchar(200),
		constraint companylog_companyid_fk foreign key(companyid) references companies(companyid)
		);

--insert into companies(companyid,companyname,openingdate,status,creationdatetime) 
--values(companyid.nextval,'admincompany',(select to_char(current_timestamp, 'DD-MM-YYYY HH24:MI:SS') from dual),'1',
--(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual));


insert into companies(companyid,companyname,openingdate,status,creationdatetime) 
values(companyid.nextval,'admincompany',(select to_char(current_timestamp,'DD-MM-YYYY') from dual),'1',
(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual));

select companyid,companyname,openingdate,status,creationdatetime from companies;


insert into companylog(companyid,companyname,openingdate,status,modifydatetime,description) 
values(
	(select companyid from companies where companyname='admincompany'),
	'admincompany',
	(select openingdate from companies where companyname='admincompany'),
	'1',
	(select creationdatetime from companies where companyname='admincompany'),
	'newly created'
	);

select companyid,companyname,openingdate,status,modifydatetime,description from companylog;

create table branches
		(
		branchid number(3),
		branchname varchar2(25) not null,
		companyid number(2) not null,
		address1 varchar2(35) not null,
		address2 varchar2(35) not null,
		address3 varchar2(35) not null,
		address4 varchar2(35) not null,
		postalcode varchar2(10) not null,
		city varchar2(20) not null,
		state varchar2(20) not null,
		country varchar2(20) not null,
		status number(1) not null,
		createdby number,
		creationdatetime varchar(20) not null,
		primary key(branchid),
		constraint branches_companyid_fk foreign key(companyid) references companies(companyid),
		constraint branchname_unique UNIQUE(branchname,companyid)
		);

create sequence branchid start with 1 increment by 1;


create table branchlog
		(
		branchid number(3) not null,
		branchname varchar2(25) not null,
		address1 varchar2(35) not null,
		address2 varchar2(35) not null,
		address3 varchar2(35) not null,
		address4 varchar2(35) not null,
		postalcode varchar2(10) not null,
		city varchar2(20) not null,
		state varchar2(20) not null,
		country varchar2(20) not null,
		status number(1) not null,
		modifiedby number,
		modifydatetime varchar(20) not null,
		description varchar(200),
		constraint branchlog_branchid_fk foreign key(branchid) references branches(branchid)
		);


insert into branches(branchid,branchname,companyid,address1,address2,address3,address4,postalcode,city,state,country,status,creationdatetime) 
values(
	branchid.nextval,
	'adminbranch',
	(select companyid from companies where companyname='admincompany'),
	'address1',
	'address2',
	'address3',
	'address4',
	'postalcode',
	'admincity',
	'adminstate',
	'admincountry',
	'1',
	(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual)
	);

select branchid,branchname,companyid,address1,address2,address3,address4,postalcode,city,state,country,status,creationdatetime from branches;

insert into branchlog(branchid,branchname,address1,address2,address3,address4,postalcode,city,state,country,status,modifydatetime,description) 
values(
	(select branchid from branches where branchname='adminbranch' 
	and companyid=(select companyid from companies where companyname='admincompany')),
	'adminbranch',
	'address1',
	'address2',
	'address3',
	'address4',
	'postalcode',
	'admincity',
	'adminstate',
	'admincountry',
	'1',
	(select creationdatetime from branches where branchname='adminbranch'),
	'newly created'
	);

select branchid,branchname,address1,address2,address3,address4,postalcode,city,state,country,status,modifydatetime from branchlog;

create table rooms
		(
		roomid number(4),
		roomname varchar2(25) not null,
		branchid number(3) not null,
		companyid number(2) not null,
		status number(1) not null,
		createdby number,
		creationdatetime varchar(20) not null,
		primary key(roomid),
		constraint rooms_branchid_fk foreign key(branchid) references branches(branchid),
		constraint rooms_companyid_fk foreign key(companyid) references companies(companyid),
		constraint roomname_unique UNIQUE(roomname,branchid)
		);

create sequence roomid start with 1 increment by 1;

create table roomlog
		(
		roomid number(4) not null,
		roomname varchar2(25) not null,
		status number(1) not null,
		modifiedby number,
		modifydatetime varchar(20) not null,
		description varchar(200),
		constraint roomlog_roomid_fk foreign key(roomid) references rooms(roomid)
		);

insert into rooms(roomid,roomname,branchid,companyid,status,creationdatetime) 
values(
	roomid.nextval,
	'adminroom',
	(select branchid from branches where branchname='adminbranch'),
	(select companyid from companies where companyname='admincompany'),
	'1',
	(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual)
	);

select roomid,roomname,branchid,companyid,status,creationdatetime from rooms;

insert into roomlog(roomid,roomname,status,modifydatetime,description) 
values(
	(select roomid from rooms where roomname='adminroom'),
	
	'adminroom',
	'1',
	(select creationdatetime from rooms where roomname='adminroom'),
	'newly created'
	);

select roomid,roomname,status,modifydatetime from roomlog;

create table departments
		(
		departmentid number(3),
		departmentname varchar2(25) not null,
		companyid number(2) not null,
		status number(1) not null,
		createdby number,
		creationdatetime varchar(20) not null,
		primary key(departmentid),
		constraint departments_companyid_fk foreign key(companyid) references companies(companyid),
		constraint departmentname_unique UNIQUE(departmentname,companyid)
		);
    
create sequence departmentid start with 1 increment by 1;

create table departmentlog
		(
		departmentid number(3) not null,
		departmentname varchar2(25) not null,
		status number(1) not null,
		modifiedby number,
		modifydatetime varchar(20) not null,
		description varchar(200),
		constraint departmentlog_departmentid_fk foreign key(departmentid) references departments(departmentid)
		);

insert into departments(departmentid,departmentname,companyid,status,creationdatetime) 
values(
	departmentid.nextval,
	'admindepartment',
	(select companyid from companies where companyname='admincompany'),
	'1',
	(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual)
	);

select departmentid,departmentname,companyid,status,creationdatetime from departments;

insert into departmentlog(departmentid,departmentname,status,modifydatetime,description) 
values(
	(select departmentid from departments where departmentname='admindepartment'),
	'admindepartment',
	'1',
	(select creationdatetime from departments where departmentname='admindepartment'),
	'newly created'
	);

select departmentid,departmentname,status,modifydatetime from departmentlog;

create table designations
		(
		designationid number(3),
		designationname varchar2(25) not null,
		companyid number(2) not null,
		status number(1) not null,
		createdby number,
		creationdatetime varchar(20) not null,
		primary key(designationid),
		constraint designations_companyid_fk foreign key(companyid) references companies(companyid),
		constraint designation_unique UNIQUE(designationname,companyid)
		);
    
create sequence designationid start with 1 increment by 1;

create table designationlog
		(
		designationid number(3) not null,
		designationname varchar2(25) not null,
		status number(1) not null,
		modifiedby number,
		modifydatetime varchar(20) not null,
		description varchar(200),
		constraint desglog_designationid_fk foreign key(designationid) references designations(designationid)
		);

insert into designations(designationid,designationname,companyid,status,creationdatetime) 
values(
	designationid.nextval,
	'admindesignation',
	(select companyid from companies where companyname='admincompany'),
	'1',
	(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual)
	);

select designationid,designationname,companyid,status,creationdatetime from designations;

insert into designationlog(designationid,designationname,status,modifydatetime,description) 
values(
	(select designationid from designations where designationname='admindesignation'),
	'admindesignation',
	'1',
	(select creationdatetime from designations where designationname='admindesignation'),
	'newly created'
	);

select designationid,designationname,status,modifydatetime from designationlog;

create table roles
		(
		rolename varchar2(15), 
		description varchar2(200),
		primary key(rolename)
		);

insert into roles values
		(
		'rootadmin',
		'User belongs to this ROOTADMIN role can add new COMPANIES,BRANCHES,ROOMS,DEPARTMENTS,DESIGNATIONS and USERS'
		);
insert into roles values
		(
		'companyadmin',
		'User belongs to this COMPANYAMDIN role can add new BRANCHES,DEPARTMENTS,DESIGNATIONS,ROOMS,USERS and ASSETS' 
		);
insert into roles values
		(
		'branchadmin',
		'User belongs to this BRANCHADMIN role can MANAGE ASSETS and TICKETS'
		);
insert into roles values
		(
		'systemadmin',
		'User belongs to this SYSTEMADMIN role can MANAGE ASSETS and TICKETS But less options than BRANCHADMIN'
		);
insert into roles values
		(
		'staff',
		'User belongs to this STAFF role can create NEW TICKET'
		);
insert into roles values
		(
		'guest',
		'User belongs to this GUEST role not belongs to any company but can create NEW TICKET'
		);

select rolename,description from roles;

create table usertypes
		(
		usertype varchar2(15), 
		description varchar2(200),
		primary key(usertype)
		);

insert into usertypes values
		(
		'employee',
		'Own Company Employee can belongs to any Roles'
		);
insert into usertypes values
		(
		'partner',
		'Partner Company Employee only belongs to guest Role'
		);

insert into usertypes values
		(
		'consultant',
		'Vendor Company Employee only belongs to guest Role'
		);

insert into usertypes values
		(
		'trainee',
		'Vendor Company Employee only belongs to guest Role'
		);

select usertype,description from usertypes;


create table users
		(
		userid number,
		usertype varchar(15) not null,
		companyid number(2) not null,
		vendorcompanyid number(3) not null,		
		branchid number(3) not null,
		employeeid varchar2(25) not null,
		loginpassword varchar2(45) not null,
		userfirstname varchar2(35) not null,
		userlastname varchar2(35) not null,
		mobileno varchar2(15) not null,
		emailid varchar2(40) not null,
		rolename varchar2(15) not null,
		departmentid number(3) not null,
		designationid number(3) not null,
		joiningdate varchar(10) not null,
		gender varchar2(1) not null,
		status number(1) not null,
		createdby number,
		creationdatetime varchar(20) not null,
		primary key(userid),
		constraint users_rolename_fk foreign key(rolename) references roles(rolename),
		constraint users_usertype_fk foreign key(usertype) references usertypes(usertype),
		constraint users_branchid_fk foreign key(branchid) references branches(branchid),
		constraint users_companyid_fk foreign key(companyid) references companies(companyid),		
		constraint users_departmentid_fk foreign key(departmentid) references departments(departmentid),
		constraint users_designationid_fk foreign key(designationid) references designations(designationid),
    		constraint employeeid_unique UNIQUE(employeeid),
		constraint mobileno_unique UNIQUE(mobileno),
		constraint emailid_unique UNIQUE(emailid)
		);

create sequence userid start with 1 increment by 1;

create table userlog
		(
		userid number,
		usertype varchar(15) not null,
		vendorcompanyid number(3) not null,		
		branchid number(3) not null,
		employeeid varchar2(25) not null,
		userfirstname varchar2(35) not null,
		userlastname varchar2(35) not null,
		mobileno varchar2(15) not null,
		emailid varchar2(40) not null,
		rolename varchar2(15) not null,
		departmentid number(3) not null,
		designationid number(3) not null,
		joiningdate varchar(10) not null,
		gender varchar2(1) not null,
		status number(1) not null,
		modifiedby number,
		modifydatetime varchar(20) not null,
		description varchar(200),
		constraint userlog_userid_fk foreign key(userid) references users(userid),
		constraint userlog_rolename_fk foreign key(rolename) references roles(rolename),	
		constraint userlog_usertype_fk foreign key(usertype) references usertypes(usertype),		
		constraint userlog_branchid_fk foreign key(branchid) references branches(branchid),
		constraint userlog_departmentid_fk foreign key(departmentid) references departments(departmentid),
		constraint userlog_designationid_fk foreign key(designationid) references designations(designationid)
		);

insert into users(userid,employeeid,loginpassword,userfirstname,userlastname,mobileno,emailid,rolename,usertype,companyid,vendorcompanyid,branchid,
departmentid,designationid,joiningdate,gender,status,creationdatetime) 
values(
	userid.nextval,
	'adminuser',
	'bb4521a985aa240404375421356041717fddd4c4',
	'admin',
	'user',
	'adminuser',
	'adminuser',
	'rootadmin',
	'employee',
	(select companyid from companies where companyname='admincompany'),
	0,
	(select branchid from branches where branchname='adminbranch'),
	(select departmentid from departments where departmentname='admindepartment'),
	(select designationid from designations where designationname='admindesignation'),
	(select to_char(current_timestamp,'DD-MM-YYYY') from dual),
	'm',
	'1',
	(select to_char(current_timestamp,'DD-MM-YYYY HH24:MI:SS') from dual)
	);

select userid,employeeid,loginpassword,userfirstname,userlastname,mobileno,emailid,rolename,usertype,companyid,vendorcompanyid,branchid,
departmentid,designationid,joiningdate,gender,status,creationdatetime from users;

insert into userlog (userid,employeeid,userfirstname,userlastname,mobileno,emailid,rolename,usertype,vendorcompanyid,branchid,
departmentid,designationid,joiningdate,gender,status,modifydatetime,description) 
values(
	(select userid from users where employeeid='adminuser'),
	'adminuser',
	'admin',
	'user',
	'adminuser',
	'adminuser',
	'rootadmin',
	'employee',
	(select companyid from users where employeeid='adminuser'),
	(select branchid from users where employeeid='adminuser'),
	(select departmentid from users where employeeid='adminuser'),
	(select designationid from users where employeeid='adminuser'),
	(select joiningdate from users where employeeid='adminuser'),
	'm',
	'1',
	(select creationdatetime from users where employeeid='adminuser'),
	'newly created'
	);

select userid,employeeid,userfirstname,userlastname,mobileno,emailid,rolename,vendorcompanyid,branchid,
departmentid,designationid,joiningdate,gender,status,modifydatetime from userlog;

create table vendorcompanies
		(
		vendorcompanyid number(3),
		vendorcompanyname varchar2(25) not null,
		companyid number(2) not null,
		address1 varchar2(35) not null,
		address2 varchar2(35) not null,
		address3 varchar2(35) not null,
		address4 varchar2(35) not null,
		postalcode varchar2(10) not null,
		city varchar2(20) not null,
		state varchar2(20) not null,
		country varchar2(20) not null,
		status number(1) not null,
		createdby number not null,
		creationdatetime varchar(20) not null,
		primary key(vendorcompanyid),
		constraint vendorcompanies_companyid_fk foreign key(companyid) references companies(companyid),
		constraint vendorcompanies_createdby_fk foreign key(createdby) references users(userid),
		constraint vendorcompanyname_unique UNIQUE(vendorcompanyname,companyid)
		);



create sequence vendorcompanyid start with 1 increment by 1;


create table vendorcompanylog
		(
		vendorcompanyid number(3) not null,
		vendorcompanyname varchar2(25) not null,
		address1 varchar2(35) not null,
		address2 varchar2(35) not null,
		address3 varchar2(35) not null,
		address4 varchar2(35) not null,
		postalcode varchar2(10) not null,
		city varchar2(20) not null,
		state varchar2(20) not null,
		country varchar2(20) not null,
		status number(1) not null,
		modifiedby number not null,
		modifydatetime timestamp not null,
		description varchar(200),
		constraint vencompanylog_modifiedby_fk foreign key(modifiedby) references users(userid),
		constraint vencomlog_vendorcompanyid_fk foreign key(vendorcompanyid) references vendorcompanies(vendorcompanyid)
		);


commit;

update companies set createdby=(select userid from users where employeeid='adminuser');

Alter table companies modify(createdby number NOT NULL);

alter table companies add constraint companies_createdby_fk foreign key(createdby) references users(userid);

update companylog set modifiedby=(select userid from users where employeeid='adminuser');

Alter table companylog modify(modifiedby number NOT NULL);

alter table companylog add constraint companylog_modifiedby_fk foreign key(modifiedby) references users(userid);

update branches set createdby=(select userid from users where employeeid='adminuser');

Alter table branches modify(createdby number NOT NULL);

alter table branches add constraint branches_createdby_fk foreign key(createdby) references users(userid);

update branchlog set modifiedby=(select userid from users where employeeid='adminuser');

Alter table branchlog modify(modifiedby number NOT NULL);

alter table branchlog add constraint branchloglog_modifiedby_fk foreign key(modifiedby) references users(userid);

update rooms set createdby=(select userid from users where employeeid='adminuser');

Alter table rooms modify(createdby number NOT NULL);

alter table rooms add constraint rooms_createdby_fk foreign key(createdby) references users(userid);

update roomlog set modifiedby=(select userid from users where employeeid='adminuser');

Alter table roomlog modify(modifiedby number NOT NULL);

alter table roomlog add constraint roomlog_modifiedby_fk foreign key(modifiedby) references users(userid);

update departments set createdby=(select userid from users where employeeid='adminuser');

Alter table departments modify(createdby number NOT NULL);

alter table departments add constraint departments_createdby_fk foreign key(createdby) references users(userid);

update departmentlog set modifiedby=(select userid from users where employeeid='adminuser');

Alter table departmentlog modify(modifiedby number NOT NULL);

alter table departmentlog add constraint departmentlog_modifiedby_fk foreign key(modifiedby) references users(userid);

update designations set createdby=(select userid from users where employeeid='adminuser');

Alter table designations modify(createdby number NOT NULL);

alter table designations add constraint designations_createdby_fk foreign key(createdby) references users(userid);

update designationlog set modifiedby=(select userid from users where employeeid='adminuser');

Alter table designationlog modify(modifiedby number NOT NULL);

alter table designationlog add constraint designationlog_modifiedby_fk foreign key(modifiedby) references users(userid);

update users set createdby=(select userid from users where employeeid='adminuser');

Alter table users modify(createdby number NOT NULL);

alter table users add constraint users_createdby_fk foreign key(createdby) references users(userid);

update userlog set modifiedby=(select userid from users where employeeid='adminuser');

Alter table userlog modify(modifiedby number NOT NULL);

alter table userlog add constraint userlog_modifiedby_fk foreign key(modifiedby) references users(userid);

commit;