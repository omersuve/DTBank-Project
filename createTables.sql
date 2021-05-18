-- Creates BindingDB table and constraints on its attributes & specifying keys. 
-- Also creates references to other tables with common attributes.
CREATE TABLE BindingDB (
    reaction_id INTEGER NOT NULL,
    drugbank_id TEXT NOT NULL,
    uniprot_id TEXT NOT NULL,
    target_name TEXT NOT NULL,
    measure TEXT NOT NULL,
    affinity_nM REAL NOT NULL,
    doi TEXT NOT NULL,
    username TEXT NOT NULL,
    institution TEXT NOT NULL,
    PRIMARY KEY (reaction_id),
    FOREIGN KEY (drugbank_id)
        REFERENCES DrugBank
        ON DELETE NO ACTION
    FOREIGN KEY (uniprot_id)
        REFERENCES UniProt
        ON DELETE NO ACTION
    FOREIGN KEY (username, institution)
        REFERENCES User
        ON DELETE NO ACTION
);

-- Creates Links table and constraints on its attributes & specifying key.
CREATE TABLE Links (
    doi TEXT NOT NULL,
    authors TEXT NOT NULL,
    PRIMARY KEY (doi)
);

-- Creates DrugBank table and constraints on its attributes & specifying key.
CREATE TABLE DrugBank (
    drugbank_id TEXT NOT NULL,
    drug_name TEXT NOT NULL UNIQUE,
    drug_interactions TEXT NOT NULL,
    drug_description TEXT NOT NULL,
    smiles TEXT NOT NULL UNIQUE,
    PRIMARY KEY (drugbank_id)
);

-- Creates User table and constraints on its attributes & specifying key.
CREATE TABLE User (
    username TEXT NOT NULL,
    institution TEXT NOT NULL,
    user_password TEXT NOT NULL,
    PRIMARY KEY (username, institution)
);

-- Creates DatabaseManager table and constraints on its attributes & specifying key.
CREATE TABLE DatabaseManager (
    username TEXT NOT NULL,
    user_password TEXT NOT NULL,
    PRIMARY KEY (username)
);

-- Creates Trigger for DatabaseManager table to limit the maximum number of Database Managers to 5.
CREATE TRIGGER max5
   BEFORE INSERT ON DatabaseManager
BEGIN
   SELECT
      CASE
	    WHEN (SELECT COUNT(*) FROM DatabaseManager) == 5 THEN
   	    RAISE (ABORT,'Capacity reached!')
    END;
END;

-- Creates SIDER table and constraints on its attributes & specifying keys. 
-- Also creates reference to DrugBank table with common attribute.
CREATE TABLE SIDER (
    ulms_cui TEXT NOT NULL,
    drugbank_id TEXT NOT NULL,
    side_effecct_name TEXT NOT NULL,
    PRIMARY KEY (ulms_cui),
    FOREIGN KEY (drugbank_id)
        REFERENCES DrugBank
        ON DELETE CASCADE
);

-- Creates UniProt table and constraints on its attributes & specifying key.
CREATE TABLE UniProt (
    uniprot_id TEXT NOT NULL,
    prot_sequence TEXT NOT NULL,
    PRIMARY KEY (uniprot_id)
)