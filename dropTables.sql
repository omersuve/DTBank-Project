-- Dropping tables by their dependency on each other, i.e. the
-- ones that are less dependent on others are dropped earlier.
DROP TABLE DatabaseManager
DROP TABLE User 
DROP TABLE Links 
DROP TABLE UniProt 
DROP TABLE SIDER 
DROP TABLE DrugBank 
DROP TABLE BindingDB