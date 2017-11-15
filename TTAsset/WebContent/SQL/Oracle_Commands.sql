1. Oralce does not have auto_increment option so sequence is used.

	create sequence companyid start with 1 increment by 1;

2. To insert with current data and time.

	insert into companies(companyid,companyname) values(companyid.nextval,'admin',current_timestamp);


3. To Select date value without milliseconds.

	select companyid,companyname,to_char(creationdatetime,'DD-MM-YYYY HH24:MI:SS') from companies;

4. Joined Select Query

	select companyname from companies where companyid=(select companyid from departments where departmentid='1');

5. Joined Insert Query-1

	insert into companylog

(companyid,companyfullname,companyshortname,address1,address2,address3,address4,postalcode,city,state,country,status,modifydatetime) 
values((select companyid from companies where companyshortname='admincompany'),'admincompany software 
solution','admincompany','address1','address2','address3','address4','123456','admincity','adminstate','admincountry','1',(select creationdatetime from 

companies where companyshortname='admincompany'));


6. Joined Insert Query-2

	insert into branchlog(branchid,branchname,address1,address2,address3,address4,postalcode,city,state,country,status,modifydatetime) 
values((select branchid from branches where 
branchname='adminbranch' and companyid=(select companyid from companies where 

companyshortname='admincompany')),'adminbranch','address1','address2','address3','address4','123456','admincity','adminstate','admincountry','1',(select 
creationdatetime from branches where branchname='adminbranch' and companyid=(select companyid from companies where companyshortname='admincompany')));


7. Joined Insert Query-3

	insert into roomlog(roomid,roomname,status,modifydatetime) values((select roomid from rooms where roomname='adminroom' and branchid=(select branchid 

from 
branches where branchname='adminbranch'and companyid=(select companyid from companies where companyshortname='admincompany'))),'adminroom',1,(select 
creationdatetime from rooms where roomname='adminroom' and branchid=(select branchid from 
branches where branchname='adminbranch'and companyid=(select companyid from companies where companyshortname='admincompany'))));

8. Alter Query updating varchar size.

	alter table designations modify (designationname varchar(25));

	alter table designationlog modify (designationname varchar(25));


9. Creating Unique Constrainer.

	create table designations
		(
		designationid int primary key,
		designationname varchar(25) not null,
		companyid int not null,
		status int not null,
		createdby int,
		creationdatetime timestamp not null,
		foreign key(companyid) references companies(companyid),
		constraint designation_unique UNIQUE(designationname,companyid)
		);

10. Creating Unique Constrainer in existing Table.

	alter table departments
		add constraint departmentname_unique UNIQUE(departmentname,companyid);


11. Altering Column Properties in existing Table.

	ALTER TABLE <tablename>
		MODIFY (<columnname> <datatype> NOT NULL);

	Alter table companies
		modify (createdby number NOT NULL);

12. Creating ForeignKey in existing Table.

	alter table <tablename>
		add foreign key(columnname) references <tablename>(columnname),

	
	alter table companies
		add foreign key(createdby) references users(userid),


13. Update New Value On Exising Table

	update <TableName> set <ColumnName>='<NewValue>'

	update companies set createdby=(select userid from users where employeeid='adminuser');


14. List All Contrains from a Table

	SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = '<TableName_IN_CAPITAL_LETTER>';

	SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USERS';
		

15. Table Name Creation Constrains.

	1.Table Name shoud contains only 30 character.(Tablename length < 30)


16. Adding New column

	alter table <tablename> add (<columnname> <datatype>);

	alter table <tablename> add (description varchar(200));


17. Renaming Exiting Column

	alter table <tablname> rename column <oldcolumnname> to <newcolumnname>;

	alter table branches rename column pincode to postalcode;

18. To Find Service Name and SID Name

	select sys_context('userenv','db_name') from dual;	

	select ora_database_name from dual;
	
	select * from global_name;


19. Date Usage

	update users set joiningdate=to_date(current_date,'YYYY-MM-DD') where userid='1';

	select employeeid,To_CHAR(joiningdate,'YYYY-MM-DD HH:MI') from users;


20. Changing Password to User.

	Alter user <UserName> identified by <Password>;

	Alter user srinivasan identified by ibm;


21. Comparing String Data Time with Date Value

	select <ColumnName> from <TableName> where to_date(<DateColumnName>, 'DD-MM-YYYY')<to_date('"<Date>"', 'DD-MM-YYYY')";	

	select userid from users where companyid='"+companyID+"' and to_date(joiningdate, 'DD-MM-YYYY')<to_date('"15-11-2007"', 'DD-MM-YYYY')";

